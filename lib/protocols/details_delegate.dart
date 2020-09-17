import 'package:pokemon_api_zip/models/pokemon_details.dart';

import 'details_protocol.dart';

abstract class DetailsDelegate {
  DetailsProtocol delegate;
  setProtocol(DetailsProtocol delegate);
  updateDelegate(PokemonDetails details);
}
