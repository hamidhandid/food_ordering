import 'package:alo_self/app/api/order/order_api.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/model/order.dart';
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

  Future<Order?> addOrder() async {
    final _api = OrderApi();
    final _res = await _api.addOrder(
      GetStorage().read('userId'),
      foods: foodsToOrder,
    );
    return _res;
  }
}
