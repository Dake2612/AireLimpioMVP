import 'dart:async';

import 'package:airelimpio2/data/usuario_data.dart';

class MockUsuarioRepository implements UsuarioRepository{
  @override
  Future<List<Usuario>> fetchCurrencies() {
    return new Future.value(usuario);
  }

}

var usuario = <Usuario>[
  new Usuario( name: "Jorge", surname: "Perez", email: "jorge.perez@unmsm.edu.pe", districtId: "99"),
  new Usuario( name: "Luis", surname: "Ramos", email: "luis.ramos@unmsm.edu.pe", districtId: "98"),
  new Usuario( name: "Oscar", surname: "Gomez", email: "oscar.gomez@unmsm.edu.pe", districtId: "97"),
];