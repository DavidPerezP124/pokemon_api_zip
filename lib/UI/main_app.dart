import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_api_zip/network/network_layer.dart';
import 'package:pokemon_api_zip/persistance/persistence_service.dart';
import 'package:pokemon_api_zip/providers/onboardingStatusProvider.dart';
import 'package:pokemon_api_zip/providers/userStatusProvider.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class PokeApp extends StatelessWidget {
  final PersistData _data = PersistData();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserStatus>.value(
            value: UserStatus.instance(_data)),
        ChangeNotifierProvider<OnboardingStatus>.value(
            value: OnboardingStatus.instance(_data)),
        Provider<NetworkService>(create: (context) => NetworkService())
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: _kTheme(context),
          home: Consumer<UserStatus>(
              builder: (context, status, child) => LoginScreen(
                    status: status,
                  )),
        );
      },
    );
  }
}

ThemeData _kTheme(BuildContext context) => Theme.of(context)
    .copyWith(primaryTextTheme: GoogleFonts.poppinsTextTheme());
