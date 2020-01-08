
import 'package:flutter/material.dart';
import 'package:flutter_pockemon/data/model/pokemon_model.dart';
import 'package:flutter_pockemon/router.dart';

void main() => runApp(MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: PokemonDetailRoute,
      title: "Detail Pokemon",
      home: DetailPokemon()
));

class DetailPokemon extends StatelessWidget {
  final Pokemon pokemon;
  DetailPokemon({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pokemon.name),
        ),
        body: Stack(
          children: <Widget>[
            Text("wkwkkwkw")
          ],
        ),
      );
  }
}