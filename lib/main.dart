import 'package:cartelera_de_peliculas_swiper/src/pages/detalle_page.dart';
import 'package:cartelera_de_peliculas_swiper/src/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'detalle':(context)=>DetallePage(),
      },
    );
  }
}
