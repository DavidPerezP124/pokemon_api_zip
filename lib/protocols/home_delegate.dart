import 'package:pokemon_api_zip/models/pokemon_model.dart';
import 'package:pokemon_api_zip/protocols/home_protocol.dart';

abstract class HomeDelegate {
  HomeProtocol delegate;
  setProtocol(HomeProtocol delegate);
  updateDelegate(List<Pokemon> pokemonList);
}
