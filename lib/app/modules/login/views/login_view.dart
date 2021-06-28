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
        title: _isUser ? 'ورود دانشجو' : 'ورود مدیر',
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
                return 'شماره موبایل معتبر نیست';
              }
            : FlutterLogin.defaultEmailValidator,
        passwordValidator: (str) {
          if (str != null && str.length < 8) {
            return 'رمزعبور حداقل باید ۸ رقم باشد';
          }
          return null;
        },
        title: 'الوسلف',
        hideForgotPasswordButton: true,
        messages: LoginMessages(
          userHint: _isUser ? 'شماره موبایل' : 'ایمیل',
          passwordHint: 'رمزعبور',
          loginButton: 'ورود',
          signupButton: 'ثبت‌نام',
          confirmPasswordHint: 'تایید رمزعبور',
          confirmPasswordError: 'رمزعبور تایید شده با رمزعبور مطابقت ندارد'
        ),
      ),
    );
  }
}
