import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vocablury/utilities/dio/api_end_points.dart';



class NewClient {
  Dio init() {
    Dio dio = Dio();

    final prefs = GetStorage();

    var token = prefs.read('TOKEN');
    dio.options.headers["Authorization"] = token;
    dio.options.headers["device"] = Platform.isAndroid ? 'Android' : 'IOS';
    dio.options.baseUrl = APIEndPoints.base;

    RequestOptions? requestOptions;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          requestOptions = options;
          debugPrint("----- ${requestOptions?.path} ${requestOptions?.data} ${requestOptions?.method}");

          return handler.next(options);
        },
        onError: (e, handler) {




          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}