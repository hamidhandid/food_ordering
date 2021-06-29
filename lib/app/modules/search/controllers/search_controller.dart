import 'package:alo_self/app/api/order/order_api.dart';
import 'package:alo_self/app/api/user/user_api.dart';
import 'package:alo_self/app/common_widgets/custom_snackbar.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/model/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchController extends GetxController {
  final foodsToOrder = <Food>[].obs;

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

  Future<Order?> addOrder(
    int fixedCost,
  ) async {
    final _api = OrderApi();
    final _profile = await UserApi().getProfile();
    final _userId = _profile!.id;
    print(_userId);
    if (_profile.credit! >= (foodsToOrder.fold<int>(0, (int previousValue, el) => previousValue + el.cost) + fixedCost)) {
      final _res = await _api.addOrder(
        _userId!,
        foods: foodsToOrder.value,
      );
      return _res;
    } else {
      CustomSnackBar.show(
        'ناموفق',
        'شما اعتبار کافی برای این سفارش را ندارید',
        backgroundColor: Colors.red[500],
      );
    }
  }
}
