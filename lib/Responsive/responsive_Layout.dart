import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;
  final Widget? tabletBody;

  const ResponsiveLayout(
      {Key? key,
      required this.mobileBody,
      required this.desktopBody,
      this.tabletBody})
      : super(key: key);

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktopBody;
        } else if (constraints.maxWidth >= 800) {
          return tabletBody ?? mobileBody;
        } else {
          return mobileBody;
        }
      },
    );
  }
}
