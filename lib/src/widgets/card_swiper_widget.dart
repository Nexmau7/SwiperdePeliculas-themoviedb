import 'package:cartelera_de_peliculas_swiper/src/models/peliculas_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyCardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  const MyCardSwiper({@required this.peliculas, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Saca las dimensiones del dispositivo
    final _myScreenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _myScreenSize.width * 0.6,
        itemHeight: _myScreenSize.height * 0.5,
        itemCount: peliculas.length,
        itemBuilder: (context, index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(peliculas[index].getPosterImage()),
                fit: BoxFit.fill,
              ));
        },
      ),
    );
  }
}
