import 'package:cartelera_de_peliculas_swiper/src/models/peliculas_models.dart';
import 'package:flutter/material.dart';

class MyHorizontalSwiper extends StatelessWidget {
  final List<Pelicula> datoPeli;
  const MyHorizontalSwiper({@required this.datoPeli, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        pageSnapping: false,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        children: _tarjetas(context),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return datoPeli.map((listPeli) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(listPeli.getPosterImage()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              listPeli.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subhead
            )
          ],
        ),
      );
    }).toList();
  }
}
