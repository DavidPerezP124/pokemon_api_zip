import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/components/home_component.dart';
import 'package:pokemon_api_zip/models/pokemon_model.dart';
import 'package:pokemon_api_zip/models/user_model.dart';
import 'package:pokemon_api_zip/network/network_layer.dart';
import 'package:pokemon_api_zip/protocols/home_delegate.dart';
import 'package:pokemon_api_zip/protocols/home_protocol.dart';
import 'package:pokemon_api_zip/providers/userStatusProvider.dart';

import 'base_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, @required this.data, @required this.network})
      : super(key: key);
  final UserStatus data;
  final HomeDelegate network;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeProtocol {
  UserModel user;
  @override
  void initState() {
    super.initState();
    widget.network.setProtocol(this);
  }

  List<Pokemon> randomList =
      List.generate(5, (index) => Pokemon(name: "loading", url: "loading"));
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: HomeComponent(randomList: randomList, pokemon: pokemon),
    );
  }

  @override
  List<Pokemon> pokemon = [];

  @override
  getPokemon(List<Pokemon> pokemonList) {
    setState(() {
      pokemon = pokemonList;
    });
    var random = Random();
    setState(() {
      randomList = randomList
          .map((e) => pokemonList[random.nextInt(pokemon.length)])
          .toList();
    });
  }
}
