import 'package:alo_self/app/theme/dark_theme.dart';
import 'package:alo_self/app/theme/light_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(
    GetMaterialApp(
      title: "AloSelf",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      translationsKeys: AppTranslation.translations,
      locale: Locale('fa', 'IR'),
      theme: LightTheme().themeData,
      darkTheme: DarkTheme().themeData,
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<void> initServices() async {
  await GetStorage.init();
}
