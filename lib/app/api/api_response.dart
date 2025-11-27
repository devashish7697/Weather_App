class ApiResponse<T> {

  final T? data;
  final String? message;
  final bool success;
  final int statusCode;
  final String? error;

  ApiResponse({
    this.message,
    required this.statusCode,
    this.data,
    this.error,
  }) : success = statusCode >= 200 && statusCode < 300;

  factory ApiResponse.success(
  T data, {String? message, int statusCode = 200
  }){
    return ApiResponse(
    data: data,
    message: message,
    statusCode: statusCode,
    );
  }

  factory ApiResponse.error(
      String message, { int statusCode = 400
      }){
    return ApiResponse(
      message: message,
      statusCode: statusCode,
    );
  }

}