import 'package:flutter/material.dart';

import 'package:films/src/screens/pelicula_detail.dart';
import 'package:films/src/screens/home_page.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Peliculas',
        initialRoute: '/',
        routes: {
          '/': (buildContext) => HomePage(),
          '/detail': (buildContext) => PeliculaDetail(),
        });
  }
}
