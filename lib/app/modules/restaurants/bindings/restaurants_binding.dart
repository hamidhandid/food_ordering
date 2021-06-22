import 'package:get/get.dart';

import '../controllers/restaurants_controller.dart';

class RestaurantsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantsController>(
      () => RestaurantsController(),
    );
  }
}
