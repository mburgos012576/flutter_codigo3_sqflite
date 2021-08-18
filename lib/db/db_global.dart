import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBGlobalManager {
  //crear instancias de conexion
  static Database? _mydatabase;
  static final DBGlobalManager db = DBGlobalManager._();
  DBGlobalManager._();

  //saber si existe o no bd sino lo crea
  Future<Database?> get getDatabase async {
    if (_mydatabase != null) return _mydatabase;
    _mydatabase = await initDB(); //metodo para crear BD
    return _mydatabase;
  }
  ////puede usar esta conexion de abajo
  // get database{
  //   return _mydatabase ?? initDB();
  // }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path,
        "BibliotecaDB.db"); //union del directorio donde esta la BD con el nombre

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {}, //abrir BD
      onCreate: (Database db, int version) async {
        //crear bd
        await db.execute(
            "CREATE TABLE Libro(Id INTEGER PRIMARY KEY, DescripcionLibro TEXT, Autor TEXT, urlImage TEXT )");
      },
    );
  }

  //Listar registros de tabla
  getAllLibrosRaw() async {
    final db = await getDatabase;
    final List resp = await db!.rawQuery("Select * from Libro");
    print(resp);
  }

  //otra forma de listar tabla
  getAllLibros() async {
    final db = await getDatabase;
    final resp = await db!.query("Libro");
    print(resp);
  }

  //insertar registros de forma cruda RAW
  Future<int> insertLibroRow() async {
    final db = await getDatabase;
    final int resp = await db!.rawInsert(
        "insert into Libro (Id, DescripcionLibro, Autor , urlImage) values (4,'La fiesta del Chivo2','Mario Vargas Llosa','https://imagessl7.casadellibro.com/a/l/t7/77/9788420470177.jpg');");
    print(resp);
    return resp;
  }

  //insertar registros de forma cruda db!.insert
  insertLibro() async {
    final db = await getDatabase;
    final resp = await db!.insert("Libro", {
      "Id": 6,
      "DescripcionLibro": "La Ciudad y los Perros",
      "Autor": "Mario Vargas Llosa",
      "urlImage":
          "https://imagessl7.casadellibro.com/a/l/t7/77/9788420470177.jpg"
    });
    print(resp);
  }

  //Update tablas
  updateLibrosRaw() async {
    final db = await getDatabase;
    final resp = await db!.rawUpdate(
        "update Libro set DescripcionLibro='La fiesta del chivo3' where Id=3");
    print(resp);
  }

  updateLibros() async {
    final db = await getDatabase;
    final resp = await db!.update(
        "Libro", {"DescripcionLibro": 'La fiesta del chivo2'},
        where: "Id=4");
    print(resp);
  }

  //Delete Registros de tabla
  deleteLibrosRaw() async {
    final db = await getDatabase;
    final resp = await db!.rawDelete("delete from Libro where Id=3");
    print(resp);
  }

  deleteLibros() async {
    final db = await getDatabase;
    final resp = await db!.delete("Libro", where: "Id=4");
    print(resp);
  }
}
