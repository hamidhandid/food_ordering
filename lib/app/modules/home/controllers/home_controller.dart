import 'package:get/get.dart';

class HomeController extends GetxController {  
  var navBarIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void updateIndex(int index) {
    navBarIndex.value = index;
  }
}
