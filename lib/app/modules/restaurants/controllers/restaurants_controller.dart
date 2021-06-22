import 'package:alo_self/app/api/restaurant/restaurant_api.dart';
import 'package:alo_self/app/model/restaurant.dart';
import 'package:get/get.dart';

class RestaurantsController extends GetxController {
  bool isLoading = false;
  List<Restaurant>? restaurants;
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

  Future<List<Restaurant>> getRestaurants() async {
    final api = RestaurantApi();
    isLoading = true;
    final _restaurants = await api.getAllRestaurants();
    isLoading = false;
    update();
    restaurants = _restaurants!.restaurants;
    return _restaurants.restaurants;
  }
}
