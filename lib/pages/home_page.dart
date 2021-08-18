import 'package:flutter/material.dart';
import 'package:flutter_codigo3_sqflite/db/db_global.dart';
import 'package:flutter_codigo3_sqflite/widgets/dissmissible_item_widget.dart';
import 'package:flutter_codigo3_sqflite/widgets/input_dialog_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  initState(){
    super.initState();
    DBGlobalManager.db;
  }
  showAddModal(BuildContext context) {  //metodo Alerta
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Agregar Libro"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/image/add.svg', height: 120,),
                  InputWidgetDialog(icon: Icons.book,hint:  "Libro"),
                  SizedBox(height: 10,),
                  InputWidgetDialog(icon: Icons.person,hint: "Autor"),
                  SizedBox(height: 10,),
                  InputWidgetDialog(icon: Icons.image,hint: "Url Portada"),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black38),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Aceptar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //showAddModal(context);
          //DBGlobalManager.db.insertLibroRow();
          //DBGlobalManager.db.getAllLibrosRaw();
          //DBGlobalManager.db.getAllLibros();
          //DBGlobalManager.db.insertLibro();
          //DBGlobalManager.db.updateLibros();
          //DBGlobalManager.db.deleteLibros();
          DBGlobalManager.db.updateLibros();
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff212121),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mis Libros",
                style: TextStyle(
                  color: Color(0xff212121),
                  fontSize: 48.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              DissmissibleItemWidget(),
              DissmissibleItemWidget(),
            ],
          ),
        ),
      ),
    );
  }
}


