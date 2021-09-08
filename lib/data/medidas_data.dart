

import 'dart:core';

class Medida{
  late String id;
  late double value;
  late String sensorId;
  late String variableId;
  late String date;

  Medida({required this.id, required this.value, required this.sensorId, required this.variableId, required this.date});

  Medida.fromMap(Map<String,dynamic> map): id = map['_id'], value = map['value']+0.0, sensorId = map['sensorId'], variableId = map['variableId'], date = map['date'];
}

class FetchDataException implements Exception{
  final _message;

  FetchDataException([this._message]);

  String toString(){
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }

}