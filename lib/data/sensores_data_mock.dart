

import 'package:airelimpio2/data/sensores_data.dart';

class MockSensoresRepository implements SensoresRepository{
  @override
  Future<List<Sensor>> fetchSensores(String id) {
    return new Future.value(sensor);
  }

}

var sensor = <Sensor>[
  new Sensor(id:"1", name: "sensor1", location: "Av. Tomas Valle 1958-2044", coordX: -12.012892, coordY: 77.083116, districtId: "31"),
  new Sensor(id:"2", name: "sensor2", location: "Av. Tomas Valle 1958-2044", coordX: -12.006650, coordY: 77.080434, districtId: "31"),
  new Sensor(id:"3", name: "sensor3", location: "Av. Tomas Valle 1958-2044", coordX: -12.016711, coordY: 77.072584, districtId: "31"),
  new Sensor(id:"4", name: "sensor4", location: "Av. Tomas Valle 1958-2044", coordX: -12.017110, coordY: 77.086639, districtId: "31"),
];