class Libro{
  int? id;
  String descripcionLibro;
  String autor;
  String urlmage;

  Libro({this.id,required this.descripcionLibro,required this.autor,required this.urlmage});

  Map<String, dynamic> convertirAMap(){  //para construir MAP queserĂ¡ utilizado en metodo Insert
    return {
      "Id":id,
      "DescripcionLibro" : descripcionLibro,
      "Autor" : autor,
      "urlImage" : urlmage,
    };
  }


}