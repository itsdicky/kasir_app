import 'package:kasir_app/features/user/model/user.dart';

abstract class UserService {
  Future<User> getCurrentUser();
}
