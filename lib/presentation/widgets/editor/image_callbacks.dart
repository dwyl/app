import 'dart:async';
import 'dart:io';

import 'package:dwyl_app/data/repositories/repositories.dart';
import 'package:dwyl_app/logging/logging.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// Receives a file [file], copies it to the app's documents directory and returns the path of the copied file.
Future<String> onImagePickCallback(File file) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final copiedFile = await file.copy('${appDocDir.path}/${basename(file.path)}');
  return copiedFile.path.toString();
}

/// Opens gallery (on mobile) or file explorer (on web).
/// Upon picking an image, it is uploaded and the URL of where the image is hosted is returned.
///
/// Returns `null` if no image was picked or the image was not correctly uploaded.
Future<String?> webImagePickImpl(ImageRepository imageRepository, ImageFilePicker filePicker, OnImagePickCallback onImagePickCallback) async {
  // Lets the user pick one file; files with any file extension can be selected
  final result = await filePicker.pickImage();

  // The result will be null, if the user aborted the dialog
  if (result == null || result.files.isEmpty) {
    return null;
  }

  // Read file as bytes (https://github.com/miguelpruivo/flutter_file_picker/wiki/FAQ#q-how-do-i-access-the-path-on-web)
  final platformFile = result.files.first;
  final bytes = platformFile.bytes;

  if (bytes == null) {
    return null;
  }

  final uploadRet = await imageRepository.uploadImage(bytes, platformFile.name);
  return uploadRet.fold(
    (error) {
      logError('Error uploading image: \n${error.toString()}');
      return null;
    },
    (r) => r,
  );
}

// coverage:ignore-start
/// Image file picker wrapper class
class ImageFilePicker {
  Future<FilePickerResult?> pickImage() => FilePicker.platform.pickFiles(type: FileType.image);
}
// coverage:ignore-end
