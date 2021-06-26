import 'package:films/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:films/src/providers/peliculas_provider.dart';

class ItemsSearch extends SearchDelegate {
  final List<String> peliculas = [], peliculasRecientes = [];
  Pelicula seleccion;
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
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            //Marco la seleccion para construir el resultado
            seleccion = peliculas[0];

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
              child: CircularProgressIndicator(),
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
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            //Marco la seleccion para construir el resultado
            seleccion = peliculas[0];
            if (seleccion == null) {
              return Container();
            } else {
              return ListTile(
                title: Text(
                  seleccion.originalTitle,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                tileColor: Colors.grey[300],
                leading: FadeInImage(
                  image: NetworkImage(seleccion.getPosterIMG()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.contain,
                  width: 50.0,
                ),
                onTap: () {
                  close(context, null);
                  seleccion.heroID = '';
                  Navigator.pushNamed(context, '/detail', arguments: seleccion);
                },
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
