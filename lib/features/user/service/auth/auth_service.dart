abstract class AuthService {
  Future<String> authenticate(String username, String password);
}
