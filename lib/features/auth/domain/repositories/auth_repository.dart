abstract class AuthRepository {
  /// Login with email and password.
  /// Returns a Future that completes successfully on login,
  /// or throws an exception.
  Future<void> login(String email, String password);

  // In a real app, this would return User entity.
  // Future<User> login(String email, String password);
}
