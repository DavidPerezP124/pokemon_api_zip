import 'dart:convert';
import 'package:pokemon_api_zip/models/userModel.dart';
import 'package:pokemon_api_zip/protocols/onboarding_data_protocol.dart';
import 'package:pokemon_api_zip/protocols/testing_protocols.dart';
import 'package:pokemon_api_zip/protocols/user_data_protocol.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistData implements UserData, OnboardingData, TestingService {
  PersistData();
  static SharedPreferences _preferences;

  //Initialize SharedPreferences instance
  static Future _startService() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //Check and initialize SharedPreferences in case
  //it hasn't been initialized or was disposed.
  ///initializes shared prefenreces and executes a function passed to it
  static Future<dynamic> _useService(
      {Function function, dynamic argument}) async {
    if (_preferences != null) {
      argument != null ? function(argument) : function();
    } else {
      return await _startService()
          .then((value) => argument != null ? function(argument) : function());
    }
  }

  //MARK: User Functions
  saveUserInfo(UserModel user) {
    _useService(function: _saveUserInfo, argument: user);
  }

  _saveUserInfo(UserModel user) =>
      _preferences.setString("user", jsonEncode(user)).toString();

  Future<UserModel> getUserInfo() async {
    return await _useService(function: _getUserInfo)
        .then((value) => (value as UserModel));
  }

  UserModel _getUserInfo() {
    String map = _preferences.getString("user");
    var value = _makeMap(map);
    if (value == null) {
      return null;
    }
    return UserModel.fromJson(value);
  }

  Map<String, String> _makeMap(String map) {
    Map<String, String> nMap = {};
    if (map == null) {
      return null;
    }
    print(map);
    map.split(',').map((e) => nMap[e.split(":")[0]] = e.split(":")[1]);
    return nMap;
  }

  //MARK: Onboarding
  setOnboarding() => _useService(function: _setOnboarding);

  _setOnboarding() {
    _preferences.setBool("onboarded", true);
  }

  Future<bool> getOnboarding() async =>
      await _useService(function: _getOnboarding) as bool;

  bool _getOnboarding() => _preferences.getBool("onboarded");

// Functions for testing
  @override
  UserModel testDeserialization(dynamic data) {
    if (data is String) {
      var value = _makeMap(data);
      if (value == null) return null;
      return UserModel.fromJson(value);
    }
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> testRetrievingUser() async {
    SharedPreferences.setMockInitialValues({
      "flutter.user": "{username':'testName','password':'testPass'}",
      "flutter.onboarded": true
    });
    var _prefs = await SharedPreferences.getInstance();
    String map = _prefs.getString("user");
    var value = _makeMap(map);
    return UserModel.fromJson(value);
  }

  @override
  Map<String, String> testSerialization(dynamic data) {}
}
