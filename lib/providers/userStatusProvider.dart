import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/models/userModel.dart';
import 'package:pokemon_api_zip/protocols/user_data_protocol.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserStatus with ChangeNotifier {
  Status _status = Status.Uninitialized;

  UserStatus.instance(this._userData);

  Status get status => _status;
  final UserData _userData;

  bool signIn(String username, String password) {
    _userData.saveUserInfo(UserModel(username: username, password: password));
    if (_userData.getUserInfo() != null) {
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    }
    return false;
  }

  signedIn(ValueSetter<UserModel> user) {
    _userData.getUserInfo().then((value) {
      if (value != null) {
        print(value.password);
        user(value);
        _status = Status.Authenticated;
        notifyListeners();
      }
    });
  }

  Future<UserModel> getUser() async {
    return await _userData.getUserInfo();
  }
}
