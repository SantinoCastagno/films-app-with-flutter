import 'package:films/src/providers/peliculas_provider.dart';
import 'package:films/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Peliculas de actualidad"),
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
              height: 400.0,
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
    print("Output SC: ");
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          FutureBuilder(
              future: peliculasProvider.getPopulares(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return Text("Pelicula mas popular:\"" +
                      snapshot.data[1].title +
                      "\"");
                } else {
                  return Container(
                    height: 400.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                      ),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
