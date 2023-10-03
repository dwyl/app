import 'package:dwyl_app/blocs/blocs.dart';
import 'package:dwyl_app/main.dart';
import 'package:dwyl_app/presentation/views/views.dart';
import 'package:dwyl_app/presentation/widgets/editor/emoji_picker.dart';
import 'package:dwyl_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Bootstraps a sample main application, whether it [isWeb] or not.
  Widget initializeMainApp({required bool isWeb}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(create: (context) => ItemBloc()..add(ItemListStarted())),
        BlocProvider<AppCubit>(create: (context) => AppCubit(isWeb: isWeb)),
      ],
      child: const MainApp(),
    );
  }

  /// Check for context: https://stackoverflow.com/questions/60671728/unable-to-load-assets-in-flutter-tests
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
}
