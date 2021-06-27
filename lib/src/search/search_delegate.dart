import 'package:films/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:films/src/providers/peliculas_provider.dart';

class ItemsSearch extends SearchDelegate {
  final List<String> peliculas = [], peliculasRecientes = [];
  Pelicula peliculaSugerida;
  final PeliculasProvider peliculasProv = new PeliculasProvider();

  //Se definen las acciones que seran ejecutables desde el AppBar de la barra de busqueda (colocados en su derecha)
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  //Se definen los iconos Leading que se encuentran a la izquierda del AppBar
  @override
  Widget buildLeading(BuildContext context) {
    // Iconos que aparecen al inicio del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.close_menu,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Resultados de la busqueda que se mostrara al apretar el icono
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: peliculasProv.buscarPelicula(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            final peliculas = snapshot.data;
            return ListView(
              children: peliculas.map(
                (p) {
                  return ListTile(
                    title: Text(p.originalTitle),
                    subtitle: Text(
                      p.overview,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: FadeInImage(
                      image: NetworkImage(p.getPosterIMG()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      fit: BoxFit.contain,
                      width: 50.0,
                    ),
                    onTap: () {
                      close(context, null);
                      p.heroID = '';
                      Navigator.pushNamed(context, '/detail', arguments: p);
                    },
                  );
                },
              ).toList(),
            );
          } else {
            return Center(
              child: Text('Not founded results, try another word please'),
            );
          }
        },
      );
    }
  }

  //Definimos el constructor de sugerencias de peliculas (este metodo se lanzara cada vez que se actualice el query)
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: peliculasProv.buscarPelicula(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          //Se verifica si se obtuvieron datos
          if (snapshot.hasData) {
            //Se verifica si los datos no estan vacios
            if (snapshot.data.isNotEmpty) {
              peliculaSugerida = snapshot.data[0];
              return ListTile(
                title: Text(
                  peliculaSugerida.originalTitle,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                tileColor: Colors.grey[300],
                leading: FadeInImage(
                  image: NetworkImage(peliculaSugerida.getPosterIMG()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.contain,
                  width: 50.0,
                ),
                onTap: () {
                  close(context, null);
                  peliculaSugerida.heroID = '';
                  Navigator.pushNamed(context, '/detail',
                      arguments: peliculaSugerida);
                },
              );
            } else {
              return ListTile(
                title: Text('Not found suggestions'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
}
