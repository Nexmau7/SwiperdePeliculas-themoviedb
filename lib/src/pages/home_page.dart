import 'package:flutter/material.dart';

import 'package:cartelera_de_peliculas_swiper/src/widgets/card_swiper_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Peliculas'),
      ),
      body:Container(
        child: Column(
          children: <Widget>[
             _swiperTarjetasPrincipal()
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetasPrincipal() {
    return MyCardSwiper();
  }
}
