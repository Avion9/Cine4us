import 'package:flutter/material.dart';

class CustomTabbar extends StatelessWidget {
  final TabController controller;
  final List<Widget> tabs;

  const CustomTabbar({Key? key, required this.controller, required this.tabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabbarScalling = screenWidth > 1400
        ? 0.25
        : screenWidth > 1100
            ? 0.3
            : 0.41;
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.02, top: 8),
      child: SizedBox(
        width: screenWidth * tabbarScalling,
        child: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: TabBar(
            controller: controller,
            tabs: tabs,
            indicatorColor: const Color.fromRGBO(110, 190, 196, 1),
          ),
        ),
      ),
    );
  }
}
