import 'package:pokemon_api_zip/models/userModel.dart';

abstract class UserData {
  Future<UserModel> getUserInfo();
  saveUserInfo(UserModel user);
}
