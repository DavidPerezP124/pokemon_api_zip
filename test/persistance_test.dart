import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_api_zip/models/userModel.dart';
import 'package:pokemon_api_zip/persistance/persistance_service.dart';
import 'package:pokemon_api_zip/protocols/testing_protocols.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  group("Persistance tests", () {
    TestingService tests = PersistData();
    test("Testing User Deserialization", () {
      UserModel model = tests.testDeserialization(
          {"username": "testName", "password": "testPass"});
      expect(model.username, "testName");
    });
    test("Test User Retrieval", () async {
      SharedPreferences.setMockInitialValues({
        "flutter.user": "{username':'testName','password':'testPass'}",
        "flutter.onboarded": true
      });
      var _prefs = await SharedPreferences.getInstance();
      String map = _prefs.getString("user");
      var value = tests.testDeserialization(map);
      expect(value.username, "testName");
    });
  });
}
