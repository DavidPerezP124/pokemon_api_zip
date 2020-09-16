import 'package:flutter/material.dart';

import 'base_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Center(
        child: Text("Home Screen")
      ),
    );
  }
}