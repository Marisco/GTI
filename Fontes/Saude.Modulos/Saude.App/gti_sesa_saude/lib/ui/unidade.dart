import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/blocs/unidade.bloc.dart';
import 'package:gti_sesa_saude/models/unidade.model.dart';
import 'package:gti_sesa_saude/ui/identificacao.dart';
import 'package:gti_sesa_saude/ui/especialidade.dart';
import 'package:gti_sesa_saude/ui/avaliacao.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';

class Unidade extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  Unidade(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Unidade(
            paciente: this.paciente,
            pacienteId: this.pacienteId,
            moduloId: this.moduloId));
  }
}

class _Unidade extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;

  _Unidade(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});
  @override
  _UnidadeState createState() => _UnidadeState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId);
}

class _UnidadeState extends State<_Unidade> {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  DialogState _dialogState;
  SlideRightRoute _slideRightRoute;
  String _msgErro;
  String _selUnidade;
  var _unidades = [];

  _UnidadeState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  @override
  void initState() {
    _dialogState = DialogState.DISMISSED;
    _msgErro = "";
    this._getUnidades();
    switch (this.moduloId) {
      case "1":
        _slideRightRoute = SlideRightRoute(
            builder: (_) => Especialidade(
                paciente: this.paciente,
                pacienteId: this.pacienteId,
                moduloId: this.moduloId,
                unidadeId: this._selUnidade));

        break;
      case "2":
        _slideRightRoute = SlideRightRoute(
            builder: (_) => Avaliacao(
                paciente: this.paciente,
                pacienteId: this.pacienteId,
                moduloId: this.moduloId,
                unidadeId: this._selUnidade));

        break;
      case "2":
        _slideRightRoute = SlideRightRoute(
            builder: (_) => Especialidade(
                paciente: this.paciente,
                pacienteId: this.pacienteId,
                moduloId: this.moduloId,
                unidadeId: this._selUnidade));

        break;
      default:
    }

    super.initState();
  }

  void _getUnidades() async {
    setState(() => _dialogState = DialogState.LOADING);
    UnidadeModel unidadeModel =
        await unidadeBloc.fetchUnidades().catchError((e) {
      setState(() {
        _dialogState = DialogState.ERROR;
        _msgErro = e.message.toString().toLowerCase().contains("future")
            ? "Serviço insiponível!"
            : e.message;
      });
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _unidades = unidadeModel.getUnidades().toList();
        if (_unidades.isNotEmpty && _unidades[0] != null) {
          _dialogState = DialogState.COMPLETED;
        } else {
          _dialogState = DialogState.ERROR;
          _msgErro = "Unidades indisponíveis";
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
                  SlideRightRouteR(builder: (_) => Identificacao());
                },
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/passo02.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Cabecalho(
                          state: DialogState.DISMISSED,
                          textoCabecalho: this
                                  .paciente
                                  .substring(0, this.paciente.indexOf(" ")) +
                              ', escolha uma unidade de saúde.',
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
                                                0.55,
                                        child: MensagemDialog(
                                          state: _dialogState,
                                          paciente: "",
                                          pacienteId: "",
                                          textoTitle: "Desculpe!",
                                          textoMensagem: _msgErro,
                                          textoBtnOK: "",
                                          textoBtnCancel: "Voltar",
                                          textoState: "",
                                          slideRightRouteBtnCancel: null,
                                          //     SlideRightRoute(
                                          //         builder: (_) => Passo01()),
                                          // color: Color.fromRGBO(
                                          //     125, 108, 187, 0.75),
                                        ))
                                    : SizedBox(
                                        child: Theme(
                                        data: Theme.of(context).copyWith(
                                            accentColor: Color.fromRGBO(
                                                125, 108, 187, 0.75),
                                            canvasColor: Color.fromRGBO(
                                                125, 108, 187, 0.75)),
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
                                                          value: _selUnidade,
                                                          items: _unidades
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
                                                              _selUnidade =
                                                                  newVal;
                                                            });
                                                          },
                                                          style: TextStyle(
                                                            //color: Colors.black,
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
                                                            : Color.fromRGBO(
                                                                125,
                                                                108,
                                                                187,
                                                                0.75), //Color.fromRGBO(41, 84, 142, 1),
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
                                                      ))
                                                ])),
                                      ))
                              ],
                            )),
                      ])
                    ])))));
  }
}
