import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/UI/details_screen.dart';
import 'package:pokemon_api_zip/models/pokemon_model.dart';
import 'package:pokemon_api_zip/network/network_layer.dart';
import 'package:provider/provider.dart';

class HomeComponent extends StatelessWidget {
  const HomeComponent({
    Key key,
    @required this.randomList,
    @required this.pokemon,
  }) : super(key: key);

  final List<Pokemon> randomList;
  final List<Pokemon> pokemon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/pokedeex.png"),
            Container(
              height: 200,
              child: Center(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: randomList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          onTap: () => _handleTap(context, randomList[index]),
                          child: Text(randomList[index].name),
                        ),
                      );
                    }),
              ),
            ),
            Expanded(
              child: Center(
                child: ListView.builder(
                    itemCount: pokemon.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Text(pokemon[index].name),
                          onTap: () => _handleTap(context, pokemon[index]),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleTap(BuildContext context, Pokemon pokemon) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      List<String> urlList = pokemon.url.split('/');
      return Consumer<NetworkService>(
          builder: (context, network, child) => DetailsScreen(
              network: network,
              pokemon: int.tryParse(urlList[urlList.length - 2])));
    }));
  }
}
