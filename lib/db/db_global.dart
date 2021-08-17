import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBGlobalManager{

  //crear instancias de conexion
  static Database? _mydatabase;
  static final DBGlobalManager db = DBGlobalManager._();
  DBGlobalManager._();

  //saber si existe o no bd sino lo crea
  Future<Database?> get getDatabase async{
    if(_mydatabase != null) return _mydatabase;
    _mydatabase = await initDB(); //metodo para crear BD
    return _mydatabase;
  }
  ////puede usar esta conexion de abajo
  // get database{
  //   return _mydatabase ?? initDB();
  // }

  Future<Database> initDB()async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "BibliotecaDB.db"); //union del directorio donde esta la BD con el nombre

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},  //abrir BD
      onCreate: (Database db, int version)async{ //crear bd
        await db.execute("CREATE TABLE Libro(Id INTEGER PRIMARY KEY, DescripcionLibro TEXT, Autor TEXT, urlImage TEXT ");
      },
    );
  }

  //insertar registros
  insertLibroRow()async{
    final db = await getDatabase;
    final int resp = await db!.rawInsert("insert into Libro (Id, DescripcionLibro, Autor , urlImage) values (3,'La fiesta del Chivo2','Mario Vargas Llosa','https://imagessl7.casadellibro.com/a/l/t7/77/9788420470177.jpg');");
    print(resp);
    return resp;
  }

}