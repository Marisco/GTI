import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/blocs/consulta.bloc.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/ui/passo05.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Passo04 extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  final String especialidadeId;
  Passo04(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId,
      @required this.especialidadeId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consulta(
            paciente: this.paciente,
            pacienteId: this.pacienteId,
            unidadeId: this.unidadeId,
            especialidadeId: this.especialidadeId));
  }
}

class Consulta extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  final String especialidadeId;
  Consulta(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId,
      @required this.especialidadeId});
  @override
  _ConsultaState createState() => _ConsultaState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      unidadeId: this.unidadeId,
      especialidadeId: this.especialidadeId);
}

class _ConsultaState extends State<Consulta> {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  final String especialidadeId;
  var _consultas = [];
  var _selConsulta;
  _ConsultaState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId,
      @required this.especialidadeId});
  List<RadioModel> dadosConsulta = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("pr_BR", null).then((_) {
      this._getConsultas();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getConsultas() async {
    ConsultaModel consultaModel = await consultaBloc.fetchConsultas(
        "0",
        this.unidadeId,
        this.especialidadeId,
        DateTime.now().add(new Duration(days: 1)).toString(),
        DateTime.now().add(new Duration(days: 3)).toString());
    var consulta = consultaModel.getConsultas();
    setState(() {
      _consultas = consulta;
      _consultas.forEach((consulta) => dadosConsulta.add(new RadioModel(
          false,
          consulta.numero,
          consulta.consultorio,
          consulta.especialidade,
          consulta.medico,
          consulta.dataInicio,
          consulta.dataFim)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Passo 4"),
          backgroundColor: Colors.pink,
          actions: <Widget>[
            new Image.asset(
              "img/logo_icon.png",
              width: 50,
            )
          ]),
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("img/passo04.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Expanded(
              flex: 6,
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                    Text(
                      'Escolha dentre os horários diponíveis:',
                      style: TextStyle(
                        fontFamily: 'Humanist',
                        color: Colors.white,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                        flex: 0,
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              height: 200.0,
                              child: new Theme(
                                  data: Theme.of(context)
                                      .copyWith(canvasColor: Colors.black),
                                  child: new ListView.builder(
                                    itemCount: dadosConsulta.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return new InkWell(
                                        //highlightColor: Colors.red,
                                        splashColor:
                                            Colors.pink.withOpacity(0.7),
                                        onTap: () {
                                          setState(() {
                                            _selConsulta =
                                                dadosConsulta[index].numero;
                                            dadosConsulta.forEach((element) =>
                                                element.isSelected = false);
                                            dadosConsulta[index].isSelected =
                                                true;
                                          });
                                        },
                                        child:
                                            new RadioItem(dadosConsulta[index]),
                                      );
                                    },
                                  )),
                            ))),
                    Text(
                      '',
                      style: TextStyle(
                        fontFamily: 'Humanist',
                        color: Colors.white,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    RaisedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new SlideRightRoute(
                                builder: (_) => Passo05(
                                    paciente: this.paciente,
                                    pacienteId: this.pacienteId,
                                    unidadeId: this.unidadeId,
                                    especialidadeId: this.especialidadeId,
                                    consultaId: this._selConsulta)));
                      },
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      //color: const Color.fromARGB(255, 175, 207, 45),
                      color: Colors.pink, //Color.fromRGBO(41, 84, 142, 1),
                      icon: Icon(Icons.play_arrow, color: Colors.white70),
                      label: Text(
                        "",
                        style: TextStyle(
                            fontFamily: 'Humanist',
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                  ])),
            ),
            Expanded(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  final diaMesAno = new DateFormat("d 'de' MMMM 'de' yyyy");
  final diaSemana = new DateFormat("EEEE");
  final hora = new DateFormat("Hm");
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.transparent,
      margin: new EdgeInsets.all(5.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 80.0,
            width: 80.0,
            margin: new EdgeInsets.only(left: 5.0),
            child: new Center(
              child: new Text(hora.format(DateTime.parse(_item.dataInicio)),
                  style: new TextStyle(
                      fontFamily: 'Humanist',
                      color: _item.isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Colors.pink.withOpacity(0.7)
                  : Colors.transparent,
              border: new Border.all(
                  width: 2.0,
                  color: _item.isSelected
                      ? Colors.pink.withOpacity(0.7)
                      : Colors.pink.withOpacity(0.7)),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  diaSemana
                          .format(DateTime.parse(_item.dataInicio))
                          .toString()
                          .toUpperCase() +
                      "\n" +
                      diaMesAno.format(DateTime.parse(_item.dataInicio)) +
                      "." +
                      "\nSala: " +
                      _item.consultorio +
                      "." +
                      //"\nDr(a): " + _item.medico +"." +
                      "\nEsp.: " +
                      _item.especialidade +
                      ".",
                  style: new TextStyle(
                    color: Colors.black,
                    fontFamily: 'Humanist',
                    fontSize: 16,
                    shadows: _item.isSelected
                        ? <Shadow>[
                            Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: Colors.white.withOpacity(0.7)),
                            Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 8.0,
                                color: Colors.white.withOpacity(0.7)),
                          ]
                        : [],
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String numero;
  final String consultorio;
  final String especialidade;
  final String medico;
  final String dataInicio;
  final String dataFim;

  RadioModel(this.isSelected, this.numero, this.consultorio, this.especialidade,
      this.medico, this.dataInicio, this.dataFim);
}
