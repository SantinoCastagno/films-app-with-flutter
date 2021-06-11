import 'package:films/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  MovieHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        pageSnapping: false,
        children: _tarjetas(context),
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
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
              //manera directa de cambiar el estilo de la fuente
              // style: TextStyle(
              //   fontSize: 12,
              // ),

              style: Theme.of(context).textTheme.caption,
              //utilizar un tema del contexto para cambiar el estilo de la fuente
            ),
          ],
        ),
      );
    }).toList();
  }
}
