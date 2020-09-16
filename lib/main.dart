import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_api_zip/UI/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _kTheme(context),
      home: LoginScreen(),
    );
  }
}

ThemeData _kTheme(BuildContext context) => Theme.of(context)
    .copyWith(primaryTextTheme: GoogleFonts.poppinsTextTheme());
