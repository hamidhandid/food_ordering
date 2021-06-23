import 'package:alo_self/app/api/user/user_api.dart';
import 'package:alo_self/app/model/user_profile.dart';
import 'package:alo_self/app/modules/login/controllers/login_controller.dart';
import 'package:alo_self/app/modules/login/views/login_view.dart';
import 'package:alo_self/app/utils/custom_pair.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserHomeController extends GetxController {
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final areaController = TextEditingController().obs;
  final addressController = TextEditingController().obs;

  List<CustomPair<String, Rx<TextEditingController>>> get editProfileControllers => [
        CustomPair('First Name', firstNameController),
        CustomPair('Last Name', lastNameController),
        CustomPair('Area', areaController),
        CustomPair('Address', addressController),
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
        address: addressController.value.text,
      ),
    );
  }

  Future<UserProfile?> getProfile() async {
    final _api = UserApi();
    return await _api.getProfile();
  }
}
