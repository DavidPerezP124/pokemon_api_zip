import 'package:pokemon_api_zip/models/pokemon_details.dart';
import 'package:pokemon_api_zip/models/pokemon_model.dart';

abstract class DetailsProtocol {
  getDetails(PokemonDetails details);
  PokemonDetails details;
}
