import 'package:alo_self/app/api/manager/manager_api.dart';
import 'package:alo_self/app/modules/home/controllers/home_controller.dart';
import 'package:alo_self/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final emailField = TextEditingController().obs;
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
    final api = ManagerApi();
    final res = await api.login(emailField.value.text, passField.value.text);
    if (res != null) {
      await GetStorage().write('token', res.token);
      update();
      Get.lazyPut<HomeController>(
        () => HomeController(),
      );
      await Get.offAll(() => HomeView());
      return 'success';
    }
    return 'failure';
  }

  Future<String> signup() async {
    final api = ManagerApi();
    final res = await api.signup(emailField.value.text, passField.value.text);
    if (res != null) {
      await GetStorage().write('token', res.token);
      update();
      Get.lazyPut<HomeController>(
        () => HomeController(),
      );
      await Get.offAll(() => HomeView());
      return 'success';
    }
    return 'failure';
  }
}
