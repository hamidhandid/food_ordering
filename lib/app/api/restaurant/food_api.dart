import 'dart:async';
import 'dart:convert';

import 'package:alo_self/app/api/api_routes.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:dio/dio.dart';
import '../api_agent.dart';

class RestaurantApi {
  Future<Food?> addFood({
    required String name,
    required int cost,
    bool orderable = true,
  }) async {
    return invokeApi<Food>((dio) async {
      final _food = Food(
        name: name,
        cost: cost,
        orderable: orderable,
      ).toJson();
      print(json.encode(_food));
      Response? res;
      try {
        res = await dio.post(
          //TODO
          ApiRoutes.foodPost,
          data: json.encode(_food),
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
      return Food.fromJson(res!.data as Map<String, dynamic>);
    });
  }

  // Future<Food?> makeFoodUnorderable(
  //   String id,
  // ) async {
  //   return invokeApi<Food>((dio) async {
  //     print(json.encode(_restaurant));
  //     Response? res;
  //     try {
  //       res = await dio.put(
  //         ApiRoutes.restaurantPut.replaceAll('{id}', id),
  //         data: json.encode(_restaurant),
  //       );
  //     } on DioError catch (e) {
  //       print(e.message);
  //       print(e.response?.data);
  //       print(e.response?.statusCode);
  //     }
  //     // return LoginResult(token: res as);
  //     print(res?.data);
  //     // print(_res.statusCode);
  //     // print(json.decode(_res.data));
  //     return Restaurant.fromJson(res!.data as Map<String, dynamic>);
  //   });
  // }
}
