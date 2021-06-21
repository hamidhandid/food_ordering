import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.pageTitles_login.tr,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: controller.loginTextField.value,
              ),
              ElevatedButton(
                onPressed: () async => await controller.login(),
                child: Text(LocaleKeys.login_signIn.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
