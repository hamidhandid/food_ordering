import 'dart:async';
import 'dart:convert';

import 'package:alo_self/app/api/api_routes.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:dio/dio.dart';
import '../api_agent.dart';

class FoodApi {
  Future<Food?> addFood(
    String rid, {
    required String name,
    required int cost,
    required int? number,
    bool orderable = true,
  }) async {
    return invokeApi<Food>((dio) async {
      final _food = Food(
        name: name,
        cost: cost,
        orderable: orderable,
        number: number,
      ).toJson();
      print(json.encode(_food));
      Response? res;
      try {
        res = await dio.post(
          ApiRoutes.foodPost.replaceAll('{rid}', rid),
          data: json.encode(_food),
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
      return Food.fromJson(res!.data as Map<String, dynamic>);
    });
  }

  Future<Food?> changeFoodOrderable(
    Food food,
    bool orderable,
  ) async {
    return invokeApi<Food>((dio) async {
      final _food = Food(
        id: food.id,
        cost: food.cost,
        name: food.name,
        number: food.number ?? 0,
        orderable: orderable,
      ).toJson();
      print(json.encode(_food));
      Response? res;
      try {
        res = await dio.put(
          ApiRoutes.foodPut.replaceAll(
            '{fid}',
            food.id!,
          ),
          data: json.encode(_food),
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
      return Food.fromJson(res!.data as Map<String, dynamic>);
    });
  }

  Future<Food?> removeFood(
    Food food,
  ) async {
    return invokeApi<Food>((dio) async {
      Response? res;
      try {
        res = await dio.delete(
          ApiRoutes.foodDelete.replaceAll('{fid}', food.id!),
          // data: json.encode(_food),
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
      return Food.fromJson(res!.data as Map<String, dynamic>);
    });
  }
}
