import 'package:cartelera_de_peliculas_swiper/search/search_delegate.dart';
import 'package:cartelera_de_peliculas_swiper/src/providers/peliculas_providers.dart';
import 'package:cartelera_de_peliculas_swiper/src/widgets/horizontal_swiper_card.dart';
import 'package:flutter/material.dart';

import 'package:cartelera_de_peliculas_swiper/src/widgets/card_swiper_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Instancia para pedir datos de la API
  final datoPelicula = PeliculasProvider();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    datoPelicula.disposeStream(); //Cierra el Patron Bloc
  }

  @override
  Widget build(BuildContext context) {
    //Se inicia para tener datos para el Stream
    datoPelicula.getPopulares();

    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Peliculas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: SearhApi());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
              child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetasPrincipal(),
              _horizontalCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _swiperTarjetasPrincipal() {
    return FutureBuilder(
      future: datoPelicula.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return MyCardSwiper(
            peliculas: snapshot.data,
          );
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _horizontalCard(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subhead)),
          SizedBox(
            height: 15,
          ),
          //Usando Patron Bloc
          StreamBuilder(
            stream: datoPelicula.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MyHorizontalSwiper(
                  datoPeli: snapshot.data,
                  paginaSiguiente: datoPelicula.getPopulares,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
