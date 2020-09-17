import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/models/user_model.dart';
import 'package:pokemon_api_zip/protocols/user_data_protocol.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserStatus with ChangeNotifier {
  Status _status = Status.Uninitialized;
  UserModel _user = UserModel(password: "", username: "");
  UserStatus.instance(this._userData);

  Status get status => _status;
  UserModel get user => _user;
  final UserData _userData;

  bool signIn(String username, String password) {
    _userData.saveUserInfo(UserModel(username: username, password: password));

    _userData.getUserInfo().then((value) {
      _status = Status.Authenticated;
      _user = value;
      notifyListeners();
      return true;
    });
    return false;
  }

  signedIn(ValueSetter<UserModel> user) {
    _userData.getUserInfo().then((value) {
      if (value != null && value.username != '') {
        user(value);
        _status = Status.Authenticated;
        _user = value;
        notifyListeners();
      }
    });
  }

  Future<UserModel> getUser() async {
    return await _userData.getUserInfo();
  }
}
