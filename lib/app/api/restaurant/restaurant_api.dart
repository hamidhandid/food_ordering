import 'dart:async';
import 'dart:convert';

import 'package:alo_self/app/api/api_routes.dart';
import 'package:alo_self/app/model/restaurant.dart';
import 'package:dio/dio.dart';
import '../api_agent.dart';

class RestaurantApi {
  Future<Restaurant?> addRestaurant({
    required String name,
    required String area,
    required String address,
    required List<String> service_areas,
    required String work_hour,
    required int deliver_cost,
  }) async {
    return invokeApi<Restaurant>((dio) async {
      final _restaurant = Restaurant(
        name: name,
        area: area,
        address: address,
        service_areas: service_areas,
        work_hour: work_hour,
        deliver_cost: deliver_cost,
      ).toJson();
      print(json.encode(_restaurant));
      Response? res;
      try {
        res = await dio.post(
          ApiRoutes.restaurantPost,
          data: json.encode(_restaurant),
        );
      } on DioError catch (e) {
        print(e.message);
        print(e.response?.data);
        print(e.response?.statusCode);
      }
      // return LoginResult(token: res as);
      print(res?.data);
      // print(_res.statusCode);
      // print(json.decode(_res.data));
      return Restaurant.fromJson(res!.data as Map<String, dynamic>);
    });
  }
}
