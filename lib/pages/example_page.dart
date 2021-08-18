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

  @override
  initState() {
    super.initState();
    //title = "Dragon Ball Super";
    getData();
  }

  String obtenerTitulo() {
    return "Prueba de Titulo";
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

  Future<String> getFuturuName() async {
    return await Future.delayed(Duration(seconds: 5), () {
      return "Michael Burgos";
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
          future: getFuturuName(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //si tiene data
              return Text("Holaaaaa");
            } else if (snapshot.hasError) {
              return Text("Ocurrio un Error");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
