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
  GlobalKey _componentKey = GlobalKey();
  int _currentOffset = 0;
  List<Pokemon> pokemon = [];
  @override
  void initState() {
    super.initState();
    widget.network.setHomeProtocol(this);
  }

  //TODO: [POK-1] Pass this to NetworkLayer or other logic handler
  List<Pokemon> randomList =
      List.generate(5, (index) => Pokemon(name: "loading", url: "loading"));
  void _getPokemon(int offset) {
    widget.network.getLimited(offset, limit: 100);
    setState(() => _currentOffset = offset);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: HomeComponent(
        key: _componentKey,
        randomList: randomList,
        pokemon: pokemon,
        setLimit: _getPokemon,
        currentOffset: _currentOffset,
      ),
    );
  }

  @override
  getPokemon(List<Pokemon> pokemonList) {
    var random = Random();

    setState(() {
      pokemon = [];
      pokemon = pokemonList;
    });

    setState(() {
      randomList = randomList
          .map((e) => pokemonList[random.nextInt(pokemon.length)])
          .toList();
    });
  }
}
