import 'package:flutter/material.dart';
import 'package:films/src/models/pelicula_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> elementos;
  CardSwiper({@required this.elementos});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: 25),
      //Utilizamos el swiper importado de su paquete
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.5,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          //Se define el identificador del hero de cada tarjeta para que sea unico
          elementos[index].heroID = elementos[index].id.toString() + "card";
          return Hero(
            tag: elementos[index].heroID,
            child: ClipRRect(
              child: GestureDetector(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(elementos[index].getPosterIMG()),
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: elementos[index],
                  );
                },
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
        itemCount: elementos.length,
        //Se define el autoplay y su delay
        autoplay: true,
        autoplayDelay: 10000,
      ),
    );
  }
}
