
import 'dart:ui';

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
        backgroundColor: Colors.cyan,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(pokemon.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 140,
                    margin: EdgeInsets.fromLTRB(16.0, 98.0, 16.0, 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: Text(pokemon.weight),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(pokemon.height),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.network(
                              this.pokemon.img, 
                              width: 200.0,
                              fit:BoxFit.fill),
                            Text(
                              this.pokemon.name,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),

              Container(
                margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text("General Info",
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Type"),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: pokemon.type.map((f) => 
                                  Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8),
                                      child: FilterChip(
                                        backgroundColor: Colors.lightGreen,
                                        label: Text(
                                          f,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onSelected: (b) {}),
                                    )
                                ).toList(),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Text("Weaknesses"),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: pokemon.weaknesses.map((f) => 
                                  Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(8),
                                      child: FilterChip(
                                        backgroundColor: Colors.lightGreen,
                                        label: Text(
                                          f,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onSelected: (b) {}),
                                    )
                                ).toList(),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Text("Next Evolution"),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: pokemon.nextEvolution == null 
                                  ?  
                                    [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: FilterChip(
                                          backgroundColor: Colors.redAccent,
                                          label: Text(
                                            "Tidak Ada",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onSelected: (b) {}),
                                      )
                                    ]
                                  :
                                  pokemon.nextEvolution.map((f) => 
                                    Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: FilterChip(
                                          backgroundColor: Colors.lightGreen,
                                          label: Text(
                                            f.name,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onSelected: (b) {}),
                                      )
                                  ).toList(),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Text("Preview Evolution"),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: pokemon.prevEvolution == null 
                                  ?  
                                    [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: FilterChip(
                                          backgroundColor: Colors.redAccent,
                                          label: Text(
                                            "Tidak Ada",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onSelected: (b) {}),
                                      )
                                    ]
                                  :
                                  pokemon.prevEvolution.map((f) => 
                                    Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8),
                                        child: FilterChip(
                                          backgroundColor: Colors.lightGreen,
                                          label: Text(
                                            f.name,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onSelected: (b) {}),
                                      )
                                  ).toList(),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                )
              )
            ],
          ),
        )
      );
  }
}