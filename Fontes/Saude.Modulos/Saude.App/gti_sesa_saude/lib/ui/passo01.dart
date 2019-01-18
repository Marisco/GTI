import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:gti_sesa_saude/blocs/paciente.bloc.dart';
import 'package:gti_sesa_saude/src/formata.documento.dart';
import 'package:gti_sesa_saude/src/formata.data.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';

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
  final _dataNascimento = TextEditingController();
  var paciente;
  var pacienteId;
  var _paciente = [];
  DialogState _dialogState = DialogState.DISMISSED;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("pr_BR", null).then((_) {
      BackButtonInterceptor.add(myInterceptor);
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
  void _getPaciente() async {
    setState(() => _dialogState = DialogState.LOADING);
    await pacienteBloc
        .fetchPaciente(this._documento.text, this._dataNascimento.text)
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

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return MensagemDialog(
    //                 state: _dialogState,
    //                 paciente: this.paciente,
    //                 pacienteId: this.pacienteId,
    //               );
    //       });

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: new Text("Olá " + paciente + "!"),
    //         content: new Text(
    //             "Você irá se conectar ao Sistema de Saúde da Serra-ES. Caso você não seja esta pessoa, cancele esta operação!"),
    //         actions: <Widget>[
    //           new FlatButton(
    //               child: new Text("Cancelar! Não sou esta pessoa."),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               }),
    //           new FlatButton(
    //               child: new Text("Continuar."),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //                 Navigator.push(
    //                     context,
    //                     new SlideRightRoute(
    //                         builder: (_) => Passo02(
    //                             paciente: this.paciente, pacienteId: this.pacienteId)));
    //               })
    //         ],
    //       );
    //     });
    // } else {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: new Text("Erro!"),
    //           content: new Text(
    //               "Campo obrigatório, número inexistente ou inválido!"),
    //           actions: <Widget>[
    //             new FlatButton(
    //                 child: new Text("Ok"),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                   _documento.text = "";
    //                 })
    //           ],
    //         );
    //       });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Passo 1"),
          backgroundColor: Color.fromRGBO(41, 84, 142, 1),
          actions: <Widget>[
            new Image.asset(
              "img/logo_icon.png",
              width: 50,
            )
          ]),
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("img/passo01.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Visibility(
                visible: _dialogState == DialogState.DISMISSED,
                child: Expanded(
                  flex: 8,
                  child: Container(
                    padding: const EdgeInsets.only( top: 50.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Text(
                          'Olá! Seja bem vindo ao sistema de saúde do Município da Serra.',
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
                              padding: const EdgeInsets.only(top: 15.0),
                              child: TextField(
                                  controller: _documento,
                                  maxLength: 14,
                                  decoration: new InputDecoration(
                                      counterText: '',
                                      labelText: "Cpf ou Cartão Sus",
                                      labelStyle: new TextStyle(
                                        fontFamily: 'Humanist',
                                        color: Colors.white70,
                                        fontSize: 25,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        gapPadding: 1.0,
                                      )),
                                  style: new TextStyle(
                                      fontFamily: 'Humanist',
                                      color: Colors.white,
                                      fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    FormataDocumento()
                                  ]),
                            )),
                        Expanded(
                            flex: 0,
                            child: Padding(
                                padding: const EdgeInsets.only(top :1.0),
                                child: TextField(
                                  controller: _dataNascimento,
                                  maxLength: 10,
                                  decoration: new InputDecoration(
                                      counterText: '',
                                      labelText: "Data de Nascimento:",
                                      labelStyle: new TextStyle(
                                        fontFamily: 'Humanist',
                                        color: Colors.white70,
                                        fontSize: 25,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        gapPadding: 1.0,
                                      )),
                                  style: new TextStyle(
                                      fontFamily: 'Humanist',
                                      color: Colors.white,
                                      fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    FormataData()
                                  ]),
                                )),
                        RaisedButton.icon(
                          onPressed: () {
                            _getPaciente();
                          },
                          elevation: 5.0,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                          //color: const Color.fromARGB(255, 175, 207, 45),
                          color:
                              Color.fromRGBO(41, 84, 142, 1).withOpacity(0.7),
                          icon: Icon(Icons.play_arrow, color: Colors.white70),
                          label: Text(
                            "",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ])),
                )),
            Visibility(
                visible: _dialogState != DialogState.DISMISSED,
                child: Expanded(
                  flex: 35,
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        MensagemDialog(
                          state: _dialogState,
                          paciente: this.paciente == null ? "" : this.paciente,
                          pacienteId:
                              this.pacienteId == null ? "" : this.pacienteId,
                              textoTitle: this.pacienteId == null ? " Aguarde,": " Olá "+ this.paciente+"!",
                              textoMensagem: "Deseja se conectar ao Sistema de Saúde da Prefeitura de Serra-ES? \nVocê não é esta pessoa? Clique NÃO!",
                              textoBtnOK: "Sim",
                              textoBtnCancel: "Não",
                              textoState: (this._documento.text.length == 14 ? "Localizando Cpf":"Localizando Catão SUS") + ":\n "+ this._documento.text +"",

                        )
                      ])),
                )),
            Expanded(
              child: Container(),
            )
            //MenuLateral(),
          ],
        ),
      ),
    );
  }
}
