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
    @required this.setLimit,
    @required this.currentOffset,
  }) : super(key: key);

  final List<Pokemon> randomList;
  final List<Pokemon> pokemon;
  final ValueSetter<int> setLimit;
  final int currentOffset;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 300,
                      minHeight: 250,
                    ),
                    child: Image.asset("assets/images/pokedeex.png"))),
            Center(
                child: _titleText(context, title: "Random Picks From Below")),
            Center(
              child: Container(
                height: 100,
                width: 400,
                child: Center(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: randomList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: InkWell(
                            onTap: () => _handleTap(context, randomList[index]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(child: Text(randomList[index].name)),
                                  Center(
                                      child: Text(randomList[index]
                                          .url
                                          .substring(0,
                                              randomList[index].url.length - 1)
                                          .split('/')
                                          .last)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            Center(
                child: ConstrainedBox(
              constraints: _kWidthBoxConstraints,
              child: Row(
                children: [
                  _titleText(context,
                      title:
                          "Pokemon List: ${currentOffset + 1} - ${currentOffset + 100}"),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () => currentOffset >= 200
                          ? setLimit(currentOffset - 100)
                          : () {}),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () => currentOffset < 1000
                          ? setLimit(currentOffset + 100)
                          : () {}),
                ],
              ),
            )),
            Expanded(
              child: Center(
                child: ListView.builder(
                    itemCount: pokemon.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: ConstrainedBox(
                          constraints: _kWidthBoxConstraints,
                          child: Card(
                            child: ListTile(
                              trailing: Text(pokemon[index]
                                  .url
                                  .substring(0, pokemon[index].url.length - 1)
                                  .split('/')
                                  .last),
                              leading: Text(pokemon[index].name),
                              onTap: () => _handleTap(context, pokemon[index]),
                            ),
                          ),
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

  BoxConstraints get _kWidthBoxConstraints => BoxConstraints(
        maxWidth: 600,
      );
  Text _titleText(BuildContext context, {String title}) {
    return Text(title, style: Theme.of(context).textTheme.headline4);
  }
}
