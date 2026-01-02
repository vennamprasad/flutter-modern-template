import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/repositories/auth_repository.dart';

part 'remote_auth_repository.g.dart';

/// Provider for [RemoteAuthRepository].
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return RemoteAuthRepository(apiClient);
}

/// [RemoteAuthRepository]
///
/// Implementation of [AuthRepository] that uses [ApiClient] to talk to a remote server.
class RemoteAuthRepository implements AuthRepository {
  final ApiClient _apiClient;

  RemoteAuthRepository(this._apiClient);

  @override
  Future<void> login(String email, String password) async {
    try {
      await _apiClient.client.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      // If successful (200 OK), we just return void.
      // In a real app, we'd parse the token from response.data['token']
    } on DioException catch (e) {
      // Map Dio errors to Domain errors if needed
      throw Exception('Login Failed: ${e.response?.data['error'] ?? e.message}');
    }
  }
}
