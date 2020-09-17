import 'package:pokemon_api_zip/models/user_model.dart';

abstract class UserData {
  Future<UserModel> getUserInfo();
  saveUserInfo(UserModel user);
}
