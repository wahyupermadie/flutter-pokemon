import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pockemon/bloc/pokemon_bloc.dart';
import 'package:flutter_pockemon/data/model/pokemon_model.dart';
import 'package:flutter_pockemon/data/network/network_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/pokemon_event.dart';
import 'bloc/pokemon_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

class _MoviesList extends StatelessWidget {
  final List<Pokemon> pokemons;

  _MoviesList({this.pokemons});
  
  ListTile _listTile(BuildContext context, int index) {
    return ListTile(
      title: new Text(pokemons[index].name.toString()),
      subtitle: new Text(pokemons[index].img.toString(),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        softWrap: true,),
    );
  }

  Container cardConatiner(BuildContext context, int index){
    return Container(
      margin: EdgeInsets.all(1.0),
      child: Card(
        elevation: 8.0,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(pokemons[index].img),
            ),
            Flexible(
              flex: 1,
              child: Text(pokemons[index].name),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.80,
      children: List.generate(pokemons.length, (index){
        return cardConatiner(context, index);
      }),
    );
  }
}

