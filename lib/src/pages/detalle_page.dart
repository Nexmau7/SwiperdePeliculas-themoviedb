import 'package:flutter/material.dart';

import 'package:cartelera_de_peliculas_swiper/src/models/actores_modelo.dart';
import 'package:cartelera_de_peliculas_swiper/src/models/peliculas_models.dart';
import 'package:cartelera_de_peliculas_swiper/src/providers/peliculas_providers.dart';

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
                _descripcionPelicula(pelicula, context),
                _listaActores(pelicula),
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
                  style: Theme.of(context).textTheme.subtitle2,
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

  Widget _descripcionPelicula(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        children: <Widget>[
          Text(
            pelicula.overview,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                'Actores',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _listaActores(Pelicula pelicula) {
    final actor = PeliculasProvider();

    return FutureBuilder(
      future: actor.getActores(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _tarjetasActores(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _tarjetasActores(List<Actor> actores) {
    return SizedBox(
      height: 230.0,
      child: PageView.builder(
          itemCount: actores.length,
          pageSnapping: false,
          controller: PageController(
            initialPage: 1,
            viewportFraction: 0.3,
          ),
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      height: 160.0,
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(actores[index].getPerfilImage()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    actores[index].name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
            );
          }),
    );
  }
}
