
import 'package:airelimpio2/data/usuario_data.dart';
import 'package:airelimpio2/dependency_injection.dart';

abstract class UsuarioListViewContract {
  void onLoadUsuarioComplete(List<Usuario> items);
  void onLoadUsuarioError();
}




class UsuarioListPresenter{
  late UsuarioListViewContract _view;
  late UsuarioRepository _repository;

  UsuarioListPresenter(this._view){
    _repository = new Injector().usuarioRepository;
  }

  void loadUsuario(){
    _repository.fetchCurrencies()
        .then((c) => _view.onLoadUsuarioComplete(c))
        .catchError((onError)=> _view.onLoadUsuarioError());
  }

}