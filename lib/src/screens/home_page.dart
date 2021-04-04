import 'package:films/src/providers/peliculas_provider.dart';
import 'package:films/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Peliculas en cines"),
          backgroundColor: Colors.pink,
          centerTitle: false,
          actions: [
            IconButton(icon: Icon(Icons.airplanemode_on), onPressed: () {})
          ],
        ),
        body: Container(
          child: Column(
            children: [
              _swiperTarjetas(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    final peliculasProvider = new PeliculasProvider();
    peliculasProvider.getEnCines();

    return CardSwiper(
      elementos: [1, 2, 3, 4],
    );
  }
}
