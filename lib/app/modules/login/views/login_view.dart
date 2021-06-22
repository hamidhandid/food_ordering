import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.pageTitles_login.tr,
      ),
      body: FlutterLogin(
        onLogin: (LoginData loginData) {
          controller.emailField.value.text = loginData.name;
          controller.passField.value.text = loginData.password;
          return controller.login();
        },
        onRecoverPassword: (String pass) {
          return null;
        },
        onSignup: (LoginData loginData) {
          return null;
        },
        passwordValidator: (str) {
          if (str != null && str.length < 8) {
            return 'password must be at least 8 characters';
          }
          return null;
        },
        title: 'پرهام‌فود',
        hideForgotPasswordButton: true,
        hideSignUpButton: true,
        // showDebugButtons: true,
      ),
      // body: Container(
      //   // padding: EdgeInsets.all(30),
      //   // child: Center(
      //   //   child: Column(
      //   //     mainAxisAlignment: MainAxisAlignment.center,
      //   //     children: [
      //   //       TextField(
      //   //         controller: controller.emailField.value,
      //   //       ),
      //   //       SizedBox(height: 40),
      //   //       TextField(
      //   //         controller: controller.passField.value,
      //   //       ),
      //   //       SizedBox(height: 20),
      //   //       ElevatedButton(
      //   //         onPressed: () async {
      //   //           await controller.login();
      //   //         },
      //   //         child: Text('Submit'),
      //   //       ),
      //   //       SizedBox(height: 20),
      //   //     ],
      //   //   ),
      //   // ),
    );
  }
}
