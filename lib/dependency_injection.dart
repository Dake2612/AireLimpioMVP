import 'package:airelimpio2/data/usuario_data.dart';
import 'package:airelimpio2/data/usuario_data_mock.dart';
import 'package:airelimpio2/data/usuario_data_prod.dart';

enum Flavor{ MOCK, PROD}

//DI


class Injector{
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor = Flavor.MOCK;

  static void configure(Flavor flavor){
    _flavor = flavor;
  }

  factory Injector(){
    return _singleton;
  }

  Injector._internal();

  UsuarioRepository get usuarioRepository{
    switch(_flavor){
      case Flavor.MOCK: return new MockUsuarioRepository();
      default: return new ProdUsuarioRepository();
    }
  }


}