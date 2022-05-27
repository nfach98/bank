import 'dart:convert';

import 'package:bank/common/constants/api_path_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio createDio({required SharedPreferences sharedPreferences}) {
  final _sharedPreferences = sharedPreferences;
  Dio dio = Dio(BaseOptions(
      baseUrl: ApiPathConstants.baseUrl,
      connectTimeout: 20000,
      sendTimeout: 20000,
      receiveTimeout: 20000,
      contentType: "application/json",
      responseType: ResponseType.json));

  // DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
  dio.interceptors.addAll(<Interceptor>[_loginInterceptor(_sharedPreferences)]);
  return dio;
}

Interceptor _loginInterceptor(SharedPreferences sharedPreferences) {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      debugPrint(
          "--> ${options.method}  ${"${options.baseUrl}${options.path}"}");
      debugPrint('Headers:');
      options.headers.forEach((k, dynamic v) => debugPrint('$k: $v'));
      debugPrint('queryParameters:');
      options.queryParameters.forEach((k, dynamic v) => debugPrint('$k: $v'));
      debugPrint(
        '--> END ${options.method}',
      );

      if (options.headers.containsKey('isToken')) {
        options.headers.remove('isToken');
      }

      if (options.headers.containsKey("requiresToken")) {
        options.headers.remove("requiresToken");

        String? token = '';
        token = sharedPreferences.getString('token');
        // print(token);
        debugPrint(options.uri.toString());
        options.headers.addAll({"Authorization": "Bearer $token"});
      }

      // Do something before request is sent
      debugPrint('\n'
          '-- headers --\n'
          '${options.headers.toString()} \n'
          '-- request --\n -->body'
          '${options.data} \n'
          '');

      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    },
    onResponse: (response, handler) {
      // Do something with response data
      debugPrint('\n'
          'Response : ${response.requestOptions.uri} \n'
          '-- headers --\n'
          '${response.headers.toString()} \n'
          '-- response --\n'
          '${jsonEncode(response.data)} \n'
          '');

      return handler.next(response); // continue
    },
    onError: (DioError e, handler) {
      return handler.next(e);
    },
  );
}
