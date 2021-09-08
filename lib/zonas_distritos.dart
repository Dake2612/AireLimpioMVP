import 'package:airelimpio2/Controladores/medida_controler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controladores/sensor_controler.dart';
import 'data/medidas_data.dart';
import 'data/sensores_data.dart';

class Zonas extends StatefulWidget {
  @override
  _zonasState createState() => _zonasState();
}

class _zonasState extends State<Zonas> {

  bool _isLoading = true;

  late SharedPreferences sharedPreferences;

  late List<Sensor> sensores;
  List<Medida> medidas = <Medida>[

  ];

  
  late Medida auxiliar;

  String id = '';


  @override
  void initState() {
    super.initState();
    obtenerSensores();

  }


  obtenerSensores() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("districtId") == null){
      print("aea");
    }
    else {
      setState(() {
        id = sharedPreferences.getString("districtId")!;
      });
      sensores = await sensor_controller().fetchSensores(id);

      print(sensores.length);
      print(sensores[0].coordX);
      print(sensores[0].coordY);
        for(var i = 0; i < sensores.length; i++){
          auxiliar = await medida_controller().medidas(sensores[i].id);
          medidas.add(auxiliar);
        }
      print(medidas[0].value);

      setState(() {
        _isLoading = false;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return _isLoading ? new Center(
      child: new CircularProgressIndicator(),
    ):GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(sensores[1].coordX,sensores[1].coordY),
          zoom: 13,
        ),
        markers: _createMarker(),
    );
  }

  Set<Marker> _createMarker(){
    var tmp = Set<Marker>();
    late Medida aux;
    for(var i = 0; i < sensores.length; i++){
      for(var j = 0; j < medidas.length; j++){
        if (medidas[j].sensorId == sensores[i].id){
          aux = medidas[j];
        }
      }
      tmp.add(Marker(
        markerId: MarkerId("Sensor "+i.toString()),
        position: LatLng(sensores[i].coordX,sensores[i].coordY),
        infoWindow: InfoWindow(
          title: sensores[i].location,
          snippet: "CO2: "+ aux.value.toString()
        )
      ));

    }
    return tmp;
  }
}
