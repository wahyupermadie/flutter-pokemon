
import 'package:dio/dio.dart';
import 'package:flutter_pockemon/data/model/pokemon_model.dart';
import 'package:flutter_pockemon/utils/constants.dart';

class PokemonService {
  Dio dio;
  PokemonService(this.dio);
  
  Future fetchPokemon() async {
    try{
      var response = await dio.get(baseUrl);
      return Pokemon.fromJson(response.data);
    }catch(e){
      return e;
    }
  }
}