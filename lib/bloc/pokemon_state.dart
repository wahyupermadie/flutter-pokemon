
import 'package:equatable/equatable.dart';
import 'package:flutter_pockemon/data/model/pokemon_model.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();
}

class PokemonInitialState extends PokemonState {
  @override
  List<Object> get props => [];
}

class PokemonLoadedState extends PokemonState {
  final PokemonResponse pokemons;
  PokemonLoadedState({this.pokemons});

  @override
  List<Object> get props => [pokemons];
}

class PokemonErrorState extends PokemonState {
  final String error;
  PokemonErrorState({this.error});

  @override
  List<Object> get props => [error];

}