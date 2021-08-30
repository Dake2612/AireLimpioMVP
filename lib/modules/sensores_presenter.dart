
import 'package:airelimpio2/data/sensores_data.dart';
import 'package:airelimpio2/dependency_injection.dart';

abstract class SensoresListViewContract{
  void onLoadSensorComplete(List<Sensor> items);
  void onLoadSensorError();
}

class SensorListPresenter{
  late SensoresListViewContract _view;
  late SensoresRepository _repository;

  SensorListPresenter(this._view){
    _repository = new Injector().sensorRepository;
  }

  void loadSensores(String id){
    _repository.fetchSensores(id)
        .then((c) => _view.onLoadSensorComplete(c))
        .catchError((onError)=> _view.onLoadSensorError());
  }
}