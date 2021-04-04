import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List elementos;
  const CardSwiper({@required this.elementos});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.5,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            child: Image.network(
              "https://source.unsplash.com/collection/190727/1920x1080",
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20),
          );
        },
        itemCount: elementos.length,
        autoplay: true,
      ),
    );
  }
}
