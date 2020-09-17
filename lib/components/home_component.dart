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
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.2,
                    constraints: BoxConstraints(
                      maxHeight: 300,
                      minHeight: 100,
                    ),
                    child: Image.asset("assets/images/pokedeex.png"))),
            Center(
                child: FittedBox(
                    child:
                        _titleText(context, title: "Random Picks From Below"))),
            Center(
              child: Container(
                height: 150,
                width: 550,
                child: Center(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: randomList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            width: 500 / 5,
                            child: InkWell(
                              onTap: () =>
                                  _handleTap(context, randomList[index]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Center(child: Text(randomList[index].name)),
                                    randomList[index].url != "loading"
                                        ? Image.network(
                                            _generateUrl(randomList[index].url),
                                            height: 40)
                                        : Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                    Center(
                                        child: Text(
                                            _getId(randomList[index].url))),
                                  ],
                                ),
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
                  FittedBox(
                    child: _titleText(context,
                        title:
                            "Pokemon List: ${currentOffset + 1} - ${currentOffset + 100}"),
                  ),
                  Spacer(),
                  Row(
                    children: [
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
                              isThreeLine: true,
                              subtitle: Text(_getId(pokemon[index].url)),
                              trailing: Image.network(
                                  _generateUrl(pokemon[index].url)),
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

  String _getId(String str) {
    if (str == "loading") {
      return "";
    }
    return str.substring(0, str.length - 1).split('/').last;
  }

  String _generateUrl(String str) {
    String pokemonId = _getId(str);
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png";
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
    return Text(title, style: Theme.of(context).textTheme.headline6);
  }
}
