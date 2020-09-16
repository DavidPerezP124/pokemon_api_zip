import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/UI/base_screen.dart';
import 'package:pokemon_api_zip/components/login_component.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Child will be inside a SafeArea.Scaffold.body
    return BasePage(child: LoginComponent());
  }
}
