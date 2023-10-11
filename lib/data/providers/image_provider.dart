import 'dart:convert';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:dwyl_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

const imageEndpoint = 'https://imgup.fly.dev/api/images';

/// Image data provider.
/// Meant to be invoked by the domain layer (repositories).
///
/// It will call the appropriate URL (in this case, it's `imgup`) to mainly upload images.
class ImageProvider {
  /// HTTP client used to make requests.
  final http.Client client;

  ImageProvider({required this.client});

  /// Uploads an image (as an array of [bytes]) to https://imgup.fly.dev/ and returns the appropriate response.
  Future<Either<RequestError, String>> uploadImage(Uint8List bytes, String filename) async {
    // Check if byte array is empty
    if (bytes.isEmpty) {
      return Left(RequestError(code: 404, description: 'Empty image. Make sure to select an image with content.'));
    }

    final request = http.MultipartRequest('POST', Uri.parse(imageEndpoint));

    final mimeType = lookupMimeType('', headerBytes: bytes);
    if(mimeType == null) {
      return Left(RequestError(code: 404, description: 'Invalid mimetype.'));
    }

    final httpImage =
        http.MultipartFile.fromBytes('image', bytes, contentType: MediaType.parse(lookupMimeType('', headerBytes: bytes)!), filename: filename);
    request.files.add(httpImage);

    // Check the response and handle accordingly
    return client.send(request).then((response) async {
      if (response.statusCode != 200) {
        return Left(RequestError(code: response.statusCode, description: response.toString()));
      }

      final responseStream = await http.Response.fromStream(response);
      final responseData = json.decode(responseStream.body);
      return Right(responseData['url']);
    });
  }
}
