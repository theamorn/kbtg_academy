// Create a test for pokemon bloc
import 'package:flutter_test/flutter_test.dart';

import 'package:kbtg_academy/bloc/pokemon_bloc.dart';

void main() {
  PokemonBloc bloc = PokemonBloc();
  setUp(() {});

  test("test fetch pokemon", () {
    bloc.fetchPokemonList();
    expect(bloc.pokemonNameList.value.length, 0);
  });

  // test("test filter list", () {
  //   bloc.searchPokemon("pika");
  //   expect(actual, findsOneWidget);
  // });
}
