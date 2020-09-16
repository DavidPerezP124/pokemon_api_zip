import 'package:flutter/material.dart';

class PokeStyles {
  PokeStyles({this.context}) : assert(context == null);
  final BuildContext context;
  TextStyle get whiteText =>
      Theme.of(context).textTheme.button.copyWith(color: Colors.white);
}
