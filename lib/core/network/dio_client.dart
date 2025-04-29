import 'package:dio/dio.dart';
import 'package:fallnews/core/network/endpoints.dart';

final class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  )..interceptors.add(LogInterceptor(responseBody: true));

  Dio get client => _dio;
}
