import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//Widgets
import 'package:movie_app/widgets/Custom_Tab.dart';
//Desktop Navigation controller 
class DesktopNavigationController extends GetxController {
  final CustomTab tab;
  final Widget content;

  DesktopNavigationController({required this.tab, required this.content});
}
