
import 'package:flutter/material.dart';
import 'package:flutter_pockemon/main.dart';
import 'package:flutter_pockemon/pokemon_detail.dart';

const String PokemonMainRoute = "/";
const String PokemonDetailRoute = "/detailpokemon";

class Router {
  static Route<dynamic> generateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case PokemonMainRoute:
        return MaterialPageRoute(builder: (_) => MyApp());
      case PokemonDetailRoute:
        var data = routeSettings.arguments;
        return MaterialPageRoute(builder: (_) => DetailPokemon(pokemon: data,));
      default:
        return MaterialPageRoute(builder: (_) => MyApp());
    }
  }
}
