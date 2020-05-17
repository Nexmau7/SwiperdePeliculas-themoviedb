import 'package:cartelera_de_peliculas_swiper/src/models/peliculas_models.dart';
import 'package:cartelera_de_peliculas_swiper/src/providers/peliculas_providers.dart';
import 'package:flutter/material.dart';

class SearhApi extends SearchDelegate {
  final pelicula = PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: pelicula.getBusquedaPeliculas(query.toLowerCase()),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        final pelicula = snapshot.data;

        if (snapshot.hasData) {
          return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: pelicula.length,
              itemBuilder: (context, i) {
                pelicula[i].claveHero = '${pelicula[i].id} - Busqueda';
                return ListTile(
                  contentPadding: EdgeInsets.all(5.0),
                  title: Text(pelicula[i].title),
                  leading: Hero(
                    tag: pelicula[i].claveHero,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        image: NetworkImage(pelicula[i].getPosterImage()),
                      ),
                    ),
                  ),
                  onTap: () {
                    
                    Navigator.pushNamed(context, 'detalle',
                        arguments: pelicula[i]);
                  },
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }
}
