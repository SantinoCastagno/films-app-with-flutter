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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: _pelicula.heroID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage(
                  _pelicula.getPosterIMG(),
                ),
                height: 150,
                fit: BoxFit.fitHeight,
              ),
            ),
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
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
        return _crearActoresPageView(context, snapshot.data);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

Widget _crearActoresPageView(BuildContext context, List<Actor> actores) {
  return SizedBox(
    height: 280,
    child: PageView.builder(
      itemCount: actores.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ClipRRect(
                  child: FadeInImage(
                    height: 180,
                    width: 150,
                    image: NetworkImage(actores[i].getImage()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            Text(
              actores[i].name,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              actores[i].character,
              style: Theme.of(context).textTheme.overline,
              textAlign: TextAlign.center,
            )
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
