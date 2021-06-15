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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                _crearPosterTitulo(context, _pelicula),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula _pelicula) {
    return SliverAppBar(
      backgroundColor: Colors.grey[800],
      elevation: 2.0,
      floating: true,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          _pelicula.title,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        background: Container(
          child: FadeInImage(
            fit: BoxFit.cover,
            fadeInDuration: Duration(seconds: 1),
            fadeInCurve: Curves.decelerate,
            image: NetworkImage(_pelicula.getBackgroundIMG()),
            placeholder: AssetImage('assets/img/loading.gif'),
          ),
        ),
      ),
    );
  }

  Widget _crearPosterTitulo(BuildContext context, Pelicula _pelicula) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              _pelicula.getPosterIMG(),
            ),
            height: 200,
            fit: BoxFit.fitHeight,
          ),
          Flexible(
            child: Center(
              child: Column(children: [
                Text('VOTE AVERAGE: ' + _pelicula.voteAverage.toString(),
                    style: Theme.of(context).textTheme.headline5),
                Text('VOTE COUNT: ' + _pelicula.voteCount.toString(),
                    style: Theme.of(context).textTheme.headline6)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
