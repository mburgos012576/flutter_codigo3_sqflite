import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_codigo3_sqflite/models/libro_model.dart';
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
  Future<List> getAllLibros() async {
    final db = await getDatabase;
    final resp = await db!.query("Libro");
    print(resp);
    return resp; //?? [];  //si es nulo muestra lista vacia
  }

  //insertar registros de forma cruda RAW
  Future<int> insertLibroRaw(Libro data) async {
    final db = await getDatabase;
    final int resp = await db!.rawInsert(
        "insert into Libro (Id, DescripcionLibro, Autor , urlImage) values ('${data.id}','${data.descripcionLibro}','${data.autor}','${data.urlmage}');");
    //print(resp);
    await getAllLibros();
    return resp;
  }

  //insertar registros de forma cruda db!.insert
  Future<int> insertLibro(Libro data) async {
    final db = await getDatabase;
    final resp = await db!.insert("Libro", data.convertirAMap());
    // {
    //   "Id": data.id,
    //   "DescripcionLibro": data.descripcionLibro,
    //   "Autor": data.autor,
    //   "urlImage":data.urlmage
    // }
    //);
    ////print(resp);
    await getAllLibros();
    return resp;
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
