import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controladores/usuario_controler.dart';
import 'data/usuario_data.dart';


class Perfil extends StatefulWidget {

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  bool _isLoading = true;

  late Usuario user;

  String id = '';


  late SharedPreferences sharedPreferences;


  datos() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("id") == null){
      //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
      print("aea");
    }
    else{
      setState(() {
        id = sharedPreferences.getString("id")!;
      });
      user = await usuario_controler().datos(id);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datos();
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading ? new Center(
        child: new CircularProgressIndicator(),
      ): Column(

        children: <Widget>[
          Center(
            child: Divider(height: 50, thickness: 0.2,),
          ),
          Center(
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.green,
              child: Text(
                  user.name[0],
                  style: TextStyle(fontSize: 65, color: Colors.white)
              ),
            ),

          ),
          Center(
            child: Divider(height: 50, thickness: 0.2,),
          ),
          Center(
            child: Text(
              "Nombre completo: "+user.name+" "+user.surname,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Divider(height: 20, thickness: 0.2,),
          ),
          Center(
            child: Text(
              "Correo: "+user.email,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Divider(height: 20, thickness: 0.2,),
          ),
          Center(
            child: Text(
              "Distrito: "+ user.districtId,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

