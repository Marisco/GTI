import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/ui/identificacao.dart';
import 'package:gti_sesa_saude/ui/consulta.dart';
import 'package:gti_sesa_saude/blocs/consulta.bloc.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';
//import 'package:gti_sesa_saude/ui/filaVirtual.dart';
import 'package:gti_sesa_saude/blocs/filaVirtual.bloc.dart';
import 'package:gti_sesa_saude/models/filaVirtual.model.dart';

class Confirmacao extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  final String filaVirtualId;
  Confirmacao(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId,
      @required this.especialidadeId,
      @required this.consultaId,
      @required this.filaVirtualId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _Confirmacao(
            paciente: this.paciente,
            pacienteId: this.pacienteId,
            moduloId: this.moduloId,
            unidadeId: this.unidadeId,
            especialidadeId: this.especialidadeId,
            consultaId: this.consultaId,
            filaVirtualId: this.filaVirtualId));
  }
}

class _Confirmacao extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  final String filaVirtualId;
  _Confirmacao(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId,
      @required this.especialidadeId,
      this.consultaId,
      @required this.filaVirtualId});

  @override
  _ConfirmacaoState createState() => _ConfirmacaoState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId,
      unidadeId: this.unidadeId,
      especialidadeId: this.especialidadeId,
      consultaId: this.consultaId,
      filaVirtualId: this.filaVirtualId);
}

