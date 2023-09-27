import 'dart:ui_web' as web_ui;

/// Class used to `registerViewFactory` for web platforms.
///
/// Please check https://github.com/flutter/flutter/issues/41563#issuecomment-547923478 for more information.
class PlatformViewRegistry {
  static void registerViewFactory(String viewId, dynamic cb) {
    web_ui.platformViewRegistry.registerViewFactory(viewId, cb);
  }
}
