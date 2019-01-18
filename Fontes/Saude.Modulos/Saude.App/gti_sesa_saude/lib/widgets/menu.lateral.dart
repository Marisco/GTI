import 'package:flutter/material.dart';
import '../ui/app.dart';
import '../ui/passo01.dart';
import '../ui/passo02.dart';
import '../ui/passo03.dart';
import '../ui/passo04.dart';
import '../ui/passo05.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Botoes();
  }
}

class Botoes extends StatefulWidget {
  Botoes({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _BotoesState createState() => _BotoesState();
}

class _BotoesState extends State<Botoes> {
  final _documento = TextEditingController();
  bool _active = false;
  bool _btn1 = false;
  bool _btn2 = false;
  bool _btn3 = false;
  bool _btn4 = false;
  bool _btn5 = false;
  @override
  void dispose() {
    _documento.dispose();
    super.dispose();
  }

  void _changeButton(int nrButton) {    

    switch (nrButton) {
      case 1:
        {
          _btn1 = true;          
          _btn2 = false;
          _btn3 = false;
          _btn4 = false;
          _btn5 = false;
        }
    }

    setState(() {
      _btn1 = _btn1;
      _btn2 = _btn2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2, // 10%
      child: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          OutlineButton(
              child:
                  new Image.asset("img/ic_passo01.png", width: _btn1 ? 64 : 56),
              borderSide: BorderSide(color: Colors.transparent),
              padding: new EdgeInsets.all(!_active ? 10 : 5),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(60)),
              onPressed: () {
                Navigator.push(
                    context, new TransicaoTela(builder: (_) => Passo01()));
                _changeButton(1);
              }),
          OutlineButton(
              child:
                  new Image.asset("img/ic_passo02.png", width: _btn2 ? 64 : 56),
              borderSide: BorderSide(color: Colors.transparent),
              padding: new EdgeInsets.all(10),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(360)),
              onPressed: () {
                Navigator.push(
                    context, new TransicaoTela(builder: (_) => Passo02(paciente:"", pacienteId: "")));
                _changeButton(2);
              }),
          OutlineButton(
              child:
                  new Image.asset("img/ic_passo03.png", width: _btn3 ? 64 : 56),
              borderSide: BorderSide(color: Colors.transparent),
              padding: new EdgeInsets.all(10),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(360)),
              onPressed: () {
                Navigator.push(
                    context, new TransicaoTela(builder: (_) => Passo03(paciente:"", pacienteId: "",unidadeId: "" )));
                _changeButton(3);
              }),
          OutlineButton(
              child:
                  new Image.asset("img/ic_passo04.png", width: _btn4 ? 64 : 56),
              borderSide: BorderSide(color: Colors.transparent),
              padding: new EdgeInsets.all(10),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(360)),
              onPressed: () {
                Navigator.push(
                    context, new TransicaoTela(builder: (_) => Passo04(paciente:"", pacienteId: "",unidadeId: "",especialidadeId: "")));
                _changeButton(4);
              }),
          OutlineButton(
              child:
                  new Image.asset("img/ic_passo05.png", width: _btn5 ? 64 : 56),
              borderSide: BorderSide(color: Colors.transparent),
              padding: new EdgeInsets.all(10),
              disabledBorderColor: Colors.transparent,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(360)),
              onPressed: () {
                Navigator.push(
                    context, new TransicaoTela(builder: (_) => Passo05(paciente:"", pacienteId: "",unidadeId: "",especialidadeId: "",consultaId: "",)));
                _changeButton(5);
              }),
        ]),
      ),
    );
  }
}
