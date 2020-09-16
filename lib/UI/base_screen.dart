import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key key, @required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    //Safe Area for iPhone X users
    return SafeArea(
      child: Scaffold(
        body: Center(child: child),
      ),
    );
  }
}
