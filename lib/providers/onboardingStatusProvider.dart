import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/protocols/onboarding_data_protocol.dart';

enum Status { Onboarded, Onboarding }

class OnboardingStatus with ChangeNotifier {
  Status _status = Status.Onboarding;

  OnboardingStatus.instance(this._userData);

  Status get status => _status;
  final OnboardingData _userData;

  onboard() {
    _userData.setOnboarding();
    _status = Status.Onboarded;
    notifyListeners();
  }

  isOnboarded(ValueSetter<bool> onboard) {
    _userData.getOnboarding().then((value) {
      if (value == true) {
        onboard(value);
      }
    });
  }
}
