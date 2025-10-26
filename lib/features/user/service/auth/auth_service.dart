abstract class AuthService {
  Future<bool> isLoggedIn();
  Future<void> login(String username, String password);
  Future<void> logout();
}
