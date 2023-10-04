import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dwyl_app/presentation/widgets/editor/image_callbacks.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'image_callbacks_test.mocks.dart';

/// Class that is used to override the `getApplicationDocumentsDirectory()` function.
class FakePathProviderPlatform extends PathProviderPlatform implements Fake {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    // Make sure is the same folder used in the tests.
    return 'assets';
  }
}

/// File mock (overrides `dart.io`)
/// Visit https://api.flutter.dev/flutter/dart-io/IOOverrides-class.html for more information
/// and https://stackoverflow.com/questions/64031671/flutter-readasbytes-readasstring-in-widget-tests for context on why `readAsBytes` is skipped on tests.
/// This is used to mock the `File` class (useful for `readAsBytes`)
class FileMock extends MockFile {
  @override
  Future<Uint8List> readAsBytes() {
    final bytes = Uint8List(0);
    return Future<Uint8List>.value(bytes);
  }

  @override
  String get path => 'some_path.png';
}

@GenerateMocks([http.Client, ImageFilePicker, File])
void main() {
  /// Check for context: https://stackoverflow.com/questions/60671728/unable-to-load-assets-in-flutter-tests
  setUp(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test('`onImagePickCallback` should return path of a given file.', () async {
    final file = File('assets/sample.jpeg');
    final path = await onImagePickCallback(file);

    // Some time must have passed
    expect(path == 'assets/sample.jpeg', true);
  });

  testWidgets('`webImagePickImpl` should return the URL of the uploaded image on success (200).', (WidgetTester tester) async {
    /// We are overriding the `IO` because `readAsBytes` is skipped on tests.
    /// We use the mocked file so the test can be executed correctly.
    IOOverrides.runZoned(
      () async {
        // Mocks
        final clientMock = MockClient();
        final filePickerMock = MockImageFilePicker();

        // Set mock behaviour for `filePickerMock` with jpeg magic number byte array https://gist.github.com/leommoore/f9e57ba2aa4bf197ebc5
        final listMockFiles = <PlatformFile>[
          PlatformFile(name: 'image.png', size: 200, path: 'some_path', bytes: Uint8List.fromList([0xff, 0xd8, 0xff, 0xe0])),
        ];

        // Set mock behaviour for image returned from the picker
        when(filePickerMock.pickImage()).thenAnswer((_) async => Future<FilePickerResult?>.value(FilePickerResult(listMockFiles)));

        // Set mock behaviour for `requestMock`
        const body = '{"url":"return_url"}';
        final bodyBytes = utf8.encode(body);
        when(clientMock.send(any)).thenAnswer((_) async => http.StreamedResponse(Stream<List<int>>.fromIterable([bodyBytes]), 200));

        // With the request being "200", we should expect the return URL be the same as the one defined in the mock body.
        final urlResponse = await webImagePickImpl(
          clientMock,
          filePickerMock,
          (file) => Future.value(''),
        );

        expect(urlResponse == 'return_url', true);
      },
      createFile: (_) => FileMock(),
    );
  });
}
