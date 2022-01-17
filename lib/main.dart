import 'package:android_content_provider/android_content_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

const providerUri = 'content://${MyAndroidContentProvider.providerAuthority}';

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

@pragma('vm:entry-point')
void exampleContentProviderEntrypoint() {
  MyAndroidContentProvider();
}

class MyAndroidContentProvider extends AndroidContentProvider {
  MyAndroidContentProvider() : super(providerAuthority);

  static const providerAuthority = 'com.example.myapp.MyAndroidContentProvider';

  @override
  Future<int> delete(
    String uri,
    String? selection,
    List<String>? selectionArgs,
  ) async {
    return 0;
  }

  @override
  Future<String?> getType(String uri) async {
    return null;
  }

  @override
  Future<String?> insert(String uri, ContentValues? values) async {
    return null;
  }

  @override
  Future<CursorData?> query(
    String uri,
    List<String>? projection,
    String? selection,
    List<String>? selectionArgs,
    String? sortOrder,
  ) async {
    return null;
  }

  @override
  Future<int> update(
    String uri,
    ContentValues? values,
    String? selection,
    List<String>? selectionArgs,
  ) async {
    return 2;
  }
}