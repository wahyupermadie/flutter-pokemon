
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_pockemon/data/model/pokemon_model.dart';
import 'package:flutter_pockemon/utils/constants.dart';

class PokemonService {
  Dio dio;
  PokemonService(this.dio);
  
  Future fetchPokemon() async {
    try{
      final response = await dio.get(baseUrl);
      return PokemonResponse.fromJson(json.decode(response.data));
    }catch(e){
      print(e);
      return e;
    }
  }
}