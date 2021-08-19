import 'package:flutter/material.dart';
import 'package:flutter_codigo3_sqflite/db/db_global.dart';
import 'package:flutter_codigo3_sqflite/models/libro_model.dart';
import 'package:flutter_codigo3_sqflite/widgets/dissmissible_item_widget.dart';
import 'package:flutter_codigo3_sqflite/widgets/input_dialog_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String,dynamic>> misLibros = []; //variable donde alojaremos el resultado de getAllLibros del metodo(getData)
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _autorController = TextEditingController();
  TextEditingController _imagenController = TextEditingController();

  @override
  initState() {
    super.initState();
    DBGlobalManager.db;
    getData();
  }
  getData()async{
    //misLibros = await DBGlobalManager.db.getAllLibros();
    //o esta
    await DBGlobalManager.db.getAllLibros().then((value){
      misLibros=value;
    });
    setState(() {

    });
    //print(misLibros);
  }

  showAddModal(BuildContext context) {
    //metodo Alerta
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
                  SvgPicture.asset(
                    'assets/image/add.svg',
                    height: 120,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputWidgetDialog(controller: _descripcionController,icon: Icons.book, hint: "Libro"),
                  SizedBox(
                    height: 10,
                  ),
                  InputWidgetDialog(controller: _autorController,icon: Icons.person, hint: "Autor"),
                  SizedBox(
                    height: 10,
                  ),
                  InputWidgetDialog(controller: _imagenController,icon: Icons.image, hint: "Url Portada"),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black38),
                  )),
              TextButton(
                  onPressed: () {
                    int id = misLibros.length + 1;
                    Libro data = new Libro(
                      //id: id  ,
                      autor: _autorController.text,
                      descripcionLibro: _descripcionController.text,
                      urlmage: _imagenController.text,
                    );
                    DBGlobalManager.db.insertLibro(data);
                    Navigator.pop(context);
                    getData();
                  },
                  child: Text(
                    "Aceptar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          );
        });
  }
  showAddModalEdit(BuildContext context) {
    //metodo Alerta
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Editar Libro"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/image/add.svg',
                    height: 120,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputWidgetDialog(controller: _descripcionController,icon: Icons.book, hint: "Libro"),
                  SizedBox(
                    height: 10,
                  ),
                  InputWidgetDialog(controller: _autorController,icon: Icons.person, hint: "Autor"),
                  SizedBox(
                    height: 10,
                  ),
                  InputWidgetDialog(controller: _imagenController,icon: Icons.image, hint: "Url Portada"),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black38),
                  )),
              TextButton(
                  onPressed: () {
                    //int id = misLibros.length + 1;
                    Libro data = new Libro(
                      //id: id  ,
                      autor: _autorController.text,
                      descripcionLibro: _descripcionController.text,
                      urlmage: _imagenController.text,
                    );
                    DBGlobalManager.db.insertLibro(data);
                    Navigator.pop(context);
                    getData();
                  },
                  child: Text(
                    "Editar",
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
        onPressed: ()async {
          showAddModal(context);
          // Libro data = new Libro( //clase para pasar parametros a metodos CRUD
          //     id: 5,
          //     descripcionLibro: "Tradiciones Peruanas2",
          //     autor: "Ricardo Palma2",
          //     urlmage:"https://pub.utp.edu.pe/sites/default/files/obra-teatro2.png");
          // DBGlobalManager.db.insertLibro(data);

          //print(await DBGlobalManager.db.getAllLibros());
          //DBGlobalManager.db.insertLibroRow();
          //DBGlobalManager.db.getAllLibrosRaw();
          //DBGlobalManager.db.getAllLibros();

          //DBGlobalManager.db.insertLibroRaw(data);
          //DBGlobalManager.db.updateLibros();
          //DBGlobalManager.db.deleteLibros();
          //DBGlobalManager.db.updateLibros();
          //print(await DBGlobalManager.db.getAllLibros());
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
              Text(
                "Cantidad Libros : ${misLibros.length}",
                style: TextStyle(
                  color: Color(0xff212121),
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              // DissmissibleItemWidget(),
              // DissmissibleItemWidget(),
              ListView.builder(  //este Widget maneja todos lo libros que llega de getAllLibros
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: misLibros.length,
                itemBuilder: (BuildContext context, int index){
                  return DissmissibleItemWidget(
                    title: misLibros[index]["DescripcionLibro"],
                    autor: misLibros[index]["Autor"],
                    url: misLibros[index]["urlImage"],
                    onDelete: ()async{
                      await DBGlobalManager.db.deleteLibros(misLibros[index]["Id"]);
                      getData();
                    },
                    onEdit: ()async{
                     await DBGlobalManager.db.updateLibros(misLibros[index]["Id"]);
                     getData();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
