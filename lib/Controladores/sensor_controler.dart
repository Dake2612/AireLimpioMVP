import 'dart:convert';

import 'package:airelimpio2/data/sensores_data.dart';
import 'package:http/http.dart' as http;

class sensor_controller {
  String districtUrl = 'http://192.168.100.83:4000/api/districts/sensors/';

  @override
  Future<List<Sensor>> fetchSensores(String id) async{
    http.Response response = await http.get(Uri.parse(districtUrl+id));
    //print(response.body);
    final List responseBody = json.decode(response.body);
    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
          "An error ocurred : [Status Code : $statusCode]");
    }
    return responseBody.map((c) => new Sensor.fromMap(c)).toList();
  }



}