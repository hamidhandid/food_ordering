import 'package:alo_self/app/api/manager/manager_api.dart';
import 'package:alo_self/app/api/user/user_api.dart';
import 'package:alo_self/app/modules/home/controllers/home_controller.dart';
import 'package:alo_self/app/modules/home/views/home_view.dart';
import 'package:alo_self/app/modules/user_home/controllers/user_home_controller.dart';
import 'package:alo_self/app/modules/user_home/views/user_home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final emailOrMobileNumberField = TextEditingController().obs;
  final passField = TextEditingController().obs;

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

  Future<String> login() async {
    late final api;
    final _isUser = GetStorage().read('type') == 'User';
    if (_isUser) {
      api = UserApi();
    } else {
      ManagerApi();
    }
    final res = await api.login(emailOrMobileNumberField.value.text, passField.value.text);
    if (res != null) {
      await GetStorage().write('token', res.token);
      update();

      if (_isUser) {
        Get.lazyPut<UserHomeController>(
          () => UserHomeController(),
        );
        await Get.offAll(() => UserHomeView());
      } else {
        Get.lazyPut<HomeController>(
          () => HomeController(),
        );
        await Get.offAll(() => HomeView());
      }

      return 'success';
    }
    return 'failure';
  }

  Future<String> signup() async {
    late final api;
    final _isUser = GetStorage().read('type') == 'User';
    if (_isUser) {
      api = UserApi();
    } else {
      ManagerApi();
    }
    final res = await api.signup(emailOrMobileNumberField.value.text, passField.value.text);
    if (res != null) {
      await GetStorage().write('token', res.token);
      update();
      
      if (_isUser) {
        Get.lazyPut<UserHomeController>(
          () => UserHomeController(),
        );
        await Get.offAll(() => UserHomeView());
      } else {
        Get.lazyPut<HomeController>(
          () => HomeController(),
        );
        await Get.offAll(() => HomeView());
      }
  
      return 'success';
    }
    return 'failure';
  }
}
