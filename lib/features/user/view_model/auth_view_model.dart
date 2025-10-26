import 'package:flutter/foundation.dart';
import 'package:kasir_app/features/user/service/auth/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  AuthViewModel(AuthService authService) : _authService = authService;

  bool? _isLoggedIn;
  bool? get isLoggedIn => _isLoggedIn;

  Future<void> checkAuth() async {
    try {
      _isLoggedIn = await _authService.isLoggedIn();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(String username, String password) async {
    try {
      await _authService.login(username, password);
      checkAuth();
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      checkAuth();
    } catch (e) {
      print(e);
    }
  }
}
