import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'data/usuario_data.dart';
import 'modules/usuario_presenter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> implements UsuarioListViewContract {
  late UsuarioListPresenter _presenter;
  late List<Usuario> _usuarios;
  late bool _isLoading;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  _HomePageState() {
    _presenter = new UsuarioListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Aire limpio"),
          elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
        ),
        body: _isLoading
            ? new Center(
          child: new CircularProgressIndicator(),
        )
            :new ListView.builder(
          itemCount: _usuarios.length,
          itemBuilder: (BuildContext context,int index)=>
              _getRowWithDivider(index),)
    );
  }

  Widget _getRowWithDivider(int i) {
    final Usuario user = _usuarios[i];
    var children = <Widget>[
      new Padding(
          padding: new EdgeInsets.all(10.0),
          child: _getListItemUi(user)
      ),
      new Divider(height: 5.0),
    ];

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  ListTile _getListItemUi(Usuario user) {
    return new ListTile(
      //leading: new FadeInImage(placeholder: new AssetImage('assets/2.0x/stars.png'), image: new NetworkImage("http://cryptoicons.co/32@2x/color/"+currency.symbol.toLowerCase()+"@2x.png")),
      title: new Text(user.name+' '+user.surname,
          style: new TextStyle(fontWeight: FontWeight.bold)),
      subtitle:
      _getSubtitleText(user.email, user.districtId),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String email, String district) {
    TextSpan emailTextWidget = new TextSpan(
        text: email, style: new TextStyle(color: Colors.black));

    TextSpan districtTextWidget = new TextSpan(
        text: district,
        style: new TextStyle(color: Colors.green));


    return new RichText(
        text: new TextSpan(
            children: [emailTextWidget, districtTextWidget]));
  }

  @override
  void onLoadUsuarioComplete(List<Usuario> items) {
    // TODO: implement onLoadCryptoComplete

    setState(() {
      _usuarios = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadUsuarioError() {
    // TODO: implement onLoadCryptoError
  }
}