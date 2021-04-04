import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:films/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '1b566f4fbc893e9ecd9b942ca1a5579a';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

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

    final Peliculas peliculasObtenidas = new Peliculas.fromJsonList(decodedData['results']);
    // print(peliculasObtenidas.items[0].title);
    // print(peliculasObtenidas.items[0].overview);
  }
}
