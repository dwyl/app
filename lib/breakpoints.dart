import 'package:flutter/material.dart';

// Breakpoints for each device.
const kMobileBreakpoint = 425.0;
const kTabletBreakpoint = 768.0;
const kDesktopBreakpoint = 1024.0;
const kDesktopLargeBreakpoint = 1440.0;

/// Widget which will change the children rendered according to the device dimensions.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget? desktopBody;

  const ResponsiveLayout(
      {super.key, required this.mobileBody, this.tabletBody, this.desktopBody});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(builder: (_, __) {
      if (deviceWidth < kMobileBreakpoint) {
        return mobileBody;
      } else if (deviceWidth < kTabletBreakpoint) {
        return tabletBody ?? mobileBody;
      } else {
        return desktopBody ?? tabletBody ?? mobileBody;
      }
    });
  }
}
