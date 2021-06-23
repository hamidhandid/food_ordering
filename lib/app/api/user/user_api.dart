import 'dart:async';
import 'dart:convert';

import 'package:alo_self/app/api/api_routes.dart';
import 'package:alo_self/app/model/login_result.dart';
import 'package:alo_self/app/model/user.dart';
import 'package:alo_self/app/model/user_profile.dart';
import 'package:dio/dio.dart';
import '../api_agent.dart';

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
        res = await dio.post(
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
      // print(_res.statusCode);
      // print(json.decode(_res.data));
      return UserProfile.fromJson(res!.data as Map<String, dynamic>);
    });
  }
}
