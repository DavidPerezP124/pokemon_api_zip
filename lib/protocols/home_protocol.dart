import 'package:pokemon_api_zip/models/pokemon_model.dart';

abstract class HomeProtocol {
  getPokemon(List<Pokemon> pokemonList);
  List<Pokemon> pokemon = [];
}
