import 'package:alo_self/app/api/restaurant/food_api.dart';
import 'package:alo_self/app/api/restaurant/restaurant_api.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/model/restaurant.dart';
import 'package:alo_self/app/common_widgets/custom_pair.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantsController extends GetxController {
  final isLoading = false.obs;
  RxList<Restaurant?> restaurants = RxList<Restaurant?>();

  final nameController = TextEditingController().obs;
  final areaController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final serviceAreasController = TextEditingController().obs;
  final workHourController = TextEditingController().obs;
  final deliverCostController = MoneyMaskedTextController(
    precision: 0,
    decimalSeparator: '',
    thousandSeparator: ',',
    rightSymbol: ' تومان',
  ).obs;
  List<CustomPair<String, Rx<TextEditingController>>> get editRestaurantControllers => [
        CustomPair('نام', nameController),
        CustomPair('منطقه', areaController),
        CustomPair('آدرس', addressController),
        CustomPair('مناطق پشتیبانی', serviceAreasController),
        CustomPair('ساعات کاری', workHourController),
        CustomPair('هزینه ثابت ارسال غذا', deliverCostController),
      ];

  List<CustomPair<String, Rx<TextEditingController>>> get addFoodControllers => [
        CustomPair('نام غذا', foodNameController),
        CustomPair('هزینه غذا', foodCostController),
        CustomPair('موجودی', foodNumberController),
      ];
  final foodNameController = TextEditingController().obs;
  final foodCostController = MoneyMaskedTextController(
    precision: 0,
    decimalSeparator: '',
    thousandSeparator: ',',
    rightSymbol: ' تومان',
  ).obs;
  final foodNumberController = TextEditingController().obs;
  final foodIsOrderable = true.obs;

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
    isLoading.value = true;
    final _restaurants = await api.getAllRestaurants();
    isLoading.value = false;
    restaurants.value = _restaurants!.restaurants;
    return _restaurants.restaurants;
  }

  Future<Restaurant?> editRestaurant(Restaurant restaurant) async {
    final api = RestaurantApi();
    print('49-----------');
    print(restaurant.id.toString());
    print('----------');
    final _res = await api.editRestaurant(
      restaurant.id!,
      name: nameController.value.text,
      area: areaController.value.text,
      address: addressController.value.text,
      service_areas: [serviceAreasController.value.text],
      work_hour: workHourController.value.text,
      deliver_cost: deliverCostController.value.numberValue.toInt(),
    );
    if (_res != null) {
      return _res;
    }
  }

  Future<Food?> addFoodToRestaurant(Restaurant restaurant, Food food) async {
    final api = FoodApi();
    final _res = await api.addFood(
      restaurant.id!,
      name: food.name,
      cost: food.cost,
    );
    // final _rest = await RestaurantApi().editRestaurant(
    //   restaurant.id!,
    //   name: restaurant.name,
    //   area: restaurant.area,
    //   address: restaurant.address,
    //   service_areas: restaurant.service_areas,
    //   work_hour: restaurant.work_hour,
    //   deliver_cost: restaurant.deliver_cost,
    //   foods: (restaurant.foods ?? [])..add(food),
    // );
    return _res;
  }

  Future<Food?> editFood(Restaurant restaurant, Food food, {bool orderable = true}) async {
    final api = FoodApi();
    final _res = await api.changeFoodOrderable(
      Food(
        id: food.id,
        name: foodNameController.value.text,
        cost: foodCostController.value.numberValue.toInt(),
        number: int.parse(foodNumberController.value.text),
      ),
      orderable,
    );
    // final _rest = await RestaurantApi().editRestaurant(
    //   restaurant.id!,
    //   name: restaurant.name,
    //   area: restaurant.area,
    //   address: restaurant.address,
    //   service_areas: restaurant.service_areas,
    //   work_hour: restaurant.work_hour,
    //   deliver_cost: restaurant.deliver_cost,
    //   // foods: (restaurant.foods ?? [])..add(food),
    // );
    return _res;
  }

  Future<Food?> removeFood(Restaurant restaurant, Food food) async {
    final api = FoodApi();
    final _res = await api.removeFood(food);
    final _foods = restaurant.foods!.isNotEmpty ? (restaurant.foods!..remove(food)) : <Food>[];

    // final _rest = await RestaurantApi().editRestaurant(
    //   restaurant.id!,
    //   name: restaurant.name,
    //   area: restaurant.area,
    //   address: restaurant.address,
    //   service_areas: restaurant.service_areas,
    //   work_hour: restaurant.work_hour,
    //   deliver_cost: restaurant.deliver_cost,
    //   foods: _foods,
    // );
    return _res;
  }
}
