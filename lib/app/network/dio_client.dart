import 'dart:io';

import 'package:dio/dio.dart';

class DioClient{

  final Dio _dio;
  final String apiKey;

  DioClient._internal(this._dio, this.apiKey){
   print('DioClient created');
  }

  factory DioClient({required String baseUrl, required apiKey}){
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 15),
      sendTimeout: Duration(seconds: 15),
      responseType: ResponseType.json,
    ));

    dio.interceptors.add(ApiKeyInterceptor(apiKey));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return DioClient._internal(dio,apiKey);
  }

  Dio get client => _dio;

}

class ApiKeyInterceptor extends Interceptor {
  final String apiKey;
  ApiKeyInterceptor(this.apiKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'appid' : apiKey,
      'units' : 'metric',
    });
    return handler.next(options);
  }

}