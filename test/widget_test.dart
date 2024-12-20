// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:thingsboard_app/locator.dart';
import 'package:thingsboard_app/main.dart';

const kTemporaryPath = 'temporaryPath';
const kApplicationSupportPath = 'applicationSupportPath';
const kDownloadsPath = 'downloadsPath';
const kLibraryPath = 'libraryPath';
const kApplicationDocumentsPath = 'applicationDocumentsPath';
const kExternalCachePath = 'externalCachePath';
const kExternalStoragePath = 'externalStoragePath';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    FlutterSecureStorage.setMockInitialValues({});
    PathProviderPlatform.instance = FakePathProviderPlatform();

    await Hive.initFlutter();
    await setUpRootDependencies();
  });

  testWidgets('ThingsboardApp base test', (tester) async {
    // Build our app and trigger a frame.
    await tester.runAsync(() => tester.pumpWidget(const ThingsboardApp()));

    expect(
      find.byWidgetPredicate((widget) {
        if (widget is MaterialApp) {
          return widget.title == 'ThingsBoard CE App';
        }

        return false;
      }),
      findsOneWidget,
    );
  });
}

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return kDownloadsPath;
  }
}
