import 'package:alo_self/app/common_widgets/custom_snackbar.dart';
import 'package:alo_self/app/model/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const _baseUrl = 'http://127.0.0.1:3333';

Object? resultOfCall;

Future<T?> invokeApi<T>(Future<T> Function(Dio dio) func) async {
  late final Dio? _dio;
  try {
    final _token = GetStorage().read<String>('token');
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        contentType: 'application/json',
        connectTimeout: 60,
        headers: _token != null
            ? <String, dynamic>{
                'Authorization': 'Bearer $_token',
              }
            : null,
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ),
    );

    return await func(_dio);
  } on DioError catch (e) {
    CustomSnackBar.show(
      e.error.toString(),
      e.message,
      backgroundColor: Colors.red[500],
    );
  } catch (e) {
    if (resultOfCall != null) {
      try {
        final error = Error.fromJson(resultOfCall as Map<String, dynamic>);
        CustomSnackBar.show(
          error.status_code.toString(),
          error.message,
          backgroundColor: Colors.red[500],
        );
      } catch (ex) {
        CustomSnackBar.show(
          e.runtimeType.toString(),
          e.toString(),
          backgroundColor: Colors.red[500],
        );
      }
    }
  }
}
