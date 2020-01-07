

import 'package:bloc/bloc.dart';
import 'package:flutter_pockemon/bloc/pokemon_event.dart';
import 'package:flutter_pockemon/bloc/pokemon_state.dart';
import 'package:flutter_pockemon/data/model/pokemon_model.dart';
import 'package:flutter_pockemon/data/network/network_service.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonService pokemonService;
  PokemonBloc({this.pokemonService});

  @override
  PokemonState get initialState => PokemonInitialState();

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if(event is PokemonInitialEvent){
      yield PokemonInitialState();
      try {
        PokemonResponse pokemonResponse = await pokemonService.fetchPokemon();
        yield PokemonLoadedState(pokemons: pokemonResponse);
      } catch (e) {
        yield PokemonErrorState(error: e.toString());
      }
    }
  }
}
