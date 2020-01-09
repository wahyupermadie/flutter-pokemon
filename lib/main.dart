import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pockemon/bloc/pokemon_bloc.dart';
import 'package:flutter_pockemon/data/model/pokemon_model.dart';
import 'package:flutter_pockemon/data/network/network_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pockemon/router.dart';
import 'package:transparent_image/transparent_image.dart';
import 'bloc/pokemon_event.dart';
import 'bloc/pokemon_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: PokemonMainRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonListWidget(title: 'Pokemon List Widget'),
    );
  }
}

class PokemonListWidget extends StatefulWidget{
  final String title;

  PokemonListWidget({this.title});

  @override
  State createState() => PokemonListState();
}

class PokemonListState extends State<PokemonListWidget>{
  PokemonBloc pokemonBloc;

  @override
  void initState() {
    super.initState();
    pokemonBloc = PokemonBloc(pokemonService: PokemonService(Dio()));
  }

  @override
  void dispose() {
    pokemonBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pokemonBloc.add(PokemonInitialEvent());
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return pokemonBloc;
        },
        child: BlocListener<PokemonBloc, PokemonState>(
          bloc: pokemonBloc,
          listener: (context, state){
            if(state is PokemonErrorState){
              Scaffold.of(context).showSnackBar(
                snackBar(state.error)
              );
            }
          },
          child: BlocBuilder<PokemonBloc, PokemonState>(
            bloc: pokemonBloc, 
            builder: (BuildContext context, PokemonState state) {
              if(state is PokemonLoadedState){
                  return _MoviesList(pokemons: state.pokemons.pokemon,);
              }
              else if(state is PokemonErrorState){
                  return Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                    ) ,
                  );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

SnackBar snackBar(text) {
  return SnackBar(
    content: Text(text),
    backgroundColor: Colors.red,
  );
}

Color pokeColor(Pokemon pokemon){
  if (pokemon.type[0] == "Grass") {
    return Colors.green;
  }else if(pokemon.type[0] == "Water"){
    return Colors.blue;
  }else{
    return Colors.redAccent;
  }
}

class _MoviesList extends StatelessWidget {
  final List<Pokemon> pokemons;

  _MoviesList({this.pokemons});

  Container cardConatiner(BuildContext context, int index){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, PokemonDetailRoute, arguments: pokemons[index]),
        child: Card(
          color: pokeColor(pokemons[index]),
          elevation: 8.0,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topCenter,
                              height: 120.0,
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: pokemons[index].img,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: pokemons[index].type.map((f) => 
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: FilterChip(
                                        backgroundColor: Colors.lightGreen,
                                        label: Text(
                                          f,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onSelected: (b) {}),
                                    )
                                  ).toList()
                                ),
                              ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                              child:  Text(pokemons[index].name,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                            )
                        ],
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                                "assets/images/pokeball.png",
                                color: Colors.white.withOpacity(0.15),
                                width: 120,
                                height: 120,
                              ),
                        )
                    ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      children: List.generate(pokemons.length, (index){
        return cardConatiner(context, index);
      }),
    );
  }
}

