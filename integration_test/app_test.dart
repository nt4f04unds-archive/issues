import 'package:android_content_provider/android_content_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_96739/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  test("update", () async {
    print('call update');
    final result = await AndroidContentResolver.instance.update(
      uri: providerUri,
    );
    print('done !');
    expect(result, 2);
  });
}
