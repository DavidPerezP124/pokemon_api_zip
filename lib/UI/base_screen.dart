import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key key, @required this.child, this.appBar})
      : super(key: key);
  final Widget child;
  final AppBar appBar;
  @override
  Widget build(BuildContext context) {
    //Safe Area for iPhone X users
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Center(child: child),
      ),
    );
  }
}
