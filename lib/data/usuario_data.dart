import 'dart:async';

class Usuario{
  String name;
  String surname;
  String email;
  String districtId;

  Usuario({required this.name, required this.surname, required this.email, required this.districtId});

  Usuario.fromMap(Map<String,dynamic> map):name = map['name'], surname = map['surname'], email = map['email'], districtId = map['districtId'];
}

abstract class UsuarioRepository {
  Future<List<Usuario>> fetchCurrencies();
}

class FetchDataException implements Exception{
  final _message;

  FetchDataException([this._message]);

  String toString(){
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }

}