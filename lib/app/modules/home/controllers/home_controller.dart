import 'package:alo_self/app/api/restaurant/restaurant_api.dart';
import 'package:alo_self/app/model/restaurant.dart';
import 'package:alo_self/app/modules/login/controllers/login_controller.dart';
import 'package:alo_self/app/modules/login/views/login_view.dart';
import 'package:alo_self/app/common_widgets/custom_pair.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final nameController = TextEditingController().obs;
  final areaController = TextEditingController().obs;
  // final addressController = TextEditingController().obs;
  final serviceAreasController = TextEditingController().obs;
  final workHourController = TextEditingController().obs;
  final deliverCostController = MoneyMaskedTextController(
    precision: 0,
    decimalSeparator: '',
    thousandSeparator: ',',
    rightSymbol: ' تومان',
  ).obs;
  List<CustomPair<String, Rx<TextEditingController>>> get addRestaurantControllers => [
        CustomPair('نام', nameController),
        CustomPair('محل', areaController),
        // CustomPair('آدرس', addressController),
        CustomPair('دانشکده‌های پیشتیبانی', serviceAreasController),
        CustomPair('ساعات کاری', workHourController),
        CustomPair('هزینه ثابت ارسال غذا', deliverCostController),
      ];

  final restaurantApi = RestaurantApi();

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

  Future<void> logout() async {
    await GetStorage().remove('token');
    Get.lazyPut<LoginController>(() => LoginController());
    await Get.offAll(() => LoginView());
    update();
  }

  Future<Restaurant?> addRestaurant() async {
    final _res = await restaurantApi.addRestaurant(
      name: nameController.value.text,
      area: areaController.value.text,
      // address: addressController.value.text,
      service_areas: [serviceAreasController.value.text],
      work_hour: workHourController.value.text,
      deliver_cost: deliverCostController.value.numberValue.toInt(),
    );

    return _res;
  }
}
