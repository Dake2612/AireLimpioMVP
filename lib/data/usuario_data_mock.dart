import 'dart:async';

import 'package:airelimpio2/data/usuario_data.dart';

class MockUsuarioRepository implements UsuarioRepository{

  @override
  Future<List<Usuario>> fetchCurrencies(String id) {
    return new Future.value(usuario);
  }

  @override
  Future<List<Usuario>> signin(String email, String password) {
    return new Future.value(usuario2);
  }
}

var usuario2 = <Usuario>[
  new Usuario(id:"72783043", name: "", surname: "", email: "", districtId: "", message: "correct email and password", token: "1")
];


var usuario = <Usuario>[
  new Usuario(id:"77777777", name: "Jorge", surname: "Perez", email: "jorge.perez@unmsm.edu.pe", districtId: "99", message: "bienvenido", token: "3"),
  new Usuario(id:"77777777", name: "Luis", surname: "Ramos", email: "luis.ramos@unmsm.edu.pe", districtId: "98", message: "bienvenido", token: "3"),
  new Usuario(id:"77777777", name: "Oscar", surname: "Gomez", email: "oscar.gomez@unmsm.edu.pe", districtId: "97", message: "bienvenido", token: "3"),
];