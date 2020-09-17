import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/models/pokemon_details.dart';
import 'package:pokemon_api_zip/protocols/details_delegate.dart';
import 'package:pokemon_api_zip/protocols/details_protocol.dart';

import 'base_screen.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key key, @required this.network, @required this.pokemon})
      : super(key: key);
  final DetailsDelegate network;
  final int pokemon;
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    implements DetailsProtocol {
  @override
  void initState() {
    super.initState();
    widget.network.setDetailProtocol(this);
    widget.network.getPokemonDetails(widget.pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: AppBar(),
      child: details != null
          ? PokemonCard(
              details: details,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  PokemonDetails details;

  @override
  getDetails(PokemonDetails _details) {
    setState(() {
      details = _details;
    });
  }
}

class PokemonCard extends StatelessWidget {
  const PokemonCard({Key key, @required this.details}) : super(key: key);
  final PokemonDetails details;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(details.name),
              ...details.abilities.map((e) => Text(e.ability.name)).toList(),
              ...details.moves.map((e) => Text(e.move.name)).toList()
            ],
          ),
        ),
      ),
    );
  }
}
