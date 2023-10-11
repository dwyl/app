import 'package:dwyl_app/blocs/data/data_cubit.dart';
import 'package:dwyl_app/core/core.dart';
import 'package:dwyl_app/data/repositories/repositories.dart';
import 'package:dwyl_app/logging/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'blocs/blocs.dart';

// coverage:ignore-start
void main() {
  // Setting global log bloc observer and Lumberdash
  Bloc.observer = GlobalLogBlocObserver();
  putLumberdashToWork(withClients: [ColorizeLumberdash()]);

  // Creating data layer
  final dataLayer = createDataLayer(isRelease: true);

  // Wraps the application with:
  // - Repository Provider: to access the repositories for the data layer.
  // - Bloc Providers: to access the blocs for the application.
  runApp(
    RepositoryProvider<DataLayer>(
      create: (context) => dataLayer,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ItemBloc>(create: (context) => ItemBloc()..add(ItemListStarted())),
          BlocProvider<AppCubit>(create: (context) => AppCubit(isWeb: kIsWeb)),
          BlocProvider<DataCubit>(create: (context) => DataCubit(imageRepository: dataLayer.lookup<ImageRepository>() as ImageRepository)),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
// coverage:ignore-end