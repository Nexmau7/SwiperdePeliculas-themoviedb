import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyCardSwiper extends StatelessWidget {
  final List<String> peliculas;

  const MyCardSwiper({this.peliculas, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Saca las dimensiones del dispositivo
    final _myScreenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top:10),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _myScreenSize.width * 0.7,
        itemHeight: _myScreenSize.height * 0.5,
        itemCount: 3,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
                  'https://images-na.ssl-images-amazon.com/images/I/718-YbPovjL._AC_SY741_.jpg',
              fit: BoxFit.fill,//Cambiar por Cover Otro Rato
            )
          );
        },
      ),
    );
  }
}
