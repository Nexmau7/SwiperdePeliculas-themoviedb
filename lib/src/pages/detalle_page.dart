import 'package:cartelera_de_peliculas_swiper/src/models/peliculas_models.dart';
import 'package:flutter/material.dart';

class DetallePage extends StatelessWidget {
  const DetallePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _sliverAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 15,
                ),
                _posterDetalle(context, pelicula),
                _descripcionPelicula(pelicula),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _sliverAppBar(Pelicula pelicula) {
    return SliverAppBar(
      forceElevated: true,
      automaticallyImplyLeading: true,
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      floating: true,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(pelicula.getBackDorpPathImage()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterDetalle(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image(
              image: NetworkImage(pelicula.getPosterImage()),
              height: 150,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Icon(Icons.stars),
                    SizedBox(width: 5),
                    Text(pelicula.voteAverage.toString(),
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcionPelicula(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Text(
        pelicula.overview,
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.justify,
      ),
    );
  }

}
