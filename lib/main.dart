import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

late AudioPlayerHandler handler;

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  binding.addObserver(_WidgetsBindingObserver());
  setUi();
  handler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelName: 'Audio Service Demo',
      androidNotificationOngoing: true,
      androidEnableQueue: true,
    ),
  );
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            if (handler._player.playing)
              handler.stop();
            else 
              handler.play();
          },
        )
      ),
    ),
  ));
}


var lastUi = SystemUiOverlayStyle.dark.copyWith(
  statusBarColor: Colors.red,
  systemNavigationBarColor: Colors.red,
  systemNavigationBarDividerColor: Colors.red,
);

void setUi([SystemUiOverlayStyle? ui]) {
  if (ui != null) {
    lastUi = ui;
  }
  SystemChrome.setSystemUIOverlayStyle(lastUi);
}

class _WidgetsBindingObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      /// This ensures that proper UI will be applied when activity is resumed.
      /// 
      /// Generally i used this to workaround the https://github.com/flutter/flutter/issues/21265.
      
      // setUi();

      /// This bug from Flutter I listed above happens quite rarely, but with audio_service,
      /// the UI simply is not getting restored at all when the service is running and you reopen the activity.
      /// 
      /// Moreover, the fix that I do above doesn't work, because any call to [SystemChrome.setSystemUIOverlayStyle]
      /// will be simply inored, unless you change it in some way.
      /// 
      /// So, to workaround that, I have to do the following instead:
      setUi(lastUi.copyWith(
        statusBarBrightness: lastUi.statusBarBrightness == Brightness.dark || lastUi.statusBarBrightness == null
          ? Brightness.light
          : Brightness.dark
      ));
    }
  }
}

class AudioPlayerHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  AudioPlayerHandler() {
    _init();
  }

  final _player = AudioPlayer();
  final items = [
    MediaItem(
      id: '1',
      album: '',
      title: '1',
    ),
    MediaItem(
      id: '2',
      album: '',
      title: '2',
    ),
    MediaItem(
      id: '3',
      album: '',
      title: '3',
    ),
  ];

  int index = 0;

  Future<void> _prepare() async {
    _player.setUrl('https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3');
  }

  Future<void> _init() async {
    queue.add(items);
    _prepare();
    _player.playbackEventStream.listen(_setState);
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) stop();
    });
  }

  @override
  Future<List<MediaItem>> getChildren(String parentMediaId, [Map<String, dynamic>? options]) async {
    switch (parentMediaId) {
      case AudioService.recentRootId:
      default:
        return items;
    }
  }

  @override
  ValueStream<Map<String, dynamic>> subscribeToChildren(String parentMediaId) {
    switch (parentMediaId) {
      case AudioService.recentRootId:
      default:
        return Stream.value(items).map((_) => {}) as ValueStream<Map<String, dynamic>>;
    }
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index >= 0 && index < queue.value!.length) {
      _prepare();
      this.index = index;
      mediaItem.add(queue.value![index]);
    }
  }

  @override
  Future<void> skipToNext() async {
    skipToQueueItem(index + 1);
  }

  @override
  Future<void> skipToPrevious() async {
    skipToQueueItem(index - 1);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  void _setState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(playbackState.value!.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: _player.processingState == ProcessingState.idle
        ? AudioProcessingState.idle
        : AudioProcessingState.ready,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    ));
  }
}
