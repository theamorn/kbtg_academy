import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kbtg_academy/pokemon.dart';

class PokemonBloc {
  PokemonBloc() {
    _pokemonList.addListener(() {
      pokemonNameList.value = _pokemonList.value.map((e) => e.name).toList();
    });
  }

  final ValueNotifier<List<Pokemon>> _pokemonList =
      ValueNotifier<List<Pokemon>>(
          [Pokemon(name: "test", url: "https://pokeapi.co/api/v2/pokemon/1/")]);

  final ValueNotifier<List<String>> pokemonNameList = ValueNotifier([]);

  void searchPokemon(String name) {
    final filteredList = _pokemonList.value
        .where((pokemonName) => pokemonName.name.contains(name))
        .toList();
    pokemonNameList.value = filteredList.map((e) => e.name).toList();
  }

  Future<void> fetchPokemonList() async {
    try {
      final url =
          Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=500&offset=20");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final value = jsonResponse['results'] as List<dynamic>;
        _pokemonList.value = value
            .map((dynamic item) =>
                Pokemon.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        print("===failed");
      }
    } catch (e) {
      rethrow;
    }
  }
}
