import 'package:films/src/models/cast_model.dart';
import 'package:films/src/providers/peliculas_provider.dart';
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
                _crearPosterTitulo(context, _pelicula),
                _descripcion(context, _pelicula),
                _casting(context, _pelicula)
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
            height: 150,
            fit: BoxFit.fitHeight,
          ),
          Flexible(
            child: Center(
              child: Column(
                children: [
                  Text(
                    'VOTE AVERAGE: ' + _pelicula.voteAverage.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'VOTE COUNT: ' + _pelicula.voteCount.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _descripcion(BuildContext context, Pelicula _pelicula) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    child: Text(
      _pelicula.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.bodyText1,
    ),
  );
}

Widget _casting(BuildContext context, Pelicula _pelicula) {
  //Es necesario crear una instancia del provider para poder acceder al método de los actores
  final PeliculasProvider peliculasProv = PeliculasProvider();

  return FutureBuilder(
    future: peliculasProv.getCast(_pelicula.id.toString()),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      if (snapshot.hasData) {
        return _crearActoresPageView(snapshot.data);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

Widget _crearActoresPageView(List<Actor> actores) {
  return SizedBox(
    height: 250,
    child: PageView.builder(
      itemBuilder: (context, i) {
        return Column(
          children: [
            ClipRRect(
                child: Container(
                  child: FadeInImage(
                    image: NetworkImage(actores[i].getImage()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
                borderRadius: BorderRadius.circular(20)),
            Text(actores[i].name),
            Text(actores[i].character)
          ],
        );
      },
      pageSnapping: false,
      controller: PageController(
        viewportFraction: 0.3,
        initialPage: 1,
        keepPage: true,
      ),
    ),
  );
}
