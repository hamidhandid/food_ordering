import 'package:alo_self/app/theme/dark_theme.dart';
import 'package:alo_self/app/theme/light_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initServices();
  runApp(
    GetMaterialApp(
      title: "Parham Food",
      initialRoute: !(await _isLoggedIn())
          ? Routes.CHOOSE_PAGE
          : (GetStorage().read('type') == 'User')
              ? Routes.USER_HOME
              : Routes.HOME,
      getPages: AppPages.routes,
      translationsKeys: AppTranslation.translations,
      locale: Locale('en', 'US'),
      theme: LightTheme().themeData,
      darkTheme: DarkTheme().themeData,
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<void> _initServices() async {
  await GetStorage.init();
}

Future<bool> _isLoggedIn() async {
  return GetStorage().hasData('token');
}