class _ConfirmacaoState extends State<_Confirmacao> {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  final String filaVirtualId;
  var _consultas = [];
  var _mensagem = [];
  final diaMesAno = DateFormat("d 'de' MMMM 'de' yyyy", "pt_BR");
  final diaSemana = DateFormat("EEEE", "pt_BR");
  final hora = DateFormat("Hm", "pt_BR");
  String _tpAcao;
  DialogState _dialogState;
  String _msgErro;
  _ConfirmacaoState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId,
      @required this.especialidadeId,
      this.consultaId,
      @required this.filaVirtualId});
  @override
  void initState() {
    this._tpAcao = "Verificando";
    this._msgErro = "";
    this._dialogState = DialogState.DISMISSED;
    initializeDateFormatting("pt_BR", null);
    if (this.filaVirtualId.isEmpty) {
      this._getConsultas();
    } else {
      this._getFilasVirtuais();
    }

    super.initState();
  }

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  void _getConsultas() async {
    setState(() => _dialogState = DialogState.LOADING);
    ConsultaModel consultaModel = await consultaBloc
        .fetchConsultas(
            this.consultaId,
            this.unidadeId,
            this.especialidadeId,
            DateTime.now().add(Duration(days: 1)).toString(),
            DateTime.now().add(Duration(days: 3)).toString())
        .catchError((e) {
      _dialogState = DialogState.ERROR;
      _msgErro = e.message.toString().toLowerCase().contains("future")
          ? "Serviço insiponível!"
          : e.message;
    });
    _consultas = consultaModel.getConsultas().toList();
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        if (_consultas.isNotEmpty && _consultas[0] != null) {
          _dialogState = DialogState.DISMISSED;
        } else {
          _dialogState = DialogState.ERROR;
          _msgErro = "Consulta indisponível";
        }
      });
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

  void _getFilasVirtuais() async {
    setState(() => _dialogState = DialogState.LOADING);
    FilaVirtualModel consultaModel = await filaVirtualBloc
        .fetchFilasVirtuais(
            this.consultaId,
            this.unidadeId,
            this.especialidadeId,
            DateTime.now().add(Duration(days: 1)).toString(),
            DateTime.now().add(Duration(days: 3)).toString())
        .catchError((e) {
      _dialogState = DialogState.ERROR;
      _msgErro = e.message.toString().toLowerCase().contains("future")
          ? "Serviço insiponível!"
          : e.message;
    });
    _consultas = consultaModel.getFilasVirtuais().toList();
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        if (_consultas.isNotEmpty && _consultas[0] != null) {
          _dialogState = DialogState.DISMISSED;
        } else {
          _dialogState = DialogState.ERROR;
          _msgErro = "Consulta indisponível";
        }
      });
    });
  }

  void _postFilaVirtual() async {
    setState(() {
      _dialogState = DialogState.LOADING;
      _tpAcao = "Registrando";
    });

    MensagemModel mensagemModel =
        await filaVirtualBloc.pushFilaVirtual(this.pacienteId, this.consultaId);
    var mensagem = mensagemModel.getMensagem();
    setState(() {
      _dialogState = DialogState.COMPLETED;
      _mensagem = mensagem;
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
                onHorizontalDragStart: (_) {
                  Navigator.pop(context);
                  SlideRightRouteR(
                      builder: (_) => Consulta(
                          paciente: this.paciente,
                          pacienteId: this.pacienteId,
                          unidadeId: this.unidadeId,
                          especialidadeId: this.especialidadeId,
                          moduloId: this.moduloId));
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
                      Row(children: <Widget>[
                        Cabecalho(
                          state: DialogState.DISMISSED,
                          textoCabecalho:
                              'Atenção! Confira os dados e confirme seu agendamento!',
                        ),
                      ]),
                      Row(children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _dialogState == DialogState.COMPLETED
                                      ? SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: MensagemDialog(
                                            state: _dialogState,
                                            paciente: this.paciente == null
                                                ? ""
                                                : this.paciente,
                                            pacienteId: this.pacienteId == null
                                                ? ""
                                                : this.pacienteId,
                                            textoTitle: this._mensagem.isEmpty
                                                ? ""
                                                : this
                                                    ._mensagem[0]
                                                    .tipoMensagem,
                                            textoMensagem: this
                                                    ._mensagem
                                                    .isEmpty
                                                ? ""
                                                : this._mensagem[0].mensagem,
                                            textoBtnOK: "OK",
                                            textoBtnCancel: "",
                                            textoState: _tpAcao +
                                                " agendamento no sistema...",
                                            slideRightRouteBtnOK:
                                                SlideRightRoute(
                                                    builder: (_) =>
                                                        Identificacao()),
                                            color: Color.fromRGBO(
                                                146, 174, 112, 0.75),
                                          ))
                                      : _dialogState == DialogState.ERROR
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: MensagemDialog(
                                                state: _dialogState,
                                                paciente: "",
                                                pacienteId: "",
                                                textoTitle: "Desculpe!",
                                                textoMensagem: _msgErro,
                                                textoBtnOK: "",
                                                textoBtnCancel: "Voltar",
                                                textoState: "",
                                                slideRightRouteBtnCancel:
                                                    SlideRightRoute(
                                                        builder: (_) => Consulta(
                                                            paciente:
                                                                this.paciente,
                                                            pacienteId:
                                                                this.pacienteId,
                                                            moduloId:
                                                                this.moduloId,
                                                            unidadeId:
                                                                this.unidadeId,
                                                            especialidadeId: this
                                                                .especialidadeId)),
                                                color: Color.fromRGBO(
                                                    146, 174, 112, 0.75),
                                              ))
                                          : SizedBox(
                                              child: Theme(
                                              data: Theme.of(context).copyWith(
                                                  accentColor: Color.fromRGBO(
                                                      146, 174, 112, 0),
                                                  canvasColor: Color.fromRGBO(
                                                      146, 174, 112, 0)),
                                              child: Container(
                                                  margin: EdgeInsets.all(0),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        _dialogState !=
                                                                DialogState
                                                                    .LOADING
                                                            ? Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
                                                                        top:
                                                                            20),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                          (this._consultas.isEmpty
                                                                              ? ""
                                                                              : "Paciente: " + this.paciente + ".\nData: " + diaSemana.format(DateTime.parse(this._consultas[0].dataInicio)) + ", " + diaMesAno.format(DateTime.parse(this._consultas[0].dataInicio)) + ".\nHorário: " + hora.format(DateTime.parse(this._consultas[0].dataInicio)) + ".\nUnidade: " + this._consultas[0].unidade + ".\nSala/Consultório: " + this._consultas[0].consultorio + ".\nDr(a): " + this._consultas[0].medico + ".\nEspecialidade: " + this._consultas[0].especialidade),
                                                                          style: TextStyle(color: Colors.white, fontFamily: 'Humanist', fontSize: 20, shadows: <Shadow>[
                                                                            Shadow(
                                                                                offset: Offset(2.0, 2.0),
                                                                                blurRadius: 3.0,
                                                                                color: Colors.green.withOpacity(0.7)),
                                                                            Shadow(
                                                                                offset: Offset(2.0, 2.0),
                                                                                blurRadius: 8.0,
                                                                                color: Colors.green.withOpacity(0.7)),
                                                                          ]),
                                                                          textAlign: TextAlign.left),
                                                                    ]))
                                                            : CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .white)),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    60),
                                                            child: RaisedButton
                                                                .icon(
                                                              onPressed: () {
                                                                if (this
                                                                    .filaVirtualId
                                                                    .isEmpty) {
                                                                  this._postConsulta();
                                                                } else {
                                                                  this._postFilaVirtual();
                                                                }
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
                                            ))
                                ])),
                      ])
                    ])))));
  }
}
