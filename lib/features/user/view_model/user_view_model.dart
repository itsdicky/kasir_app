import 'package:flutter/foundation.dart';
import 'package:kasir_app/features/user/model/user.dart';
import 'package:kasir_app/features/user/service/user/user_service.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService;
  UserViewModel(UserService userService) : _userService = userService;

  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<void> fetchUserDetails() async {
    try {
      _currentUser = await _userService.getCurrentUser();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
