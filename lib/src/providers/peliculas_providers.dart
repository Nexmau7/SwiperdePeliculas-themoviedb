import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cartelera_de_peliculas_swiper/src/models/peliculas_models.dart';

//Esta clase servira para hacer la peticion y lugo almacenar los datos 
class PeliculasProvider{

  String _apiKey='060bb3ec6861931c53c47e5dcafa1ff5';
  String _lenguaje='es-ES';
  String _url='api.themoviedb.org';

  PeliculasProvider();

  //funcion que servira en el Future Builder para pedir y almacenar los datos
  Future <List<Pelicula>> getEnCines() async{
    //utilice URI para armar la url con sus campos necesarios
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apiKey,
      'language': _lenguaje,
    });

    //respuesta almacenara los datos de la peticion url 
    final respuesta = await http.get(url);
    //datosDecodificados almacenara la conversion de el dato recibido que se almaceno en respuesta
    final datosDecodificados = json.decode(respuesta.body);//json.decode decodifica 
    //almacenaPelicula es una instancia de la clase Peliculas 
    final almacenaPelicula = Peliculas.fromJsonList(datosDecodificados['results']);//enviara los datos ya decodificados en el constructor
    return almacenaPelicula.item;//Regresa la Lista que se llama item
  }

}