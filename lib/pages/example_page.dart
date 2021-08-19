import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  String message = "Prueba de BD";
  late String title;
  late String stringFutureName = "X";
  String titulo = "Hola Mundo";
  List<String> miFamilia = [];
  List<Map<String, dynamic>> miMapa = [];

  @override
  initState() {
    super.initState();
    //title = "Dragon Ball Super";
    getData();
    //print(obtenerTitulo());
    getAuxiliar();
  }

  String obtenerTitulo() {
    return "Prueba de Titulo";
  }

  getAuxiliar() async {
    print(await getFuturuName());
    getFuturuName().then((data) {
      // con este metodo no se utiliza el await ni async y muestra lo mismo
      print("Dataaaaaa $data");
    }).catchError((error) {
      print(error);
    });

    getFutureList().then((value) {
      print(value);
    }).catchError((error) {
      print(error);
    });

    print("Mi lista........${await getFutureList()}");

    // this.miFamilia = await getFutureList();  ///obtener dato metodo 1
    // print(this.miFamilia);
    //
    // getFutureList().then((List<String> value){  ///obtener dato metodo 1
    //   this.miFamilia = value;
    //   print(this.miFamilia);
    // });
    //
    getFutureListMap().then((List<Map<String, dynamic>> value) {
      this.miMapa = value;
      print(value[1]["name"]);
      setState(() {});
    });
  }

  getData() async {
    // stringFutureName = await getFuturuName();
    // setState(() {
    //
    // });
    // getFuturuName().then((value) {
    //   stringFutureName = value;
    //   setState(() {
    //
    //   });
    // },);
  }

  Future<List<Map<String, dynamic>>> getFutureListMap() async {
    return await Future.delayed(Duration(seconds: 5), () {
      return [
        {"id": 1, "name": "Glorfindel"},
        {"id": 2, "name": "Tulkas"},
        {"id": 3, "name": "Feanor"}
      ];
    });
  }

  Future<String> getFuturuName() async {
    return await Future.delayed(Duration(seconds: 5), () {
      return "Michael Burgos";
    });
  }

  Future<List<String>> getFutureList() async {
    return await Future.delayed(Duration(seconds: 5), () {
      return ["Luciana", "Flavia", "Marlene"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getFutureList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //si tiene data
              //return Text("Holaaaaa");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data.toString()),
                  Text("Estado : ${snapshot.connectionState}"), //snapshot.connectionState maneja el estado del future
                ],
              );
            } else if (snapshot.hasError) {
              return Text("Ocurrio un Error");
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Estado : ${snapshot.connectionState}"),
                  Text("Cargandoooo"),
                ],
              );

            }

          },
        //child: Text(miMapa.toString()),
      )
      ),
    );
  }
}
