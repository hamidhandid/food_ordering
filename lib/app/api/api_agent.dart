import 'package:alo_self/app/common_widgets/custom_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const _baseUrl = 'http://127.0.0.1:3333';

Future<T?> invokeApi<T>(Future<T> Function(Dio dio) func) async {
  try {
    final _token = GetStorage().read<String>('token');
    final _dio = Dio(
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
    CustomSnackBar.show(
      e.runtimeType.toString(),
      e.toString(),
      backgroundColor: Colors.red[500],
    );
  }
}
