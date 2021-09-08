import 'package:airelimpio2/data/medidas_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Controladores/medida_controler.dart';


class Detalle extends StatefulWidget {
  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {


  late SharedPreferences sharedPreferences;

  bool _isLoading = true;

  late List<Medida> medidaHistoria;

  String id = '';

  late List<MedidasData> _chartData;

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    obtenerDatos();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  obtenerDatos() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("SensorId") == null){
      //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
      print("aea");
    }
    else{
      setState(() {
        id = sharedPreferences.getString("SensorId")!;
      });
      medidaHistoria = await medida_controller().historicos(id);

      setState(() {
        _chartData = obtenerDatosChart();
        _isLoading = false;
      });
      //print(_chartData[2].medida);
      //print(_chartData[2].value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? new Center(
      child: new CircularProgressIndicator(),

    ):Scaffold(
      appBar: AppBar(
        title: Text('Historial de Sensor '+id, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: SfCartesianChart(
          title: ChartTitle(text: 'Mediciones diarias del sensor' + id),
          legend: Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
          AreaSeries<MedidasData, double>(
              name: 'Unidades de CO2',
              dataSource: _chartData,
              xValueMapper: (MedidasData historia, _) => historia.medida,
              yValueMapper: (MedidasData historia, _) => historia.value,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true
          ),

        ],
        primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          labelFormat: '{value}dia'
        ),
        primaryYAxis: NumericAxis(
          labelFormat: '{value}u'
        ),
        ),
      ),
    );
  }

  List<MedidasData> obtenerDatosChart(){

    final List<MedidasData> chartData = [
      new MedidasData(0, 200),
    ];

    for(var i = 0;i < medidaHistoria.length; i++){
      chartData.add(MedidasData(i+1.0,medidaHistoria[i].value));
      //print(medidaHistoria[i].value);
    }
    return chartData;

  }
}

class MedidasData{
  MedidasData(this.medida,this.value);

  final double medida;
  final double value;


}
