import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:airelimpio2/data/usuario_data.dart';

class ProdUsuarioRepository implements UsuarioRepository{
  String userUrl = 'http://192.168.100.83:4000/api/users/';
  String singInUrl = 'http://192.168.100.83:4000/api/users/signin';

  @override
  Future<List<Usuario>> fetchCurrencies(String id) async{
    http.Response response = await http.get(Uri.parse(userUrl+id));
    dynamic responseBody = jsonDecode(response.body);
    dynamic statusCode = response.statusCode;
    if(statusCode != 200 || responseBody == null){
      throw new FetchDataException("An error ocurred: [Status Code : $statusCode]");
    }

    var usuario = <Usuario>[
      new Usuario(id:responseBody["_id"], name: responseBody["name"], surname: responseBody["surname"], email: responseBody["email"], districtId: responseBody["districtId"], message: "bienvenido", token: "3"),
    ];

    return new Future.value(usuario);
  }

  @override
  Future<List<Usuario>> signin(String email, String password) async{
    http.Response response1 = await http.post(Uri.parse(singInUrl),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }));
    dynamic responseBody1 = jsonDecode(response1.body);
    dynamic statusCode1 = response1.statusCode;
    if(statusCode1 != 200 || responseBody1 == null){
      throw new FetchDataException("An error ocurred: [Status Code : $statusCode1]");
    }
    if(responseBody1["token"] == "1"){
      var usuario1 = <Usuario>[
        new Usuario(id:responseBody1["userId"], name: "", surname: "", email: "", districtId: "", message: responseBody1["message"], token: responseBody1["token"]),
      ];
      return new Future.value(usuario1);
    } else {
      var usuario1 = <Usuario>[
        new Usuario(id:"", name: "1", surname: "", email: "", districtId: "", message: responseBody1["message"], token: responseBody1["token"]),
      ];
      return new Future.value(usuario1);
    }

  }

}