import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather_app/app/api/api_response.dart';

class ApiClient {

  final String baseUrl = 'https://api.openweathermap.org';
  final http.Client httpClient = http.Client();

  Future<ApiResponse<T>> get<T>({
    required String path,
    required T Function(dynamic json) converter,
    Map<String, String>? params,
  }) async {
    try {

      final url = Uri.parse(baseUrl + path).replace(queryParameters: params);
      final response = await httpClient.get(url);

      final status = response.statusCode;

      if(status >= 200 && status < 300 ){
        final jsonBody = jsonDecode(response.body);
        final data = converter(jsonBody);

        return ApiResponse.success(
          data,
            statusCode: status,
            message: 'Success'
        );
      } else {
        try {
          final jsonBody = jsonDecode(response.body);
          return ApiResponse.error(
              jsonBody['message'] ?? 'Unknown error',
            statusCode: status
          );
        } catch (_){
          return ApiResponse.error(
            "Something went wrong",
            statusCode: status,
          );
        }
      }
    } catch (e){
      return ApiResponse.error(
          e.toString(),
        statusCode: 500,
      );
    }
  }

}