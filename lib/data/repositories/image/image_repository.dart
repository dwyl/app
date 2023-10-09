import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dwyl_app/data/providers/providers.dart' as providers;
import 'package:dwyl_app/models/models.dart';
import 'package:http/http.dart' as http;

abstract class ImageRepository {
  Future<Either<RequestError, void>> uploadImage(Uint8List bytes, String filename);
}

/// Image repository (part of Domain Layer)
/// Meant to be invoked by the application layer (presentation and blocs),
/// it will call the appropriate Image Data Provider to deal with images.
class ImgupRepository implements ImageRepository {
  final http.Client client;

  ImgupRepository({required this.client});

  @override
  Future<Either<RequestError, void>> uploadImage(Uint8List bytes, String filename) async {
    return providers.ImageProvider(client: client).uploadImage(bytes, filename);
  }
}
