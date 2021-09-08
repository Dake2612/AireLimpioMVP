import 'dart:async';

import 'dart:ffi';

class Sensor{
  late String id;
  late String name;
  late String location;
  late double coordX;
  late double coordY;
  late String districtId;

  Sensor({required this.id, required this.name, required this.location, required this.coordX, required this.coordY, required this.districtId});

  Sensor.fromMap(Map<String,dynamic> map): id = map['_id'], name = map['name'], location = map['location'], coordX = map['coordX'], coordY = map['coordY'], districtId = map['districtId'];

}



class FetchDataException implements Exception{
  final _message;

  FetchDataException([this._message]);

  String toString(){
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }

}