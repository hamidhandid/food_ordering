import 'dart:async';
import 'dart:convert';

import 'package:alo_self/app/api/api_routes.dart';
import 'package:alo_self/app/api/user/user_api.dart';
import 'package:alo_self/app/model/login_result.dart';
import 'package:alo_self/app/model/manager.dart';
import 'package:dio/dio.dart';
import '../api_agent.dart';

class ManagerApi {
  Future<LoginResult?> login(String email, String password) async {
    return invokeApi<LoginResult>((dio) async {
      final _manager = Manager(email: email, password: password).toJson();
      print(json.encode(_manager));
      Response? res;
      try {
        res = await dio.post(
          ApiRoutes.loginManager,
          data: json.encode(_manager),
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

  Future<LoginResult?> signup(String email, String password) async {
    return invokeApi<LoginResult>((dio) async {
      final _manager = Manager(email: email, password: password).toJson();
      print(json.encode(_manager));
      Response? res;
      try {
        res = await dio.post(
          ApiRoutes.signupManager,
          data: json.encode(_manager),
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
}
