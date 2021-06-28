import 'package:alo_self/app/api/user/user_api.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/model/user_profile.dart';
import 'package:alo_self/app/modules/login/controllers/login_controller.dart';
import 'package:alo_self/app/modules/login/views/login_view.dart';
import 'package:alo_self/app/common_widgets/custom_pair.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserHomeController extends GetxController {
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final areaController = TextEditingController().obs;
  // final addressController = TextEditingController().obs;
  final creditController =  MoneyMaskedTextController(
    precision: 0,
    decimalSeparator: '',
    thousandSeparator: ',',
    rightSymbol: ' تومان',
  ).obs;

  List<CustomPair<String, Rx<TextEditingController>>> get editProfileControllers => [
        CustomPair('نام', firstNameController),
        CustomPair('نام خانوادگی', lastNameController),
        CustomPair('دانشکده', areaController),
        CustomPair('اعتبار', creditController),
        // CustomPair('آدرس', addressController),
      ];

  final searchRestaurantName = TextEditingController().obs;
  final searchFoodName = TextEditingController().obs;
  final searchArea = TextEditingController().obs;

  List<CustomPair<String, Rx<TextEditingController>>> get searchControllers => [
        CustomPair('نام رستوران', searchRestaurantName),
        CustomPair('نام غذا', searchFoodName),
        CustomPair('نام منطقه', searchArea),
      ];

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

  Future<UserProfile?> editProfile() async {
    final _api = UserApi();
    return await _api.editProfile(
      UserProfile(
        first_name: firstNameController.value.text,
        last_name: lastNameController.value.text,
        area: areaController.value.text,
        credit: creditController.value.numberValue.toInt(),
        // address: addressController.value.text,
      ),
    );
  }

  Future<UserProfile?> getProfile() async {
    final _api = UserApi();
    return await _api.getProfile();
  }

  Future<List<Food>?> searchFoods() async {
    final _api = UserApi();
    final _search_result = await _api.searchFood(
      restaurantName: searchRestaurantName.value.text,
      foodName: searchFoodName.value.text,
      area: searchArea.value.text,
    );
    if (_search_result != null) {
      return _search_result.foods;
    } else {
      return <Food>[];
    }
  }
}
