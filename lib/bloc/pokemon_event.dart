
import 'package:equatable/equatable.dart';
import 'package:flutter_pockemon/data/model/pokemon_model.dart';

abstract class PokemonEvent extends Equatable {
  PokemonEvent();
  @override
  List<Object> get props => [];
}

class PokemonInitialEvent extends PokemonEvent {}

class PokemonOnListCickEvent extends PokemonEvent {
  final Pokemon pokemon;
  PokemonOnListCickEvent({this.pokemon});

  @override 
  List<Object> get props => [pokemon];
}