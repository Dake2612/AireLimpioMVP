import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controladores/sensor_controler.dart';
import 'data/sensores_data.dart';
import 'statsDetail.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  bool _isLoading = true;

  late List<Sensor> sensores;

  String id = '';

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    obtenerDatos();
  }


  obtenerDatos() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("districtId") == null){
      print("aea");
    }
    else {
      setState(() {
        id = sharedPreferences.getString("districtId")!;
      });
      sensores = await sensor_controller().fetchSensores(id);
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return _isLoading ? new Center(
      child: new CircularProgressIndicator(),
    ):_buildListView(context);
  }

  ListView _buildListView(BuildContext context){
    return ListView.builder(
      itemCount: sensores.length,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text('Sensor '+sensores[index].id),
          subtitle: Text(sensores[index].location),
          leading: Icon(Icons.stacked_bar_chart),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          onTap: () async {
            sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString("SensorId", sensores[index].id);
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => Detalle()));
          },
        );
      },
    );
  }
}
