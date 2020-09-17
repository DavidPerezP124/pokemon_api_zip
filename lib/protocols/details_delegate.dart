import 'package:pokemon_api_zip/models/pokemon_details.dart';

import 'details_protocol.dart';

abstract class DetailsDelegate {
  DetailsProtocol detailDelegate;
  setDetailProtocol(DetailsProtocol delegate);
  getPokemonDetails(int pokemon);
  updateDetailDelegate(PokemonDetails details);
}
