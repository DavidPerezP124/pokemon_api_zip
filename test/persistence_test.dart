import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_api_zip/models/user_model.dart';
import 'package:pokemon_api_zip/persistance/persistence_service.dart';
import 'package:pokemon_api_zip/protocols/testing_protocols.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  TestingService _tests;
  SharedPreferences _prefs;
  Map<String, dynamic> _kTestValues = {
    "flutter.username": 'testName',
    'flutter.password': 'testPass',
    "flutter.onboarded": true
  };
  setUp(() async {
    _tests = PersistData();
    SharedPreferences.setMockInitialValues(_kTestValues);
    _prefs = await SharedPreferences.getInstance();
  });
  group("Persistence tests", () {
    test("Testing User Deserialization", () {
      UserModel model = _tests.testDeserialization(
          {"username": "testName", "password": "testPass"});
      expect(model.username, "testName");
    });
    test("Test Shared Preferences", () async {
      String map = _prefs.getString("user");
      expect(map, _kTestValues["flutter.user"]);
    });
    test("Test User Retrieval", () async {
      String username = _prefs.getString("username");
      String password = _prefs.getString("password");
      var value = _tests
          .testDeserialization({"username": username, "password": password});
      expect(value.username, "testName");
    });
  });
  tearDown(() {
    _prefs.clear();
    _tests = null;
  });
}
