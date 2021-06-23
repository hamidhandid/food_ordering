import 'package:alo_self/app/common_widgets/custom_app_bar.dart';
import 'package:alo_self/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final _isUser = GetStorage().read('type') == 'User';
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.pageTitles_login.tr,
        showLogoutAction: false,
      ),
      body: FlutterLogin(
        onLogin: (LoginData loginData) {
          controller.emailOrMobileNumberField.value.text = loginData.name;
          controller.passField.value.text = loginData.password;
          return controller.login();
        },
        onRecoverPassword: (String pass) {
          return null;
        },
        onSignup: (LoginData loginData) {
          controller.emailOrMobileNumberField.value.text = loginData.name;
          controller.passField.value.text = loginData.password;
          return controller.signup();
        },
        userValidator: _isUser
            ? (str) {
                if (str != null && str.length == 11 && str.startsWith('09')) {
                  return null;
                }
                return 'Mobile Number is not valid';
              }
            : FlutterLogin.defaultEmailValidator,
        passwordValidator: (str) {
          if (str != null && str.length < 8) {
            return 'password must be at least 8 characters';
          }
          return null;
        },
        title: 'Parham Food',
        hideForgotPasswordButton: true,
        messages: LoginMessages(
          userHint: _isUser ? 'Mobile Number' : 'Email',
        ),
      ),
    );
  }
}
