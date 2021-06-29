import 'dart:async';
import 'dart:convert';

import 'package:alo_self/app/api/api_routes.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/model/order.dart';
import 'package:dio/dio.dart';
import '../api_agent.dart';

class OrderApi {
  Future<Order?> addOrder(
    String userId, {
    List<Food> foods = const [],
  }) async {
    return invokeApi<Order>((dio) async {
      final _order = Order(
        foods: foods,
      ).toJson();
      print(json.encode(_order));
      Response? res;
      try {
        res = await dio.post(
          ApiRoutes.ordersPost.replaceAll('{id}', userId),
          data: json.encode(_order),
        );
      } on DioError catch (e) {
        print(e.message);
        print(e.response?.data);
        print(e.response?.statusCode);
      }
      // return LoginResult(token: res as);
      print(res?.data);
      resultOfCall = res?.data;
      // print(_res.statusCode);
      // print(json.decode(_res.data));
      return Order.fromJson(res!.data as Map<String, dynamic>);
    });
  }
}
