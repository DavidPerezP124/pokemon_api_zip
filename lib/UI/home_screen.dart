import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/models/pokemon_model.dart';
import 'package:pokemon_api_zip/models/user_model.dart';
import 'package:pokemon_api_zip/network/network_layer.dart';
import 'package:pokemon_api_zip/protocols/home_protocol.dart';
import 'package:pokemon_api_zip/providers/userStatusProvider.dart';
import 'package:provider/provider.dart';

import 'base_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, @required this.data}) : super(key: key);
  final UserStatus data;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeProtocol {
  UserModel user;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkService>(builder: (context, network, child) {
      network.getLimited(100);
      network.setProtocol(this);
      return BaseScreen(
        child: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Column(
              children: [
                Image.asset("assets/images/pokedeex.png"),
                Expanded(
                  child: Text("Pokemon"),
                ),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                        itemCount: pokemon.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: Text(pokemon[index].name),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  List<Pokemon> pokemon = [];

  @override
  getPokemon(List<Pokemon> pokemonList) {
    setState(() {
      pokemon = pokemonList;
    });
  }
}
