
import 'package:flutter/material.dart';

class DissmissibleItemWidget extends StatelessWidget {
  const DissmissibleItemWidget({
    Key? key,
  }) : super(key: key);

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
      },
      child: ListTile(
        leading: Container(
          width: 50.0,
          child: Image.network(
            "https://imagessl7.casadellibro.com/a/l/t7/77/9788420470177.jpg",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "La Fiesta del Chivo",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17.0,
          ),
        ),
        subtitle: Text("Mario Vargas Llosa"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(14.0)),
              child: IconButton(
                onPressed: () {},
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
                onPressed: () {},
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