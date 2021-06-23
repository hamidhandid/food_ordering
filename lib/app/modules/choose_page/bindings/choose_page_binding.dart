import 'package:get/get.dart';

import '../controllers/choose_page_controller.dart';

class ChoosePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoosePageController>(
      () => ChoosePageController(),
    );
  }
}
