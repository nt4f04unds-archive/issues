import 'package:flutter_test/flutter_test.dart';
import 'package:audio_service_issue/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(App());
  });
}
