import 'package:films/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final PageController _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);
  final Function agregarPeliculas;

  MovieHorizontal({@required this.peliculas, @required this.agregarPeliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    //Evento que estara "escuchando" lo que hace el pageController
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 20) {
        agregarPeliculas();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemBuilder: (context, i) {
          return _tarjeta(context, peliculas[i]);
        },
        itemCount: peliculas.length,
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    Widget _tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(pelicula.getPosterIMG()),
              height: 120,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            //manera directa de cambiar el estilo de la fuente:  style: TextStyle(fontSize: 12,),

            style: Theme.of(context).textTheme.caption,
            //utilizar un tema del contexto para cambiar el estilo de la fuente
          ),
        ],
      ),
    );

    return GestureDetector(
      child: _tarjeta,
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: pelicula);
      },
    );
  }

  // List<Widget> _tarjetas(BuildContext context) {
  //   return peliculas.map((pelicula) {
  //     return Container(
  //       margin: EdgeInsets.only(right: 15.0),
  //       child: Column(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20),
  //             child: FadeInImage(
  //               placeholder: AssetImage('assets/img/no-image.jpg'),
  //               image: NetworkImage(pelicula.getPosterIMG()),
  //               height: 120,
  //               fit: BoxFit.fill,
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           Text(
  //             pelicula.title,
  //             overflow: TextOverflow.ellipsis,
  //             //manera directa de cambiar el estilo de la fuente:  style: TextStyle(fontSize: 12,),

  //             style: Theme.of(context).textTheme.caption,
  //             //utilizar un tema del contexto para cambiar el estilo de la fuente
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}
