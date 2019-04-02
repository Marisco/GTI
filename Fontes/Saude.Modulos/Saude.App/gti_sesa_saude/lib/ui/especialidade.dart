import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/blocs/especialidade.bloc.dart';
import 'package:gti_sesa_saude/models/especialidade.model.dart';
import 'package:gti_sesa_saude/ui/unidade.dart';
import 'package:gti_sesa_saude/ui/consulta.dart';
import 'package:gti_sesa_saude/ui/filaVirtual.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';

class Especialidade extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;

  Especialidade({
    @required this.paciente,
    @required this.pacienteId,
    @required this.moduloId,
    @required this.unidadeId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Especialidade(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId,
      unidadeId: this.unidadeId,
    ));
  }
}

class _Especialidade extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;

  _Especialidade({
    @required this.paciente,
    @required this.pacienteId,
    @required this.moduloId,
    @required this.unidadeId,
  });
  @override
  _EspecialidadeState createState() => _EspecialidadeState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId,
      unidadeId: this.unidadeId);
}

class _EspecialidadeState extends State<_Especialidade> {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;

  var _especialidades = [];
  String _selEspecialidade;
  String _msgErro;
  DialogState _dialogState;
  SlideRightRoute _slideRightRoute;

  _EspecialidadeState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId});

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    this._msgErro = "";
    _dialogState = DialogState.DISMISSED;
    this._getEspecialidades();

    switch (this.moduloId) {
      case "1":
        _slideRightRoute = SlideRightRoute(
            builder: (_) => Consulta(
                paciente: this.paciente,
                pacienteId: this.pacienteId,
                moduloId: this.moduloId,
                unidadeId: this.unidadeId,
                especialidadeId: this._selEspecialidade));

        break;
      case "3":
        _slideRightRoute = SlideRightRoute(
            builder: (_) => FilaVirtual(
                paciente: this.paciente,
                pacienteId: this.pacienteId,
                moduloId: this.moduloId,
                unidadeId: this.unidadeId,
                especialidadeId: this._selEspecialidade));

        break;
      default:
    }

    super.initState();
  }

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  void _getEspecialidades() async {
    setState(() => _dialogState = DialogState.LOADING);
    EspecialidadeModel especialidadeModel = await especialidadeBloc
        .fetchEspecialidades(this.unidadeId, DateTime.now().toString(),
            DateTime.now().add(Duration(days: 4)).toString())
        .catchError((e) {
      _dialogState = DialogState.ERROR;
      _msgErro = e.message.toString().toLowerCase().contains("future")
          ? "Serviço insiponível!"
          : e.message;
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _especialidades = especialidadeModel.getEspecialidades().toList();
        if (_especialidades.isNotEmpty && _especialidades[0] != null) {
          _dialogState = DialogState.COMPLETED;
        } else {
          _dialogState = DialogState.ERROR;
          _msgErro = "Especialidade indisponível";
        }
      });
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
                      builder: (_) => Unidade(
                          paciente: this.paciente,
                          pacienteId: this.pacienteId,
                          moduloId: this.moduloId));
                },
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/passo03.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Cabecalho(
                          state: DialogState.DISMISSED,
                          textoCabecalho: 'Escolha a especialidade médica.',
                        ),
                      ]),
                      Row(children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _dialogState == DialogState.ERROR
                                    ? SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                                  builder: (_) => Unidade(
                                                      paciente: this.paciente,
                                                      pacienteId:
                                                          this.pacienteId,
                                                      moduloId: this.moduloId)),
                                          color: Color.fromRGBO(
                                              63, 157, 184, 0.75),
                                        ))
                                    : SizedBox(
                                        child: Theme(
                                        data: Theme.of(context).copyWith(
                                            accentColor: Color.fromRGBO(
                                                63, 157, 184, 0.75),
                                            canvasColor: Color.fromRGBO(
                                                63, 157, 184, 0.75)),
                                        child: Container(
                                            margin: EdgeInsets.all(40),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  _dialogState !=
                                                          DialogState.LOADING
                                                      ? DropdownButton(
                                                          iconSize: 48,
                                                          isDense: false,
                                                          hint: Text(
                                                            'Escolha uma opção:',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Humanist',
                                                              fontSize: 28,
                                                              shadows: <Shadow>[
                                                                Shadow(
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        3.0,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.7)),
                                                                Shadow(
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        8.0,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.7)),
                                                              ],
                                                            ),
                                                          ),
                                                          value:
                                                              _selEspecialidade,
                                                          items: _especialidades
                                                              .map((unidade) {
                                                            return DropdownMenuItem(
                                                              value: unidade
                                                                  .numero,
                                                              child: Text(
                                                                unidade.nome,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Humanist',
                                                                  fontSize: 25,
                                                                  shadows: <
                                                                      Shadow>[
                                                                    Shadow(
                                                                        offset: Offset(1.0,
                                                                            1.0),
                                                                        blurRadius:
                                                                            3.0,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.7)),
                                                                    Shadow(
                                                                        offset: Offset(1.0,
                                                                            1.0),
                                                                        blurRadius:
                                                                            8.0,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.7)),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newVal) {
                                                            setState(() {
                                                              _selEspecialidade =
                                                                  newVal;
                                                            });
                                                          },
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                          isExpanded: true,
                                                          elevation: 24,
                                                        )
                                                      : CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors
                                                                      .white)),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(40),
                                                      child: RaisedButton.icon(
                                                        onPressed:
                                                            _dialogState ==
                                                                    DialogState
                                                                        .LOADING
                                                                ? null
                                                                : () {
                                                                    Navigator.push(
                                                                        context,
                                                                        _slideRightRoute);
                                                                  },
                                                        elevation: 5.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                        ),
                                                        color: _dialogState ==
                                                                DialogState
                                                                    .LOADING
                                                            ? Colors.grey
                                                                .withOpacity(
                                                                    0.75)
                                                            : Color.fromRGBO(63,
                                                                157, 184, 0.75),
                                                        icon: Icon(
                                                            Icons.play_arrow,
                                                            color:
                                                                Colors.white70),
                                                        label: Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Humanist',
                                                              fontSize: 30,
                                                              color:
                                                                  Colors.white),
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
