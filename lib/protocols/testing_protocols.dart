import 'package:pokemon_api_zip/models/userModel.dart';

abstract class TestingService {
  UserModel testDeserialization(dynamic data);
  Map<String, String> testSerialization(dynamic data);
  Future<UserModel> testRetrievingUser();
}
