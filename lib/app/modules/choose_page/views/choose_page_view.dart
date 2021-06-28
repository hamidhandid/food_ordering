import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/app/common_widgets/custom_button.dart';
import 'package:alo_self/app/modules/login/controllers/login_controller.dart';
import 'package:alo_self/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/choose_page_controller.dart';

class ChoosePageView extends GetView<ChoosePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showLogoutAction: false,
        title: 'نقش خود را انتخاب کنید',
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                buttonOnPressed: () async {
                  await GetStorage().write('type', 'User');
                  Get.lazyPut<LoginController>(
                    () => LoginController(),
                  );
                  await Get.to(() => LoginView());
                },
                buttonText: 'دانشجو هستم',
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 30),
              CustomButton(
                buttonOnPressed: () async {
                  await GetStorage().write('type', 'Manager');
                  Get.lazyPut<LoginController>(
                    () => LoginController(),
                  );
                  await Get.to(() => LoginView());
                },
                buttonText: 'مدیر سلف هستم',
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
