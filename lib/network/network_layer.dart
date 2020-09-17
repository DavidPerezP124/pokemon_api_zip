import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_api_zip/models/pokemon_details.dart';
import 'package:pokemon_api_zip/models/pokemon_model.dart';
import 'package:pokemon_api_zip/protocols/details_delegate.dart';
import 'package:pokemon_api_zip/protocols/details_protocol.dart';
import 'package:pokemon_api_zip/protocols/home_delegate.dart';
import 'package:pokemon_api_zip/protocols/home_protocol.dart';

class NetworkService implements HomeDelegate, DetailsDelegate {
  static String get _baseUrl => "https://pokeapi.co/api/v2/pokemon";
  // ignore: missing_return
  static Future<Map<String, dynamic>> _handleHttpCall(String api) async {
    try {
      var response = await http.get(_baseUrl + api);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on Exception {
      (Exception e) {
        print(e.toString());
      };
    } finally {}
  }

  getLimited(int limit, {int offset = 100}) {
    _handleHttpCall("?limit=$limit&offset=$offset").then((value) {
      List<Pokemon> pList = [];
      List<dynamic> result = value["results"];
      result.forEach((element) {
        pList.add(Pokemon.fromJson(element as Map<String, dynamic>));
      });
      print(pList);
      updateHomeDelegate(pList);
    });
  }

  //Functions to update Home Screen
  @override
  HomeProtocol homeDelegate;

  @override
  setHomeProtocol(HomeProtocol delegate) {
    this.homeDelegate = delegate;
    getLimited(100);
  }

  @override
  updateHomeDelegate(List<Pokemon> pokemonList) {
    homeDelegate.getPokemon(pokemonList);
  }

  @override
  DetailsProtocol detailDelegate;

  @override
  setDetailProtocol(DetailsProtocol delegate) {
    this.detailDelegate = delegate;
  }

  @override
  updateDetailDelegate(PokemonDetails details) {
    this.detailDelegate.getDetails(details);
  }

  @override
  getPokemonDetails(int pokemon) {
    _handleHttpCall("/$pokemon").then((value) {
      PokemonDetails details = PokemonDetails.fromMap(value);
      updateDetailDelegate(details);
    });
  }
}
