import 'package:pokemon_api_zip/models/user_model.dart';

abstract class TestingService {
  UserModel testDeserialization(dynamic data);
  Map<String, String> testSerialization(dynamic data);
}
