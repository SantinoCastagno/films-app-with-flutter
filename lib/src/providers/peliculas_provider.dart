import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:films/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '1b566f4fbc893e9ecd9b942ca1a5579a';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  //Método que retorna de manera asincrónica una lista con las peliculas que se encuentran en cines.
  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(
      _url,
      '3/movie/now_playing',
      {
        'api_key': _apikey,
      },
    );

    final response = await http.get( url );
    final decodedData = json.decode(response.body);
    final Peliculas peliculasEnCines = new Peliculas.fromJsonList(decodedData['results']);

    return peliculasEnCines.items;
  }

  //Método que retorna de manera aincrónica una lista con las peliculas populares
  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(
      _url,
      '3/movie/popular',
      {
        'api_key': _apikey,
      },
    );

    final response = await http.get( url );
    final decodedData = json.decode(response.body);
    final Peliculas peliculasPopulares = new Peliculas.fromJsonList(decodedData['results']);

    return peliculasPopulares.items;
  }
}
