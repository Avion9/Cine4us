import 'package:get/get.dart';

class HoverController extends GetxController {
  RxBool isHovered = false.obs;
  void hoverOn() {
    isHovered.value = true;
  }

  void hoverOff() {
    isHovered.value = false;
  }
}
