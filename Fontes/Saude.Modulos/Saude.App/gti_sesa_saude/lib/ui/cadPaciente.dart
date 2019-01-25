import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:gti_sesa_saude/blocs/paciente.bloc.dart';
import 'package:gti_sesa_saude/blocs/bairro.bloc.dart';
import 'package:gti_sesa_saude/models/bairro.model.dart';
import 'package:gti_sesa_saude/src/formatarCPF.dart';
import 'package:gti_sesa_saude/src/formatarCNS.dart';
import 'package:gti_sesa_saude/src/formatarData.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';

class CadPaciente extends StatelessWidget {
  final String documento;
  final String dataNascimento;
  CadPaciente({this.documento, this.dataNascimento});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTI-SESA',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color.fromARGB(1, 41, 84, 142),
          hintColor: Colors.white),
      home: _CadPaciente(
          documento: this.documento, dataNascimento: this.dataNascimento),
    );
  }
}

class _CadPaciente extends StatefulWidget {
  final String documento;
  final String dataNascimento;
  _CadPaciente({this.documento, this.dataNascimento});

  @override
  _CadPacienteState createState() => _CadPacienteState(
      documento: this.documento, dataNascimento: this.dataNascimento);
}

class _CadPacienteState extends State<_CadPaciente> {
  final _nome = TextEditingController();
  final _cpf = TextEditingController();
  final _cartaoSus = TextEditingController();
  final _dataNascimento = TextEditingController();
  final _telefone = TextEditingController();
  final String documento;
  final String dataNascimento;
  final focusCpf = FocusNode();
  final focusCns = FocusNode();
  final focusNasc = FocusNode();
  final focusTel = FocusNode();
  var paciente;
  var pacienteId;
  var _paciente = [];
  var _bairros = [];
  String _selBairro;

  DialogState _dialogState = DialogState.DISMISSED;
  DateTime selectedDate = DateTime.now();

