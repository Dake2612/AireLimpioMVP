import 'dart:async';

class Usuario{
  late String id;
  late String name;
  late String surname;
  late String email;
  late String districtId;
  late String token;
  late String message;

  Usuario({required this.id, required this.name, required this.surname, required this.email, required this.districtId, required this.message, required this.token});



  Usuario.fromMap(Map<String,dynamic> map):id = map['_id'], name = map['name'], surname = map['surname'], email = map['email'], districtId = map['districtId'];

  Usuario.fromMap2(Map<String,dynamic> map):message = map['message'], token = map['token'], id = map['userId'];
}

abstract class UsuarioRepository {
  Future<List<Usuario>> fetchCurrencies(String id);

  Future<List<Usuario>> signin(String email, String password);
}

class FetchDataException implements Exception{
  final _message;

  FetchDataException([this._message]);

  String toString(){
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }

}