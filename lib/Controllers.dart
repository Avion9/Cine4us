import 'package:get/get.dart';
//Controllers
import 'package:movie_app/Controllers/Hover_Controller.dart';
import 'package:movie_app/Controllers/Tv_Show_controller.dart';
import 'package:movie_app/Controllers/movie_controller.dart';
import 'package:movie_app/Controllers/Screen_Controller.dart';

class Controllers extends Bindings {
  @override
  void dependencies() {
    Get.put(ScreenController());
    Get.put(MovieController());
    Get.put(ShowController());
    Get.put(HoverController());
  }
}
