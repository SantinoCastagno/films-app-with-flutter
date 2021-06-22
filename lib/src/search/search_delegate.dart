import 'package:films/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:films/src/providers/peliculas_provider.dart';

class ItemsSearch extends SearchDelegate {
  final List<String> peliculas = [], peliculasRecientes = [];
  String seleccion;
  final PeliculasProvider peliculasProv = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones que se pueden ejecutar desde el AppBar

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Iconos que aparecen al inicio del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.arrow_menu,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Resultados de la busqueda que se mostraran
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sugerencias que aparecen
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: peliculasProv.buscarPelicula(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
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
                      placeholder: AssetImage('assets/no-image.jpg'),
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
}

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     //Si la query esta vacia entonces coloca las peliculas recientes
//     //Si la query tiene algo escrito, entonces se sugieren las peliculas que empiezan con dicho query
//     final List<String> listaSugerida = (query.isEmpty)
//         ? peliculasRecientes
//         : peliculas
//             .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
//             .toList();

//     return ListView.builder(
//       itemCount: listaSugerida.length,
//       itemBuilder: (context, i) {
//         return ListTile(
//           leading: Icon(Icons.movie_creation_outlined),
//           title: Text(listaSugerida[i]),
//           onTap: () {
//             seleccion = listaSugerida[i];
//             //Metodo que permitiria mostrar los resultados si lo necesitaramos (sin desplegar un screen completo)
//             // showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
