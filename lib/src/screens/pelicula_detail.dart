import 'package:flutter/material.dart';
import 'package:films/src/models/pelicula_model.dart';

class PeliculaDetail extends StatelessWidget {
  const PeliculaDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Obtener los parametros que fueron enviados desde la pantalla anterior
    final Pelicula _pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(_pelicula),
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula _pelicula) {
    return SliverAppBar(
      backgroundColor: Colors.indigoAccent,
      elevation: 2.0,
      floating: true,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(_pelicula.title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        background: FadeInImage(
          image: NetworkImage(_pelicula.getBackgroundIMG()),
          placeholder: AssetImage('assets/img/loading.gif'),
        ),
      ),
    );
  }
}
