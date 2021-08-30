import 'dart:convert';

import 'package:airelimpio2/data/sensores_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'data/usuario_data.dart';
import 'Controladores/usuario_controler.dart';
import 'main.dart';
import 'modules/sensores_presenter.dart';
import 'modules/usuario_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlueAccent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            ),
          ),
          child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
            children: <Widget>[
              headerSection(),
              textSection(),
              buttonSection(),
            ],
          ),
        )
    );
  }



  signIn() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if(token != '0' && token != '2'){
        print("ok");
        setState(() {
          _isLoading = false;
          sharedPreferences.setString("id", token);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
        });

      }
      else{
        setState(() {
          _isLoading = false;
        });
      }


  }

  var token;

  Container buttonSection(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: RaisedButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          token = await usuario_controler().login(emailController.text,passwordController.text);
          signIn();
        },
        elevation: 0.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text("Sign In", style: TextStyle(color: Colors.black)),
      ),
    );
  }

  Container textSection(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      //margin: EdgeInsets.only(top: 30.0),
      child: Column (
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white70,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
                hintText: "Email",
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                hintStyle: TextStyle(color: Colors.white70),
                icon: Icon(Icons.email, color: Colors.white70)
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white70),
                icon: Icon(Icons.lock, color: Colors.white70),
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70))
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  Container headerSection(){
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("Aire Limpio", style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
          fontWeight: FontWeight.bold
      )
      ),
    );
  }

}



/*class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> implements UsuarioListViewContract,SensoresListViewContract {
  late UsuarioListPresenter _presenter;
  late SensorListPresenter _presenterSensores;
  late List<Sensor> _sensores;
  late List<Usuario> _usuarios;
  late bool _isLoading;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  String idSensor = "31";

  String id = "72783043";

  String email = "bruno.munoz@unmsm.edu.pe";

  String password = "abc123";

  _HomePageState() {
    _presenter = new UsuarioListPresenter(this);
    _presenterSensores = new SensorListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.signinUsuario(email,password);
    _presenterSensores.loadSensores(idSensor);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Aire limpio"),
          elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
        ),
        body: _isLoading
            ? new Center(
          child: new CircularProgressIndicator(),
        )
            :new ListView.builder(
          itemCount: _sensores.length,
          itemBuilder: (BuildContext context,int index)=>
              _getRowWithDivider(index),)
    );
  }

  Widget _getRowWithDivider(int i) {
    final Sensor sensor = _sensores[i];
    var children = <Widget>[
      new Padding(
          padding: new EdgeInsets.all(10.0),
          child: _getListItemUi(sensor)
      ),
      new Divider(height: 5.0),
    ];

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  ListTile _getListItemUi(Sensor sensor) {
    return new ListTile(
      //leading: new FadeInImage(placeholder: new AssetImage('assets/2.0x/stars.png'), image: new NetworkImage("http://cryptoicons.co/32@2x/color/"+currency.symbol.toLowerCase()+"@2x.png")),
      title: new Text(sensor.id+' '+sensor.name+' '+sensor.districtId,
          style: new TextStyle(fontWeight: FontWeight.bold)),
      subtitle:
      _getSubtitleText(sensor.coordX, sensor.coordY),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(double coordX, double coordY) {

    TextSpan emailTextWidget = new TextSpan(
        text: '$coordX', style: new TextStyle(color: Colors.black));

    TextSpan districtTextWidget = new TextSpan(
        text: '$coordY',
        style: new TextStyle(color: Colors.green));


    return new RichText(
        text: new TextSpan(
            children: [emailTextWidget, districtTextWidget]));
  }

  @override
  void onLoadUsuarioComplete(List<Usuario> items) {
    // TODO: implement onLoadCryptoComplete

    setState(() {
      _usuarios = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadUsuarioError() {
    // TODO: implement onLoadCryptoError
  }

  @override
  void onLoadSensorComplete(List<Sensor> items) {
    // TODO: implement onLoadSensorComplete

    setState(() {
      _sensores = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadSensorError() {
    // TODO: implement onLoadSensorError
  }
}*/