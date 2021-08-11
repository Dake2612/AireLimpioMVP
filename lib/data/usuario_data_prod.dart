import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:airelimpio2/data/usuario_data.dart';

class ProdUsuarioRepository implements UsuarioRepository{
  String userUrl = 'http://192.168.100.83:4000/api/users';
  @override
  Future<List<Usuario>> fetchCurrencies() async{
    http.Response response = await http.get(Uri.parse(userUrl));
    final List responseBody = json.decode(response.body);
    final statusCode = response.statusCode;
    if(statusCode != 200 || responseBody == null){
      throw new FetchDataException("An error ocurred: [Status Code : $statusCode]");
    }
    return responseBody.map((c) => new Usuario.fromMap(c)).toList();
  }

}