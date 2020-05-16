

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String,dynamic> json){
    castId        = json['cast_id'];
    character     = json['character'];
    creditId      = json['credit_id'];
    gender        = json['gender'];
    id            = json['id'];
    name          = json['name'];
    order         = json['order'];
    profilePath   = json['profile_path'];
  }

  getPerfilImage(){
    if(profilePath != null){
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }else{
      return 'https://vectorified.com/images/no-profile-picture-icon-22.jpg';
    }
  }

}

class Actores{

  List<Actor> item = List();

  Actores.fromJsonList(List<dynamic> jsonList){

    if(jsonList == null) return;

    for (var respuesta in jsonList) {
      final datoActor = Actor.fromJsonMap(respuesta);

      item.add(datoActor);
    }
  } 
}
