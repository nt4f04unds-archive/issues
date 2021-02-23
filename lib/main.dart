import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

void main() {
  runApp(App());
  checkCache();
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Scaffold(
        body: Container(),
      ),
    );
  }
}

var secondsBetweenPulls = 120;
var stalePeriodInSeconds = 120;

Future<void> checkCache() async {
  var i = 0;
  while (i < 50) {
    CustomCacheManager.instance
        .getFileStream('https://via.placeholder.com/3', withProgress: false)
        .where((e) => e is FileInfo) 
        .forEach((element) {
      var fileInfo = element as FileInfo;
      print("${fileInfo.originalUrl} from: ${fileInfo.source}");
    });

    await Future.delayed(Duration(seconds: secondsBetweenPulls));
    i++;
  }
}

class CustomCacheManager {
  static const key = 'customCacheObject';
  static CacheManager instance = CacheManager(Config(key, 
    stalePeriod: Duration(seconds: stalePeriodInSeconds), maxNrOfCacheObjects: 1000
  ));
}