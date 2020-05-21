import 'package:cartelera_de_peliculas_swiper/src/models/peliculas_models.dart';
import 'package:flutter/material.dart';

class MyHorizontalSwiper extends StatelessWidget {
  final List<Pelicula> datoPeli;
  final Function paginaSiguiente;

  const MyHorizontalSwiper({
    @required this.datoPeli,
    @required this.paginaSiguiente,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final _controller = PageController(
      initialPage: 1,
      viewportFraction: 0.3,
    );

    //Necesita estar escuchando el controlador del PageView
    _controller.addListener(() {
      if (_controller.position.pixels <=
          _controller.position.maxScrollExtent - 200) {
        paginaSiguiente(); //Permite llamar mas peliculas
      }
    });

    return Container(
      height: _screenSize.height * 0.35,
      child: PageView.builder(
        pageSnapping: false,
        controller: _controller,
        itemBuilder: (context, index) {
          return _tarjeta(context, datoPeli[index]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula dato) {
    dato.claveHero= "${dato.id} - Horizontal"; 

    final _tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: dato.claveHero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(dato.getPosterImage()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(dato.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subhead)
        ],
      ),
    );

    return GestureDetector(
      child: _tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: dato);
      },
    );
  }
}
