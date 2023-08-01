import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
//Pages
import 'package:movie_app/New_Pages/All_in_Movies.dart';
import 'package:movie_app/New_Pages/Film_Page.dart';
import 'package:movie_app/New_Pages/Tv_Shows_Page.dart';

//Controlling the screen based on the Tab Menu and initialize the Home Screen
class ScreenController extends GetxController {
  var currentTab = 0;
  List<Widget> screenHistory = [];
  List<Widget> screens = [
    FilmPage(),
    ShowPage(),
    const AllMovies(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = FilmPage();

  void setCurrentScreen(Widget screen, var tab) {
    screenHistory.add(currentScreen);
    currentScreen = screen;
    currentTab = tab;
    update();
  }

  void setinitialState(Widget screen) async {
    currentScreen = screen;
    update();
  }
}
