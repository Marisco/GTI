import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/ui/cadPaciente.dart';
import 'package:gti_sesa_saude/models/paciente.model.dart';
import 'package:gti_sesa_saude/blocs/paciente.bloc.dart';
import 'package:gti_sesa_saude/src/formatacao.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';

class Passo01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTI-SESA',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color.fromARGB(1, 41, 84, 142),
        hintColor: Colors.white,
      ),
      home: Paciente(
        title: "GTI-SESA",
      ),
    );
  }
}

class Paciente extends StatefulWidget {
  Paciente({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PacienteState createState() => _PacienteState();
}

class _PacienteState extends State<Paciente> {
  final _documento = TextEditingController();
  int _tpDocumento = 1;
  String _dsDocumento = "";
  final _dataNascimento = TextEditingController();
  var paciente;
  var pacienteId;
  var _paciente = [];
  DialogState _dialogState = DialogState.DISMISSED;
  DateTime selectedDate = DateTime.now();
  final focus = FocusNode();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("pr_BR", null).then((_) {
      _tpDocumentoChange(0);
      //BackButtonInterceptor.add(myInterceptor);
    });
  }

  @override
  void dispose() {
    _documento.dispose();
    _dataNascimento.dispose();
    BackButtonInterceptor.removeAll();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  void _tpDocumentoChange(int value) {
    setState(() {
      _documento.text = "";
      _tpDocumento = value;
      switch (_tpDocumento) {
        case 0:
          _dsDocumento = "cpf:";
          break;
        case 1:
          _dsDocumento = "cns:";
          break;
      }
    });
  }

  void _getPaciente() async {
    setState(() => _dialogState = DialogState.LOADING);
    PacienteModel pacienteModel = await pacienteBloc.fetchPaciente(
        this._documento.text, this._dataNascimento.text);
    setState(() {
      _paciente = [pacienteModel.getPaciente()];
      if (_paciente.isNotEmpty && _paciente[0] != null) {
        _dialogState = DialogState.COMPLETED;
        paciente = _paciente[0].nome;
        pacienteId = _paciente[0].numero.toString();
      } else {
        _dialogState = DialogState.DISMISSED;
        Navigator.push(
            context,
            new SlideRightRoute(
                builder: (_) => CadPaciente(
                    documento: this._documento.text,
                    dataNascimento: this._dataNascimento.text)));
      }
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/passo01.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Cabecalho(
                            textoMensagem:
                                'Olá! Seja bem vindo ao sistema de saúde do Município da Serra.',
                            state: _dialogState),
                      ]),
                      Row(children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.60,
                                      child: ListView(children: <Widget>[
                                        Align(
                                          child: Stack(
                                            children: <Widget>[
                                              Visibility(
                                                visible: _dialogState ==
                                                    DialogState.DISMISSED,
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    // padding: EdgeInsets.only(
                                                    //     left: 20, right: 20),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Row(children: <
                                                              Widget>[
                                                            Text(
                                                              'Documento:',
                                                              style: new TextStyle(
                                                                  fontFamily:
                                                                      'Humanist',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 25),
                                                            ),
                                                            Radio(
                                                              value: 0,
                                                              groupValue:
                                                                  _tpDocumento,
                                                              onChanged:
                                                                  _tpDocumentoChange,
                                                              activeColor: Color
                                                                  .fromRGBO(
                                                                      41,
                                                                      84,
                                                                      142,
                                                                      1),
                                                            ),
                                                            Text(
                                                              'Cpf',
                                                              style: new TextStyle(
                                                                  fontFamily:
                                                                      'Humanist',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 25),
                                                            ),
                                                            Radio(
                                                              value: 1,
                                                              groupValue:
                                                                  _tpDocumento,
                                                              onChanged:
                                                                  _tpDocumentoChange,
                                                              activeColor: Color
                                                                  .fromRGBO(
                                                                      41,
                                                                      84,
                                                                      142,
                                                                      1),
                                                            ),
                                                            Text(
                                                              'Cartão Sus',
                                                              style: new TextStyle(
                                                                  fontFamily:
                                                                      'Humanist',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 25),
                                                            ),
                                                          ]),
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      bottom:
                                                                          15,
                                                                      top: 0),
                                                              child: Container(
                                                                  height: 75,
                                                                  padding:
                                                                      EdgeInsets.only(
                                                                          top:
                                                                              0),
                                                                  decoration: new BoxDecoration(
                                                                      color: Color.fromRGBO(
                                                                              41,
                                                                              84,
                                                                              142,
                                                                              1)
                                                                          .withOpacity(
                                                                              0.25),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(25))),
                                                                  child: Padding(
                                                                      padding: EdgeInsets.only(left: 20),
                                                                      child: TextField(
                                                                          controller: _documento,
                                                                          textInputAction: TextInputAction.next,
                                                                          onSubmitted: (v) {
                                                                            FocusScope.of(context).requestFocus(focus);
                                                                          },
                                                                          maxLength: 18,
                                                                          decoration: new InputDecoration(
                                                                            counterText:
                                                                                '',
                                                                            labelText:
                                                                                "Digite o nº do " + _dsDocumento,
                                                                            labelStyle: new TextStyle(
                                                                                fontFamily: 'Humanist',
                                                                                color: Colors.white70,
                                                                                fontSize: 30,
                                                                                letterSpacing: 1.5),
                                                                            border:
                                                                                InputBorder.none,
                                                                            //border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                                                                            //borderRadius: BorderRadius.all(Radius.circular(25)), gapPadding: 1.0)
                                                                          ),
                                                                          style: new TextStyle(fontFamily: 'Humanist', color: Colors.white, fontSize: 20),
                                                                          keyboardType: TextInputType.number,
                                                                          inputFormatters: <TextInputFormatter>[
                                                                            WhitelistingTextInputFormatter.digitsOnly,
                                                                            _tpDocumento == 0
                                                                                ? FormatarCPF()
                                                                                : FormatarCNS()
                                                                          ])))),
                                                          Container(
                                                              height: 75,
                                                              decoration: new BoxDecoration(
                                                                  color: Color.fromRGBO(
                                                                          41,
                                                                          84,
                                                                          142,
                                                                          1)
                                                                      .withOpacity(
                                                                          0.25),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              25))),
                                                              child: Padding(
                                                                  padding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              20),
                                                                  child:
                                                                      TextField(
                                                                          controller:
                                                                              _dataNascimento,
                                                                          focusNode: focus,
                                                                          onSubmitted: (v) {
                                                                            _getPaciente();
                                                                          },
                                                                          maxLength: 10,
                                                                          decoration: InputDecoration(
                                                                            counterText:
                                                                                '',
                                                                            labelText:
                                                                                "Data de nascimento:",
                                                                            labelStyle:
                                                                                TextStyle(
                                                                              fontFamily: 'Humanist',
                                                                              color: Colors.white70,
                                                                              fontSize: 30,
                                                                              letterSpacing: 1.5,
                                                                            ),
                                                                            border:
                                                                                InputBorder.none,
                                                                          ),
                                                                          style: TextStyle(fontFamily: 'Humanist', color: Colors.white, fontSize: 20),
                                                                          keyboardType: TextInputType.number,
                                                                          inputFormatters: <TextInputFormatter>[
                                                                        WhitelistingTextInputFormatter
                                                                            .digitsOnly,
                                                                        FormatarData()
                                                                      ]))),
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(40),
                                                              child:
                                                                  RaisedButton
                                                                      .icon(
                                                                onPressed: () {
                                                                  _getPaciente();
                                                                },
                                                                elevation: 5.0,
                                                                shape:
                                                                    new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                              .circular(
                                                                          15.0),
                                                                ),
                                                                //color: const Color.fromARGB(255, 175, 207, 45),
                                                                color: Color
                                                                        .fromRGBO(
                                                                            41,
                                                                            84,
                                                                            142,
                                                                            1)
                                                                    .withOpacity(
                                                                        0.75),
                                                                icon: Icon(
                                                                    Icons
                                                                        .play_arrow,
                                                                    color: Colors
                                                                        .white70),
                                                                label: Text(
                                                                  "",
                                                                  style: TextStyle(
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
                                                      DialogState.DISMISSED,
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
                                                                      .pacienteId ==
                                                                  null
                                                              ? " Aguarde..."
                                                              : " Olá " +
                                                                  this.paciente +
                                                                  "!",
                                                          textoMensagem:
                                                              "Deseja se conectar ao Sistema de Saúde da Prefeitura de Serra-ES? \nVocê não é esta pessoa? Clique NÃO!",
                                                          textoBtnOK: "Sim",
                                                          textoBtnCancel: "Não",
                                                          textoState: (this
                                                                          ._documento
                                                                          .text
                                                                          .length ==
                                                                      14
                                                                  ? "Localizando Cpf"
                                                                  : "Localizando Catão SUS") +
                                                              ":\n " +
                                                              this
                                                                  ._documento
                                                                  .text +
                                                              "",
                                                        )
                                                      ])),
                                            ],
                                          ),
                                        )
                                      ]))
                                ]))
                      ])
                    ])))));
  }
}
