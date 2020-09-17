import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/UI/base_screen.dart';
import 'package:pokemon_api_zip/components/login_component.dart';
import 'package:pokemon_api_zip/components/onboarding_component.dart';
import 'package:pokemon_api_zip/models/user_model.dart';
import 'package:pokemon_api_zip/network/network_layer.dart';
import 'package:pokemon_api_zip/providers/onboardingStatusProvider.dart';
import 'package:pokemon_api_zip/providers/userStatusProvider.dart' as user;
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key, @required this.status}) : super(key: key);
  final user.UserStatus status;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _signedIn = false;
  UserModel _user;
  @override
  void initState() {
    super.initState();
    widget.status.signedIn((value) {
      setState(() {
        _user = value;
        _signedIn = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_signedIn) {
      return Consumer<NetworkService>(
          builder: (context, network, child) => HomeScreen(
                data: widget.status,
                network: network,
              ));
    }

    return BaseScreen(
        child: Stack(
      children: [
        LoginComponent(
          signIn: _setSignIn,
        ),
        Consumer<OnboardingStatus>(
            builder: (context, data, child) => OnboardingComponent(data: data))
      ],
    ));
  }

  _setSignIn(bool signed) {
    setState(() {
      _signedIn = signed;
    });
  }
}
