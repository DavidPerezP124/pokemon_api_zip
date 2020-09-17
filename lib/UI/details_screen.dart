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
              Image.network(
                details.sprites.frontDefault,
                height: 100,
                fit: BoxFit.fitHeight,
              ),
              _group(context,
                  groupTitle: "Name", children: [Text(details.name)]),
              _group(context,
                  groupTitle: "Abilitites",
                  children: details.abilities
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.ability.name),
                          ))
                      .toList()),
              _group(context,
                  groupTitle: "Moves",
                  children: details.moves
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.move.name),
                          ))
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }

  Text _titleText(BuildContext context, {String title}) =>
      Text(title, style: Theme.of(context).textTheme.headline5);

  Widget _group(BuildContext context,
          {String groupTitle, List<Widget> children}) =>
      Card(
        child: Column(
          children: [
            _titleText(context, title: groupTitle),
            ...children,
          ],
        ),
      );
}
