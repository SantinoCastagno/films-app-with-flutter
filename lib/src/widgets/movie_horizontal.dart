import 'package:films/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  //Se define el PageController como atributo global para escuchar sus eventos
  final PageController _pageController =
      //Se define la pagina inicial y la fraccion que cada pagina va a ocupar
      new PageController(initialPage: 1, viewportFraction: 0.35);
  final Function agregarPeliculas;

  MovieHorizontal({@required this.peliculas, @required this.agregarPeliculas});

  @override
  Widget build(BuildContext context) {
    //Se obtiene el size del dispositivo
    final _screenSize = MediaQuery.of(context).size;

    //Se captura el evento de su posicion en pixeles
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
          //Se define el identificador del hero para que sea unico en cada elemento del PageView
          peliculas[i].heroID = peliculas[i].id.toString() + "page";
          return _tarjeta(context, peliculas[i], _screenSize);
        },
        itemCount: peliculas.length,
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula, Size _screenSize) {
    Widget _tarjeta = Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          Hero(
            //Utilizamos el HeroId construido anteriormente para definir el tag unico
            tag: pelicula.heroID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterIMG()),
                width: _screenSize.height * 0.14,
                height: _screenSize.height * 0.22,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            //utilizamos el tema del contexto para cambiar el estilo de la fuente
            style: Theme.of(context).textTheme.caption,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );

    //Definimos el detector de gestos para envolver a cada tarjeta
    return GestureDetector(
      child: _tarjeta,
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: pelicula);
      },
    );
  }
}
