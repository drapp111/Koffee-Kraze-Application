import 'dart:async';
import 'package:user_repository/user_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
class UserRepository {
  User _user;
  AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  Future<User> getCurrentUser() async {
    if(_user != null) {
      return _user;
    }
    else {
      try {
        _initUser();
        return _user;
      }
      catch(error) {
        print("Error: user_repository: getCurrentUser");
        print(error);
        return null;
      }
    }
  }

  Future<void> _initUser() async {
    try {
      User _authUser = await _authenticationRepository.getCurrentUser();
      _user = User.fromAuthUser(_authUser);
    }
    catch(error) {
      print("Error: user_repository: _initUser");
      print(error);
    }
  }
}