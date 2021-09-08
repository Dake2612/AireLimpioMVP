import 'dart:convert';

import 'package:airelimpio2/data/usuario_data.dart';
import 'package:http/http.dart' as http;

class usuario_controler {

  String userUrl = 'https://backend-aire-limpio.herokuapp.com/api/users/';
  String singInUrl = 'https://backend-aire-limpio.herokuapp.com/api/users/signin';

  Future<Usuario> datos(String id) async{
    http.Response response = await http.get(Uri.parse(userUrl+id));
    dynamic responseBody = jsonDecode(response.body);
    dynamic statusCode = response.statusCode;
    if(statusCode != 200 || responseBody == null){
      throw new FetchDataException("An error ocurred: [Status Code : $statusCode]");
    }

    var usuario = new Usuario(id:responseBody["_id"], name: responseBody["name"], surname: responseBody["surname"], email: responseBody["email"], districtId: responseBody["districtId"], message: "bienvenido", token: "3");


    return usuario;
  }

  Future<String> login(String email, String password) async {

    var url =
    Uri.parse(singInUrl);
    var response =
    await http.post(url, body: {'email': email, 'password': password});

    dynamic responseBody1 = jsonDecode(response.body);

    print(responseBody1);

    var decodedResp;

    if(responseBody1["token"] == "1"){
      decodedResp = responseBody1["userId"];
    } else {
      decodedResp = responseBody1["token"];
    }

    return decodedResp;

  }
}