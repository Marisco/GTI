import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/ui/passo01.dart';
import 'package:gti_sesa_saude/blocs/consulta.bloc.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';

class Passo05 extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  Passo05(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId,
      @required this.especialidadeId,
      this.consultaId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Confirmacao(
            paciente: this.paciente,
            pacienteId: this.pacienteId,
            unidadeId: this.unidadeId,
            especialidadeId: this.especialidadeId,
            consultaId: this.consultaId));
  }
}

class Confirmacao extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  Confirmacao(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId,
      @required this.especialidadeId,
      this.consultaId});

  @override
  _ConfirmacaoState createState() => _ConfirmacaoState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      unidadeId: this.unidadeId,
      especialidadeId: this.especialidadeId,
      consultaId: this.consultaId);
}

class _ConfirmacaoState extends State<Confirmacao> {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  var _consultas = [];
  var _mensagem = [];
  final diaMesAno = DateFormat("d 'de' MMMM 'de' yyyy");
  final diaSemana = DateFormat("EEEE");
  final hora = DateFormat("Hm");
  DialogState _dialogState = DialogState.DISMISSED;
  String _tpAcao = "Verificando";
  _ConfirmacaoState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId,
      @required this.especialidadeId,
      this.consultaId});
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
    setState(() => _dialogState = DialogState.LOADING);
    ConsultaModel consultaModel = await consultaBloc.fetchConsultas(
        this.consultaId,
        this.unidadeId,
        this.especialidadeId,
        DateTime.now().add(Duration(days: 1)).toString(),
        DateTime.now().add(Duration(days: 3)).toString());
    var consulta = consultaModel.getConsultas()[0];
    setState(() {
      _dialogState = DialogState.COMPLETED;
      _consultas = [consulta];
    });
  }

  void _postConsulta() async {
    setState(() {
      _dialogState = DialogState.LOADING;
      _tpAcao = "Registrando";
    });
    
    MensagemModel mensagemModel =
        await consultaBloc.pushConsulta(this.pacienteId, this.consultaId);
    var mensagem = mensagemModel.getMensagem();
    setState(() {
      _dialogState = DialogState.COMPLETED;
      _mensagem = mensagem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/passo05.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Row(children: [
                        Cabecalho(
                            textoMensagem:
                                'Leia com atenção e confirme o agendamento da sua consulta!',
                            state: _dialogState),
                      ]),
                      Row(children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width * .88,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(146, 174, 112, 0.75),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: Theme(
                                      data: Theme.of(context).copyWith(
                                          accentColor:
                                              Color.fromRGBO(146, 174, 112, 0),
                                          canvasColor:
                                              Color.fromRGBO(146, 174, 112, 0)),
                                      child: ListView(children: <Widget>[
                                        Align(
                                          child: Stack(
                                            children: <Widget>[
                                              Visibility(
                                                visible: _dialogState ==
                                                    DialogState.COMPLETED,
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 20),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                              (this
                                                                      ._consultas
                                                                      .isEmpty
                                                                  ? ""
                                                                  : "Paciente: " +
                                                                      this
                                                                          .paciente +
                                                                      ".\nData: " +
                                                                      diaSemana.format(DateTime.parse(this
                                                                          ._consultas[
                                                                              0]
                                                                          .dataInicio)) +
                                                                      ", " +
                                                                      diaMesAno.format(DateTime.parse(this
                                                                          ._consultas[
                                                                              0]
                                                                          .dataInicio)) +
                                                                      ".\nHorário: " +
                                                                      hora.format(DateTime.parse(this
                                                                          ._consultas[
                                                                              0]
                                                                          .dataInicio)) +
                                                                      ".\nUnidade: " +
                                                                      this
                                                                          ._consultas[
                                                                              0]
                                                                          .unidade +
                                                                      ".\nSala/Consultório: " +
                                                                      this
                                                                          ._consultas[
                                                                              0]
                                                                          .consultorio +
                                                                      ".\nDr(a): " +
                                                                      this
                                                                          ._consultas[
                                                                              0]
                                                                          .medico +
                                                                      ".\nEspecialidade: " +
                                                                      this
                                                                          ._consultas[0]
                                                                          .especialidade),
                                                              style: TextStyle(color: Colors.white, fontFamily: 'Humanist', fontSize: 20, shadows: <Shadow>[
                                                                Shadow(
                                                                    offset:
                                                                        Offset(
                                                                            2.0,
                                                                            2.0),
                                                                    blurRadius:
                                                                        3.0,
                                                                    color: Colors
                                                                        .green
                                                                        .withOpacity(
                                                                            0.7)),
                                                                Shadow(
                                                                    offset:
                                                                        Offset(
                                                                            2.0,
                                                                            2.0),
                                                                    blurRadius:
                                                                        8.0,
                                                                    color: Colors
                                                                        .green
                                                                        .withOpacity(
                                                                            0.7)),
                                                              ]),
                                                              textAlign: TextAlign.left),
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(40),
                                                              child:
                                                                  RaisedButton
                                                                      .icon(
                                                                onPressed: () {
                                                                  this._postConsulta();
                                                                },
                                                                elevation: 5.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30.0),
                                                                ),
                                                                color: Color
                                                                    .fromRGBO(
                                                                        146,
                                                                        174,
                                                                        112,
                                                                        0.75),
                                                                icon: Icon(
                                                                    Icons
                                                                        .done_all,
                                                                    color: Colors
                                                                        .white70),
                                                                label: Text(
                                                                  "Confirmar",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Humanist',
                                                                      fontSize:
                                                                          30,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ))
                                                        ])),
                                              ),
                                              Visibility(
                                                visible: _dialogState !=
                                                    DialogState.COMPLETED,
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          MensagemDialog(
                                                            state: _dialogState,
                                                            paciente:
                                                                this.paciente ==
                                                                        null
                                                                    ? ""
                                                                    : this
                                                                        .paciente,
                                                            pacienteId:
                                                                this.pacienteId ==
                                                                        null
                                                                    ? ""
                                                                    : this
                                                                        .pacienteId,
                                                            textoTitle: this
                                                                    ._mensagem
                                                                    .isEmpty
                                                                ? ""
                                                                : this
                                                                    ._mensagem[
                                                                        0]
                                                                    .tipoMensagem,
                                                            textoMensagem: this
                                                                    ._mensagem
                                                                    .isEmpty
                                                                ? ""
                                                                : this
                                                                    ._mensagem[
                                                                        0]
                                                                    .mensagem,
                                                            textoBtnOK: "OK",
                                                            textoBtnCancel: "",
                                                            textoState: _tpAcao +
                                                                " agendamento no sistema...",
                                                            slideRightRouteBtnOK:
                                                                SlideRightRoute(
                                                                    builder: (_) =>
                                                                        Passo01()),
                                                          )
                                                        ])),
                                              )
                                            ],
                                          ),
                                        )
                                      ])))
                            ],
                          ),
                        ),
                      ]),
                    ])))));
  }
}
