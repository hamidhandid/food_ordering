import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
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
        title: 'Choose One Role',
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.green[700],
                onPressed: () async {
                  await GetStorage().write('type', 'User');
                  Get.lazyPut<LoginController>(
                    () => LoginController(),
                  );
                  await Get.to(() => LoginView());
                },
                child: _buildText('I Am a User'),
              ),
              SizedBox(height: 30),
              MaterialButton(
                color: Colors.green[700],
                onPressed: () async {
                  await GetStorage().write('type', 'Manager');
                  Get.lazyPut<LoginController>(
                    () => LoginController(),
                  );
                  await Get.to(() => LoginView());
                },
                child: _buildText('I Am a Manager'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
