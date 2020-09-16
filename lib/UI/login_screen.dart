import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/UI/base_screen.dart';
import 'package:pokemon_api_zip/components/login_component.dart';
import 'package:pokemon_api_zip/components/onboarding_component.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Child will be inside a SafeArea.Scaffold.body
    return BaseScreen(
        child: Stack(
      children: [LoginComponent(), OnboardingComponent()],
    ));
  }
}
