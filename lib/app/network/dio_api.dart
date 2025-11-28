import 'package:dio/dio.dart';
import 'package:weather_app/app/api/api_response.dart';
import 'package:weather_app/app/data/model/current_weather_model.dart';
import 'package:weather_app/app/network/dio_client.dart';
import 'package:get/get.dart';

class DioApi {

  final DioClient client;

  DioApi(this.client){
    print('DIo APi created');
    print("Dio client ApiId : ${client.apiKey}");
  }

  // Get Method
  Future<ApiResponse<Map<String,dynamic>>> get({
    Map<String, dynamic>? queryParams,
    required String uri,
  }) async {

    try {
      final response = await client.client.get(
          uri,
          queryParameters: queryParams,
      );

      final status = response.statusCode ?? 0;
      final json = response.data;

      if (json is! Map<String, dynamic>) {
        return ApiResponse.error(
          "Invalid server response",
          statusCode: status,
        );
      }

      return ApiResponse.success(
          json,
          statusCode: status,
          message: "Weather Fetched Succesfully!"
      );
    } on DioException catch (e){

      // If server returned JSON error (e.response exists)
      if (e.response != null) {
        final errorJson = e.response?.data;
        return ApiResponse.error(
          errorJson?['message']?.toString() ?? "Server error",
          statusCode: e.response?.statusCode ?? 400,
        );
      }
      // If no response from server (no internet, timeout)
      return ApiResponse.error(
        "Network error: ${e.message}",
        statusCode: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      // Any unexpected parsing/logic errors
      return ApiResponse.error(
        "Unexpected error: $e",
        statusCode: 500,
      );
    }

  }

}