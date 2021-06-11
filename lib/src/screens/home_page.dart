import 'package:flutter/material.dart';
import 'package:films/src/providers/peliculas_provider.dart';
import 'package:films/src/widgets/card_swiper_widget.dart';
import 'package:films/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Peliculas Nuevas"),
          backgroundColor: Colors.pink,
          centerTitle: false,
          actions: [
            IconButton(icon: Icon(Icons.airplanemode_on), onPressed: () {})
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _swiperTarjetas(),
              _footer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
        future: peliculasProvider.getEnCines(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(elementos: snapshot.data);
          } else {
            return Container(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
              ),
            );
          }
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontal(
                      peliculas: snapshot.data,
                      //Se esta pasando una referencia al metodo getPopulares
                      //Por esa no lleva los parentesis colocados, ya que no es necesario ejecutarlo
                      agregarPeliculas: peliculasProvider.getPopulares);
                } else {
                  return Container(
                    height: 200.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                      ),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
