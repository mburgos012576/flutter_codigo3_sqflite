
import 'package:flutter/material.dart';

class DissmissibleItemWidget extends StatelessWidget {
  String title;
  String autor;
  String url;
  Function? onDelete;
  Function? onEdit;
  DissmissibleItemWidget({required this.title,required this.autor, required this.url, this.onDelete, this.onEdit});


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),  //asignar clave unica
      background: Container(),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
        ),
        child: Center(
          child: Text("Eliminar",style: TextStyle(color: Colors.white),),
        ),
      ),
      direction: DismissDirection.endToStart, //bloquea arrastar de izquierda a derecha
      onDismissed: (DismissDirection direction){
        print("Eliminando....");
        this.onDelete!();
      },

      child: ListTile(
        leading: Container(
          width: 50.0,
          child: Image.network(
            this.url,//"https://imagessl7.casadellibro.com/a/l/t7/77/9788420470177.jpg",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          this.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17.0,
          ),
        ),
        subtitle: Text(this.autor),//Text("Mario Vargas Llosa"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(14.0)),
              child: IconButton(
                onPressed: () {
                  this.onDelete!();
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(14.0)),
              child: IconButton(
                onPressed: () {
                  this.onEdit!();
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
