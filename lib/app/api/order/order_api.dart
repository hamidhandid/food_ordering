import 'dart:async';
import 'dart:convert';

import 'package:alo_self/app/api/api_routes.dart';
import 'package:alo_self/app/api/user/user_api.dart';
import 'package:alo_self/app/model/edit_order.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/model/order.dart';
import 'package:alo_self/app/model/orders.dart';
import 'package:alo_self/app/model/user_profile.dart';
import 'package:dio/dio.dart';
import '../api_agent.dart';

class OrderApi {
  Future<Order?> addOrder(
    String userId, {
    required List<Food> foods,
  }) async {
    return invokeApi<Order>((dio) async {
      final _order = Order(
        foods: foods,
      ).toJson();
      print(json.encode(_order));
      Response? res;
      print(userId);
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

  Future<Orders?> getCustomerOrders() async {
    return invokeApi<Orders>((dio) async {
      Response? res;
      // print('21--------------');
      // print(userId);
      try {
        res = await dio.get(
          ApiRoutes.ordersGet.replaceAll('{id}', (await UserApi().getProfile())!.id!),
          // data: json.encode(_order),
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
      return Orders.fromJson(res!.data as Map<String, dynamic>);
    });
  }

  Future<Orders?> getAllOrders() async {
    return invokeApi<Orders>((dio) async {
      Response? res;
      // print('21--------------');
      // print(userId);
      try {
        res = await dio.get(
          ApiRoutes.ordersGetAll,
          // data: json.encode(_order),
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
      return Orders.fromJson(res!.data as Map<String, dynamic>);
    });
  }

  Future<Order?> editOrder(
    String orderId, {
    required String status,
    UserProfile? sender,
  }) async {
    return invokeApi<Order>((dio) async {
      Response? res;
      final _order = EditOrder(
        status: status,
        sender: sender,
      ).toJson();
      try {
        res = await dio.put(
          ApiRoutes.ordersPut.replaceAll('{id}', orderId),
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
