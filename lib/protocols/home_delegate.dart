import 'package:pokemon_api_zip/models/pokemon_model.dart';
import 'package:pokemon_api_zip/protocols/home_protocol.dart';

abstract class HomeDelegate {
  HomeProtocol homeDelegate;
  setHomeProtocol(HomeProtocol delegate);
  getLimited(int offset, {int limit = 100});
  updateHomeDelegate(List<Pokemon> pokemonList);
}
