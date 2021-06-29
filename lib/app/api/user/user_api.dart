import 'dart:async';
import 'dart:convert';

import 'package:alo_self/app/api/api_routes.dart';
import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/model/foods.dart';
import 'package:alo_self/app/model/login_result.dart';
import 'package:alo_self/app/model/user.dart';
import 'package:alo_self/app/model/user_profile.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../api_agent.dart';

Object? resultCallLogin;
class UserApi {
  Future<LoginResult?> login(String phone, String password) async {
    return invokeApi<LoginResult>((dio) async {
      final _user = User(phone: phone, password: password).toJson();
      print(json.encode(_user));
      Response? res;
      try {
        res = await dio.post(
          ApiRoutes.loginUser,
          data: json.encode(_user),
        );
      } on DioError catch (e) {
        print(e.message);
        print(e.response?.data);
        print(e.response?.statusCode);
      }
      // return LoginResult(token: res as);
      print(res?.data);
      resultCallLogin = res?.data;
      // resultOfCall = res?.data;
      // print(_res.statusCode);
      // print(json.decode(_res.data));
      return LoginResult.fromJson(res!.data as Map<String, dynamic>);
    });
  }

  Future<LoginResult?> signup(String phone, String password) async {
    return invokeApi<LoginResult>((dio) async {
      final _user = User(phone: phone, password: password).toJson();
      print(json.encode(_user));
      Response? res;
      try {
        res = await dio.post(
          ApiRoutes.signupUser,
          data: json.encode(_user),
        );
      } on DioError catch (e) {
        print(e.message);
        print(e.response?.data);
        print(e.response?.statusCode);
      }
      // return LoginResult(token: res as);
      print(res?.data);
      resultCallLogin = res?.data;
      // resultOfCall = res?.data;
      // print(_res.statusCode);
      // print(json.decode(_res.data));
      return LoginResult.fromJson(res!.data as Map<String, dynamic>);
    });
  }

  Future<UserProfile?> editProfile(UserProfile userProfile) {
    return invokeApi<UserProfile>((dio) async {
      print(json.encode(userProfile));
      Response? res;
      try {
        res = await dio.put(
          ApiRoutes.userProfile,
          data: json.encode(userProfile),
        );
      } on DioError catch (e) {
        print(e.message);
        print(e.response?.data);
        print(e.response?.statusCode);
      }
      // return LoginResult(token: res as);
      print(res?.data);
      resultOfCall = res?.data;
      final result = UserProfile.fromJson(res!.data as Map<String, dynamic>);
      await GetStorage().write('userId', result.id);
      // print(_res.statusCode);
      // print(json.decode(_res.data));
      return result;
    });
  }

  Future<UserProfile?> getProfile() {
    return invokeApi<UserProfile>((dio) async {
      Response? res;
      try {
        res = await dio.get(
          ApiRoutes.userProfile,
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
      return UserProfile.fromJson(res!.data as Map<String, dynamic>);
    });
  }

  Future<Foods?> searchFood({String? restaurantName, String? foodName, String? area}) {
    return invokeApi<Foods?>((dio) async {
      Response? res;
      try {
        res = await dio.get(ApiRoutes.searchFood, queryParameters: <String, dynamic>{
          'restaurant': restaurantName ?? '',
          'area': area ?? '',
          'food': foodName ?? '',
        });
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
      return Foods.fromJson(res!.data as Map<String, dynamic>);
    });
  }
}