  int _tpSexo = 0;
  String _dsSexo = "Masculino";
  _CadPacienteState({this.documento, this.dataNascimento});

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("pr_BR", null).then((_) {
      this._dataNascimento.text = this.dataNascimento;
      _cpf.text = this.documento.length == 14 ? this.documento : "";
      _cartaoSus.text = this.documento.length > 14 ? this.documento : "";
      this._dataNascimento.text = this.dataNascimento;
      this._getBairro();
      // BackButtonInterceptor.add(myInterceptor);
    });
  }

  @override
  void dispose() {
    _cpf.dispose();
    _cartaoSus.dispose();
    _dataNascimento.dispose();
    BackButtonInterceptor.removeAll();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  void _tpSexoChange(int value) {
    setState(() {
      _tpSexo = value;
      switch (_tpSexo) {
        case 0:
          _dsSexo = "Masculino";
          break;
        case 1:
          _dsSexo = "Feminino";
          break;
      }
    });
  }

  void _getBairro() async {
    BairroModel bairroModel = await bairroBloc.fetchBairros();
    var bairro = bairroModel.getBairros();
    setState(() {
      _bairros = bairro;
    });
  }

  void _postPaciente() async {
    setState(() => _dialogState = DialogState.LOADING);        
    await pacienteBloc
        .pushPaciente(
            this._nome.text,
            this._cpf.text,
            this._cartaoSus.text,
            this._dataNascimento.text,
            this._dsSexo.substring(0,1),
            this._telefone.text,
            _selBairro)
        .then((pacienteModel) {
      setState(() {
        _dialogState = DialogState.COMPLETED;
        _paciente = [pacienteModel.getPaciente()];
        if (_paciente.isNotEmpty) {
          paciente = _paciente[0].nome;
          pacienteId = _paciente[0].numero.toString();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        body: GestureDetector(
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
          child: ListView(padding: EdgeInsets.only(top: 200.0), children: <
              Widget>[
            Align(
              // heightFactor: 0.4,//MediaQuery.of(context).size.height * 0.0024,
              child: Stack(
                children: <Widget>[
                  Visibility(
                    visible: _dialogState == DialogState.DISMISSED,
                    child: Container(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Não encotramos seu cadastro em nossa base de dados.\nPor favor, preencha o formulário abaixo.',
                                style: TextStyle(
                                  fontFamily: 'Humanist',
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                                textAlign: TextAlign.center,
                              ),                              
                              Row(children: <Widget>[
                                Text(
                                  'Sexo:',
                                  style: TextStyle(
                                      fontFamily: 'Humanist',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                Radio(
                                  value: 0,
                                  groupValue: _tpSexo,
                                  onChanged: _tpSexoChange,
                                  activeColor: Color.fromRGBO(41, 84, 142, 1),
                                ),
                                Text(
                                  'Masculino',
                                  style: TextStyle(
                                      fontFamily: 'Humanist',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                Radio(
                                  value: 1,
                                  groupValue: _tpSexo,
                                  onChanged: _tpSexoChange,
                                  activeColor: Color.fromRGBO(41, 84, 142, 1),
                                ),
                                Text(
                                  'Feminino',
                                  style: TextStyle(
                                      fontFamily: 'Humanist',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ]),
                              TextField(
                                controller: _nome,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(focusCpf);
                                },
                                //maxLength: 11,
                                decoration: InputDecoration(
                                  counterText: '',
                                  labelText: "Nome:",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Humanist',
                                    color: Colors.white70,
                                    fontSize: 25,
                                  ),
                                ),
                                style: TextStyle(
                                    fontFamily: 'Humanist',
                                    color: Colors.white,
                                    fontSize: 20),
                                keyboardType: TextInputType.text,
                              ),
                              TextField(
                                  focusNode: focusCpf,
                                  controller: _cpf,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(focusCns);
                                  },
                                  maxLength: 11,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    labelText: "Cpf:",
                                    labelStyle: TextStyle(
                                      fontFamily: 'Humanist',
                                      color: Colors.white70,
                                      fontSize: 25,
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontFamily: 'Humanist',
                                      color: Colors.white,
                                      fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    FormatarCPF()
                                  ]),
                              TextField(
                                focusNode: focusCns,
                                  controller: _cartaoSus,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(focusNasc);
                                  },
                                  maxLength: 18,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      labelText: "Cartão SUS:",
                                      labelStyle: TextStyle(
                                        fontFamily: 'Humanist',
                                        color: Colors.white70,
                                        fontSize: 25,
                                      )),
                                  style: TextStyle(
                                      fontFamily: 'Humanist',
                                      color: Colors.white,
                                      fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    FormatarCNS()
                                  ]),
                              TextField(                                
                                  controller: _dataNascimento,
                                   textInputAction: TextInputAction.next,
                                  focusNode: focusNasc,
                                  onSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(focusTel);
                                  },
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      labelText: "Data de nascimento:",
                                      labelStyle: TextStyle(
                                        fontFamily: 'Humanist',
                                        color: Colors.white,
                                        fontSize: 25,
                                      )),
                                  style: TextStyle(
                                      fontFamily: 'Humanist',
                                      color: Colors.white,
                                      fontSize: 20),
                                  keyboardType: TextInputType.datetime,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    FormatarData()
                                  ]),
                              TextField(
                                  controller: _telefone,
                                   textInputAction: TextInputAction.done,
                                  focusNode: focusTel,
                                  onSubmitted: (v) {
                                     _postPaciente();
                                  },
                                  maxLength: 18,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      labelText: "Telefone:",
                                      labelStyle: TextStyle(
                                        fontFamily: 'Humanist',
                                        color: Colors.white,
                                        fontSize: 25,
                                      )),
                                  style: TextStyle(
                                      fontFamily: 'Humanist',
                                      color: Colors.white,
                                      fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    FormatarData()
                                  ]),
                                  Theme(
                                  data: Theme.of(context).copyWith(
                                      canvasColor:
                                          Colors.blue[900].withOpacity(0.7)),
                                  child: DropdownButton(
                                    isDense: false,
                                    iconSize: 36,
                                    hint: Text(
                                      'Bairro onde mora:',
                                      style: TextStyle(
                                        fontFamily: 'Humanist',
                                        color: Colors.white,
                                        fontSize: 25,
                                        shadows: <Shadow>[
                                          Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 3.0,
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                          Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 8.0,
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                        ],
                                      ),
                                    ),
                                    value: _selBairro,
                                    items: _bairros.map((bairro) {
                                      return DropdownMenuItem(
                                        value: bairro.numero,
                                        child: Text(
                                          bairro.nome,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Humanist',
                                            fontSize: 25,
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 3.0,
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                              Shadow(
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 8.0,
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        _selBairro = newVal;
                                      });
                                    },
                                    style: TextStyle(
                                      //color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    isExpanded: true,
                                    elevation: 24,
                                  )),
                            ])),
                  ),
                  Visibility(
                    visible: _dialogState != DialogState.DISMISSED,
                    child: Container(
                        //padding: const EdgeInsets.all(40.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MensagemDialog(
                                state: _dialogState,
                                paciente:
                                    this.paciente == null ? "" : this.paciente,
                                pacienteId: this.pacienteId == null
                                    ? ""
                                    : this.pacienteId,
                                textoTitle: this.pacienteId == null
                                    ? " Aguarde..."
                                    : " Olá " + this.paciente + "!",
                                textoMensagem:
                                    "Cadastro realizado com sucesso.\nDeseja se conectar ao Sistema de Saúde da Prefeitura de Serra-ES?",
                                textoBtnOK: "Sim",
                                textoBtnCancel: "Não",
                                textoState:
                                    "Registrando usuário no sistema...\n" +
                                        // " Nome:\n " + this._nome.text +
                                        " Cpf: " +
                                        this._cpf.text +
                                        "\nCns: " +
                                        this._cartaoSus.text +
                                        "",
                              )
                            ])),
                  )
                ],
              ),
            )
          ])),
    ));
  }
}
