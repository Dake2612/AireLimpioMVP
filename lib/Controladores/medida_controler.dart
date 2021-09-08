import 'dart:convert';


import 'package:airelimpio2/data/medidas_data.dart';
import 'package:http/http.dart' as http;

class medida_controller{
  String Url = 'https://backend-aire-limpio.herokuapp.com/api/measurements/sensor/';
  String UrlHistory = 'https://backend-aire-limpio.herokuapp.com/api/history/sensor/';

  Future<Medida> medidas(String id) async {
    http.Response response = await http.get(Uri.parse(Url+id));
    dynamic responseBody = jsonDecode(response.body);
    dynamic statusCode = response.statusCode;
    if(statusCode != 200 || responseBody == null){
      throw new FetchDataException("An error ocurred: [Status Code : $statusCode]");
    }

    var measure = new Medida(id: responseBody[0]["_id"], value: responseBody[0]["value"], sensorId: responseBody[0]["sensorId"], variableId: responseBody[0]["variableId"], date: responseBody[0]["date"]);

    return measure;
  }

  Future<List<Medida>> historicos(String id) async{

    http.Response response = await http.get(Uri.parse(UrlHistory+id));
    final List responseBody = jsonDecode(response.body);
    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
          "An error ocurred : [Status Code : $statusCode]");
    }
    return responseBody.map((c) => new Medida.fromMap(c)).toList();

  }

}