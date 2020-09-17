import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/UI/base_screen.dart';
import 'package:pokemon_api_zip/components/login_component.dart';
import 'package:pokemon_api_zip/components/onboarding_component.dart';
import 'package:pokemon_api_zip/providers/onboardingStatusProvider.dart';
import 'package:pokemon_api_zip/providers/userStatusProvider.dart' as user;
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<user.UserStatus>(
      builder: (context, data, child) {
        data.signedIn((value) {
          print(value.username);
        });

        if (data.user != null) {
          print(data.user);
          return HomeScreen(data: data);
        }

        return BaseScreen(
            child: Stack(
          children: [
            LoginComponent(),
            Consumer<OnboardingStatus>(
                builder: (context, data, child) =>
                    OnboardingComponent(data: data))
          ],
        ));
      },
    );
  }
}
