import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

/// Provider for the [ApiClient] instance.
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient();
}

/// [ApiClient]
///
/// A wrapper around [Dio] that handles configuration, interceptors, and error transformation.
class ApiClient {
  late final Dio _dio;

  ApiClient({Dio? dioOverride}) {
    _dio = dioOverride ?? Dio()
      ..options.baseUrl = 'https://reqres.in/api'
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..options.headers = {'Content-Type': 'application/json'};

    // Add interceptors for logging and auth
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  /// Expose the underlying Dio instance for flexibility if needed,
  /// but preferably use wrapper methods (get, post, etc.) to enforce consistency.
  Dio get client => _dio;

  // Example generic GET method (future expansion)
  // Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) { ... }
}
