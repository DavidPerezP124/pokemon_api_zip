import 'package:pokemon_api_zip/models/pokemon_details.dart';

class Pokemon {
  final String name;
  final String url;

  Pokemon({this.name, this.url});

  factory Pokemon.fromJson(Map<String, dynamic> map) =>
      Pokemon(name: map["name"], url: map["url"]);
}
