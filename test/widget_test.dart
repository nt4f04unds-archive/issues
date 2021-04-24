import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio_385/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(App());
  });
}
