import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/blocs/consulta.bloc.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/ui/passo05.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';

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
  List<RadioModel> dadosConsulta = List<RadioModel>();

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
        DateTime.now().add(Duration(days: 1)).toString(),
        DateTime.now().add(Duration(days: 3)).toString());
    var consulta = consultaModel.getConsultas();
    setState(() {
      _consultas = consulta;
      _consultas.forEach((consulta) => dadosConsulta.add(RadioModel(
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
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/passo04.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Cabecalho(
                          state: DialogState.DISMISSED,
                          textoMensagem:
                              'Escolha dentre os horários diponíveis:',
                        ),
                      ]),
                      Row(children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                    child: Theme(
                                  data: Theme.of(context).copyWith(
                                      accentColor: Color.fromRGBO(189,
                                                                112, 162, 0.75),
                                      canvasColor:
                                          Color.fromRGBO(189, 112, 162, 0.75)),
                                  child: Container(
                                      margin: EdgeInsets.all(20),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4,
                                              child: Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                        accentColor: Color.fromRGBO(189,
                                                                112, 162, 0.75),
                                                          canvasColor:
                                                              Colors.black),
                                                  child: ListView.builder(                                                    
                                                    itemCount:
                                                        dadosConsulta.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return InkWell(
                                                        splashColor:
                                                            Color.fromRGBO(189,
                                                                112, 162, 0.75),
                                                        onTap: () {
                                                          setState(() {
                                                            _selConsulta =
                                                                dadosConsulta[
                                                                        index]
                                                                    .numero;
                                                            dadosConsulta.forEach(
                                                                (element) =>
                                                                    element.isSelected =
                                                                        false);
                                                            dadosConsulta[index]
                                                                    .isSelected =
                                                                true;
                                                          });
                                                        },
                                                        child: RadioItem(
                                                            dadosConsulta[
                                                                index]),
                                                      );
                                                    },
                                                  )),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(20),
                                                child: RaisedButton.icon(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        SlideRightRoute(
                                                            builder: (_) => Passo05(
                                                                paciente: this
                                                                    .paciente,
                                                                pacienteId: this
                                                                    .pacienteId,
                                                                unidadeId: this
                                                                    .unidadeId,
                                                                especialidadeId:
                                                                    this
                                                                        .especialidadeId,
                                                                consultaId: this
                                                                    ._selConsulta)));
                                                  },
                                                  elevation: 5.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  color: Color.fromRGBO(
                                                      189,
                                                      112,
                                                      162,
                                                      0.75), //Color.fromRGBO(41, 84, 142, 1),
                                                  icon: Icon(Icons.play_arrow,
                                                      color: Colors.white70),
                                                  label: Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontFamily: 'Humanist',
                                                        fontSize: 30,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ])),
                                ))
                              ],
                            )),
                      ])
                    ])))));
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  final diaMesAno = DateFormat("d 'de' MMMM 'de' yyyy");
  final diaSemana = DateFormat("EEEE");
  final hora = DateFormat("Hm");
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 100.0,
            margin: EdgeInsets.only(left: 0.0),
            child: Center(
              child: Text(hora.format(DateTime.parse(_item.dataInicio)),
                  style: TextStyle(
                      fontFamily: 'Humanist',
                      color: _item.isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: BoxDecoration(
              color: _item.isSelected
                  ? Color.fromRGBO(189, 112, 162, 0.75)
                  : Colors.transparent,
              border: Border.all(
                  width: 2.0,
                  color: _item.isSelected
                      ? Color.fromRGBO(189, 112, 162, 0.75)
                      : Color.fromRGBO(189, 112, 162, 0.75)),
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
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
                      "\nDr(a): " + _item.medico +"." +
                      "\nEsp.: " +
                      _item.especialidade +
                      ".",
                  style: TextStyle(
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
