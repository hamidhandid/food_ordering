import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:alo_self/app/modules/delivery/bindings/delivery_binding.dart';
import 'package:alo_self/app/modules/delivery/views/delivery_view.dart';
import 'package:alo_self/app/modules/history/bindings/history_binding.dart';
import 'package:alo_self/app/modules/history/views/history_view.dart';
import 'package:alo_self/app/modules/home/bindings/home_binding.dart';
import 'package:alo_self/app/modules/home/views/home_view.dart';
import 'package:alo_self/app/modules/login/bindings/login_binding.dart';
import 'package:alo_self/app/modules/login/views/login_view.dart';
import 'package:alo_self/app/modules/profile/bindings/profile_binding.dart';
import 'package:alo_self/app/modules/profile/views/profile_view.dart';
import 'package:alo_self/app/modules/request/bindings/request_binding.dart';
import 'package:alo_self/app/modules/request/views/request_view.dart';
import 'package:alo_self/app/modules/setting/bindings/setting_binding.dart';
import 'package:alo_self/app/modules/setting/views/setting_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final INITIAL = GetStorage().read("token") != null ? Routes.HOME : Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY,
      page: () => DeliveryView(),
      binding: DeliveryBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST,
      page: () => RequestView(),
      binding: RequestBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
  ];
}
