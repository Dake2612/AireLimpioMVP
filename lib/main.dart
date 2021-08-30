import 'dart:async';
import 'dart:convert';
import 'package:airelimpio2/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dependency_injection.dart';

void main() async {
  Injector.configure(Flavor.PROD);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.pink,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[100]
              : null),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectDrawerItem = 4;

  late SharedPreferences sharedPreferences;

  String id = '';
  String nombres = 'Prueba';
  String apellido = 'Apellido Prueba';
  int districtId = 0;
  String correo = 'prueba@unmsm.edu.pe';


  @override
  void initState() {
    super.initState();
    checkLoginStatus();

  }



  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("id") == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
    else{
      setState(() {
        id = sharedPreferences.getString("id")!;
      });
      print(id);
    }
  }

  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0: return Center(
        child: Text("Perfil",style: TextStyle(fontSize: 20),),
      );
      case 1: return Center(
        child: Text("Zonas",style: TextStyle(fontSize: 20),),
      );
      case 2: return Center(
          child: Text("Dispensas",style: TextStyle(fontSize: 20),),
      );
      default: return Center(
        child: Text("Bienvenido",style: TextStyle(fontSize: 20),),
      );
    }
  }

  _onSelectItem(int pos){
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aire Limpio", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(nombres+' '+ apellido),
              accountEmail: Text(correo),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.lightGreenAccent,
                child: Text(
                    nombres[0],
                    style: TextStyle(fontSize: 40)
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Colors.blue,
                    Colors.lightBlueAccent
                  ])
              ),
            ),
            ListTile(
              title: Text('Perfil'),
              leading: Icon(Icons.person),
              selected: (0 == _selectDrawerItem),
              onTap: (){

                _onSelectItem(0);
              },
            ),
            ListTile(
              title: Text('Zonas'),
              leading: Icon(Icons.location_on),
              selected: (1 == _selectDrawerItem),
              onTap: (){
                _onSelectItem(1);

              },
            ),
            ListTile(
              title: Text('Dispensadores'),
              leading: Icon(Icons.arrow_forward_ios_rounded),
              selected: (2 == _selectDrawerItem),
              onTap: (){
                _onSelectItem(2);

              },
            ),
            ListTile(
              title: Text('Cerrar sesion'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                sharedPreferences.clear();
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectDrawerItem),
    );
  }
}