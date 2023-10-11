import 'package:dwyl_app/data/repositories/image/image_repository.dart';
import 'package:http/http.dart' as http;

/// This class pertains to the Data Layer of the application.
/// It is used to store repositories that are used throughout the app.
class DataLayer<T> {
  final _map = <Type, T>{};
  void store<S extends T>(final S value) => _map[S] = value;
  T? lookup<S extends T>() => _map[S];
}

/// Creates a `DataLayer` object that holds the repositories within the app.
///
/// `isReleaseMode` is passed to point to real data sources or not.
DataLayer<Object> createDataLayer({
  required final bool isRelease,
}) {
  final layer = DataLayer<Object>();

  if (isRelease) {
    final httpClient = http.Client();

    layer.store<ImageRepository>(
      ImgupRepository(client: httpClient),
    );
  } else {
    /* 
    We can add mock repositories, like so:

      vault.store<ImageRepository>(
        FakeImageRepository()
      );

    Just create a fake repository class that returns mocked values instead of real ones in /lib/data/repositories/image/image_repository.dart
    */
  }

  return layer;
}
