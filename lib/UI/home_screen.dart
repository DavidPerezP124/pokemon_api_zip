import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/models/userModel.dart';
import 'package:pokemon_api_zip/providers/userStatusProvider.dart';
import 'package:provider/provider.dart';

import 'base_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, @required this.data}) : super(key: key);
  final UserStatus data;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel user;
  @override
  void initState() {
    super.initState();
    widget.data.signedIn((value) {
      print(value);
      setState(() => user = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: Center(
            child: Text(
                "Home Screen, welcome ${user != null ? user.username : ""}")));
  }
}
