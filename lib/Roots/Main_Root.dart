//Utils
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//Controllers
import 'package:movie_app/Controllers/Desktop_Navigation_Controller.dart';
import 'package:movie_app/Controllers/Screen_Controller.dart';
//Pages
import 'package:movie_app/New_Pages/All_in_Movies.dart';
import 'package:movie_app/New_Pages/Film_Page.dart';
import 'package:movie_app/New_Pages/Tv_Shows_Page.dart';
//Responsive
import 'package:movie_app/Responsive/responsive_Layout.dart';
//Widgets
import 'package:movie_app/widgets/Background.dart';
import 'package:movie_app/widgets/Custom_Tab.dart';
import 'package:movie_app/widgets/Custom_Tab_Bar.dart';

class Root extends StatefulWidget {
  Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => Home_State();
}

class Home_State extends State<Root> with TickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late double screenHeight;
  late double screenWidth;
  late TabController tabController;

  final screenM = Get.put(ScreenController());

  List<DesktopNavigationController> screens = [
    DesktopNavigationController(
      tab: const CustomTab(
          title: "Home",
          icon: Icon(
            Icons.home_filled,
            color: Colors.white,
          )),
      content: ResponsiveLayout(
        mobileBody: GetBuilder<ScreenController>(
          init: ScreenController(),
          builder: (controller) => PageStorage(
            bucket: controller.bucket,
            child: controller.currentScreen,
          ),
        ),
        desktopBody: GetBuilder<ScreenController>(
          init: ScreenController(),
          builder: (controller) => controller.currentScreen,
        ),
      ),
    ),
    DesktopNavigationController(
      tab: const CustomTab(
        title: "Movies",
        icon: Icon(Icons.video_collection_rounded, color: Colors.white),
      ),
      content: ResponsiveLayout(
        mobileBody: GetBuilder<ScreenController>(
          init: ScreenController(),
          builder: (controller) => PageStorage(
            bucket: controller.bucket,
            child: controller.currentScreen,
          ),
        ),
        desktopBody: GetBuilder<ScreenController>(
          init: ScreenController(),
          builder: (controller) => controller.currentScreen,
        ),
      ),
    ),
    DesktopNavigationController(
      tab: const CustomTab(
          title: "TV Shows", icon: Icon(Icons.tv, color: Colors.white)),
      content: ResponsiveLayout(
        mobileBody: GetBuilder<ScreenController>(
          init: ScreenController(),
          builder: (controller) => PageStorage(
            bucket: controller.bucket,
            child: controller.currentScreen,
          ),
        ),
        desktopBody: GetBuilder<ScreenController>(
          init: ScreenController(),
          builder: (controller) => controller.currentScreen,
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: screens.length, vsync: this);
    tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (tabController.indexIsChanging) {
      if (tabController.index == 0) {
        screenM.setCurrentScreen(FilmPage(), 0);
      } else if (tabController.index == 1) {
        screenM.setCurrentScreen(const AllMovies(), 1);
      } else if (tabController.index == 2) {
        screenM.setCurrentScreen(ShowPage(), 2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      endDrawer: drawer(),
      key: scaffoldKey,
      body: Stack(
        children: [
          const Background(),
          ResponsiveLayout(mobileBody: MobileView(), desktopBody: DesktopView())
        ],
      ),
    );
  }

  Widget DesktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: SizedBox(
                  child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  const CircleAvatar(
                    radius: 33,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage("assets/Images/logo.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 65,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: DefaultTextStyle(
                        style: GoogleFonts.reemKufiFun(
                          fontSize: 45,
                          color: Colors.white,
                          shadows: [
                            const Shadow(
                              blurRadius: 7.0,
                              color: Color.fromRGBO(110, 190, 196, 1),
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: GetBuilder<ScreenController>(
                          init: ScreenController(),
                          builder: (controller) => AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              FlickerAnimatedText(
                                '',
                                speed: const Duration(microseconds: 1),
                              ),
                              FlickerAnimatedText('Cine4u'),
                              FlickerAnimatedText("Cine4us"),
                            ],
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ),
            CustomTabbar(
              controller: tabController,
              tabs: screens.map((e) => e.tab).toList(),
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.91,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: screens.map((e) => e.content).toList(),
          ),
        ),
      ],
    );
  }

  Widget MobileView() {
    return SizedBox(
      width: screenWidth,
      child: Stack(
        children: [
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: screens.map((e) => e.content).toList()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: SizedBox(
                    child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      child: ClipOval(
                        child: Image(
                          image: AssetImage("assets/Images/logo.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60, top: 4),
                        child: DefaultTextStyle(
                          style: GoogleFonts.reemKufiFun(
                            fontSize: 40,
                            color: Colors.white,
                            shadows: [
                              const Shadow(
                                blurRadius: 7.0,
                                color: Color.fromRGBO(110, 190, 196, 1),
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          child: GetBuilder<ScreenController>(
                            init: ScreenController(),
                            builder: (controller) => AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FlickerAnimatedText(
                                    '',
                                    speed: const Duration(microseconds: 1),
                                  ),
                                  FlickerAnimatedText('Cine4u'),
                                  FlickerAnimatedText("Cine4us"),
                                ],
                                onTap: () {
                                  Get.toNamed('/');
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              IconButton(
                highlightColor: Colors.black,
                iconSize: screenWidth > 700 ? 50 : screenWidth * 0.07,
                onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      width: screenWidth * 0.3,
      backgroundColor: Colors.black,
      child: GetBuilder<ScreenController>(
        init: ScreenController(),
        builder: (controller) => ListView(
          children: [
                Container(
                  height: screenHeight * 0.1,
                ),
              ] +
              screens.map((e) {
                return Container(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    title: Row(
                      children: [
                        SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: e.tab.icon,
                        ),
                        Text(
                          e.tab.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    selectedTileColor: const Color.fromRGBO(110, 190, 196, 1),
                    splashColor: const Color.fromRGBO(110, 190, 196, 1),
                    onTap: () {
                      tabController.animateTo(
                          screens.indexOf(e)); // Switch to the selected tab
                      scaffoldKey.currentState?.closeEndDrawer();
                      // Close the drawer
                    },
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
