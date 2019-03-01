import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/ui/cadPaciente.dart';
import 'package:gti_sesa_saude/models/paciente.model.dart';
import 'package:gti_sesa_saude/blocs/paciente.bloc.dart';
import 'package:gti_sesa_saude/src/formatacao.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';
import 'package:gti_sesa_saude/ui/passo02.dart';

class Passo01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GTI-SESA',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color.fromARGB(1, 41, 84, 142),
          hintColor: Colors.white,
        ),
        home: Paciente());
  }
}

class Paciente extends StatefulWidget {
  @override
  _PacienteState createState() => _PacienteState();
}

class _PacienteState extends State<Paciente> {
  final _documento = TextEditingController();
  final _dataNascimento = TextEditingController();
  final focus = FocusNode();
  int _tpDocumento = 1;
  var paciente;
  var pacienteId;
  var _paciente = [];
  DateTime selectedDate = DateTime.now();
  String _dsDocumento;
  String _msgErro = "";
  DialogState _dialogState = DialogState.DISMISSED;
  _PacienteState();

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    _tpDocumentoChange(0);
    super.initState();
  }

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    _documento.dispose();
    _dataNascimento.dispose();
    super.dispose();
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
    PacienteModel pacienteModel = await pacienteBloc
        .fetchPaciente(this._documento.text, this._dataNascimento.text)
        .catchError((e) {
      setState(() {
        _dialogState = DialogState.ERROR;
        _msgErro = e.message.toString().toLowerCase().contains("future")
            ? "Serviço insiponível!"
            : e.message;
      });
    });

    setState(() {
      _paciente = [pacienteModel.getPaciente()];
      if (_paciente.isNotEmpty && _paciente[0] != null) {
        _dialogState = DialogState.COMPLETED;
        paciente = _paciente[0].nome;
        pacienteId = _paciente[0].numero.toString();
      } else {        
        Navigator.push(
            context,
            SlideRightRoute(
                builder: (_) => CadPaciente(
                    documento: this._documento.text,
                    dataNascimento: this._dataNascimento.text)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Cabecalho(
                          textoMensagem:
                              'Olá! Seja bem vindo ao sistema de saúde do Município da Serra.',
                          state: _dialogState),
                      Row(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _dialogState == DialogState.DISMISSED
                                  ? Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(children: <Widget>[
                                              Text(
                                                'Documento:',
                                                style: TextStyle(
                                                    fontFamily: 'Humanist',
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Radio(
                                                    value: 0,
                                                    groupValue: _tpDocumento,
                                                    onChanged:
                                                        _tpDocumentoChange,
                                                    activeColor: Color.fromRGBO(
                                                        41, 84, 142, 1),
                                                  )),
                                              Text(
                                                'Cpf',
                                                style: TextStyle(
                                                    fontFamily: 'Humanist',
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Radio(
                                                    value: 1,
                                                    groupValue: _tpDocumento,
                                                    onChanged:
                                                        _tpDocumentoChange,
                                                    activeColor: Color.fromRGBO(
                                                        41, 84, 142, 1),
                                                  )),
                                              Text(
                                                'Cartão Sus',
                                                style: TextStyle(
                                                    fontFamily: 'Humanist',
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                            ]),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10, top: 0),
                                                child: Container(
                                                    height: 75,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                                41, 84, 142, 1)
                                                            .withOpacity(0.25),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                    child: Padding(
                                                        padding: EdgeInsets.only(
                                                            left: 20),
                                                        child: TextField(
                                                            controller:
                                                                _documento,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            onSubmitted: (_) {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      focus);
                                                            },
                                                            maxLength: _tpDocumento == 0 ? 14 : 18,
                                                            decoration: InputDecoration(
                                                              counterText: '',
                                                              labelText:
                                                                  "Digite o nº do " +
                                                                      _dsDocumento,
                                                              labelStyle: TextStyle(
                                                                  fontFamily:
                                                                      'Humanist',
                                                                  color: Colors
                                                                      .white70,
                                                                  fontSize: 30,
                                                                  letterSpacing:
                                                                      1.5),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            style: TextStyle(fontFamily: 'Humanist', color: Colors.white, fontSize: 20),
                                                            keyboardType: TextInputType.number,
                                                            inputFormatters: <TextInputFormatter>[
                                                              WhitelistingTextInputFormatter
                                                                  .digitsOnly,
                                                              _tpDocumento == 0
                                                                  ? FormatarCPF()
                                                                  : FormatarCNS()
                                                            ])))),
                                            Container(
                                                height: 75,
                                                margin: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.04),
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                            41, 84, 142, 1)
                                                        .withOpacity(0.25),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(25))),
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 20,
                                                    ),
                                                    child: TextField(
                                                        controller:
                                                            _dataNascimento,
                                                        focusNode: focus,
                                                        textInputAction:
                                                            TextInputAction.search,
                                                        onSubmitted: (_) {
                                                          _getPaciente();
                                                        },
                                                        maxLength: 10,
                                                        decoration: InputDecoration(
                                                          counterText: '',
                                                          labelText:
                                                              "Data de nascimento:",
                                                          labelStyle: TextStyle(
                                                            fontFamily:
                                                                'Humanist',
                                                            color:
                                                                Colors.white70,
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
                                            RaisedButton.icon(
                                              onPressed: () {
                                                _getPaciente();
                                              },
                                              elevation: 5.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color:
                                                  Color.fromRGBO(41, 84, 142, 1)
                                                      .withOpacity(0.75),
                                              icon: Icon(Icons.play_arrow,
                                                  size: 36,
                                                  color: Colors.white70),
                                              label: Text(
                                                "",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white),
                                              ),
                                            )
                                          ]),
                                    )
                                  : _dialogState == DialogState.ERROR
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
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
                                                    builder: (_) => Passo01()),
                                            color: Color.fromRGBO(
                                                41, 84, 142, 0.5),
                                          ))
                                      : Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: MensagemDialog(
                                            state: _dialogState,
                                            paciente: this.paciente == null
                                                ? ""
                                                : this.paciente,
                                            pacienteId: this.pacienteId == null
                                                ? ""
                                                : this.pacienteId,
                                            textoTitle: this.pacienteId == null
                                                ? " Aguarde..."
                                                : " Olá " + this.paciente + "!",
                                            textoMensagem:
                                                "Deseja se conectar ao Sistema de Saúde da Prefeitura de Serra-ES? \nClique NÃO se você não é esta pessoa!",
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
                                                this._documento.text +
                                                "",
                                            slideRightRouteBtnOK:
                                                SlideRightRoute(
                                                    builder: (_) => Passo02(
                                                        paciente: this.paciente,
                                                        pacienteId:
                                                            this.pacienteId)),
                                            slideRightRouteBtnCancel:
                                                SlideRightRoute(
                                                    builder: (_) => Passo01()),
                                            color: this.paciente == null
                                                ? Colors.transparent
                                                : Color.fromRGBO(
                                                    41, 84, 142, 0.5),
                                          ))
                            ],
                          ),
                        )
                      ])
                    ])))));
  }
}
