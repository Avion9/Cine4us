//Utils
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/Utils/Splash_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Controllers
import 'package:movie_app/Controllers.dart';
//Root
import 'package:movie_app/Roots/Main_Root.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: dotenv.get('apiKey'),
          databaseURL: dotenv.get('databaseURL'),
          projectId: dotenv.get('projectId'),
          storageBucket: dotenv.get('storageBucket'),
          messagingSenderId: dotenv.get('messagingSenderId'),
          appId: dotenv.get('appId')));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(builder: (context, snapshot) {
      return GetMaterialApp(
        initialBinding: Controllers(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
        ),
        initialRoute: '/Splash',
        getPages: [
          GetPage(
              name: '/Splash',
              page: () => SplashPage(
                    key: UniqueKey(),
                    onIntializationComplete: () {
                      Get.offNamedUntil('/', (route) => false);
                    },
                  )),
          GetPage(name: '/', page: () => Root()),
        ],
      );
    });
  }
}
