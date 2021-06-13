import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:films/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '1b566f4fbc893e9ecd9b942ca1a5579a';
  String _url = 'api.themoviedb.org';
  int _popularPage = 0;
  List<Pelicula> _populares = new List();
  bool _cargando = false;

  //Creación del stream
  final _popularesStreamController =
      new StreamController<List<Pelicula>>.broadcast();

  //Metodo get no-dinamico para obtener la propiedaded que nos provee la capacidad de agregar
  //Información al flujo del "StreamController" y dicha información es un listado de peliculas
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  //Metodo get para obtener listados de peliculas desde el StreamController
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  //Metodo para cerrar el StreamController creado
  void disposeStream() {
    _popularesStreamController.close();
  }

  //Método que retorna de manera asincrónica una lista con las peliculas populares
  getPopulares() async {
    //Verificamos si se estan cargando otras peliculas para no hacer solicitudes innecesarias a la api.
    if (!_cargando) {
      _cargando = true;
      _popularPage++;
      final url = Uri.https(
        _url,
        '3/movie/popular',
        {
          'api_key': _apikey,
          'page': _popularPage.toString(),
        },
      );
      final _respuestaProcesada = await procesarRespuesta(url);
      _populares.addAll(_respuestaProcesada);
      popularesSink(_populares);
      _cargando = false;
    }
  }

  //Método que retorna de manera asincrónica una lista con las peliculas que se encuentran en cines.
  Future<List<Pelicula>> getEnCines() {
    final url = Uri.https(
      _url,
      '3/movie/now_playing',
      {
        'api_key': _apikey,
      },
    );
    return procesarRespuesta(url);
  }

  Future<List<Pelicula>> procesarRespuesta(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final Peliculas peliculas =
        new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }
}
