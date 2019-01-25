import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/ui/cadPaciente.dart';
import 'package:gti_sesa_saude/blocs/paciente.bloc.dart';
import 'package:gti_sesa_saude/src/formatarCPF.dart';
import 'package:gti_sesa_saude/src/formatarCNS.dart';
import 'package:gti_sesa_saude/src/formatarData.dart';
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
      // BackButtonInterceptor.add(myInterceptor);
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
    await pacienteBloc
        .fetchPaciente(this._documento.text, this._dataNascimento.text)
        .then((pacienteModel) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //resizeToAvoidBottomPadding: false,
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: new Container(
              //CrossAxisAlignment.stretch,
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("img/passo01.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                  padding: new EdgeInsets.only(top: 200.0),
                  children: <Widget>[
                    Align(
                      //heightFactor: MediaQuery.of(context).size.height *0.0024,//MediaQuery.of(context).size.height,
                      child: Stack(
                        children: <Widget>[
                          Visibility(
                            visible: _dialogState == DialogState.DISMISSED,
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 40.0, right: 40.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'Olá! Seja bem vindo ao sistema de saúde do Município da Serra.',
                                        style: TextStyle(
                                          fontFamily: 'Humanist',
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(children: <Widget>[
                                        Text(
                                          'Documento:',
                                          style: new TextStyle(
                                              fontFamily: 'Humanist',
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        Radio(
                                          value: 0,
                                          groupValue: _tpDocumento,
                                          onChanged: _tpDocumentoChange,
                                          activeColor:
                                              Color.fromRGBO(41, 84, 142, 1),
                                        ),
                                        Text(
                                          'Cpf',
                                          style: new TextStyle(
                                              fontFamily: 'Humanist',
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        Radio(
                                          value: 1,
                                          groupValue: _tpDocumento,
                                          onChanged: _tpDocumentoChange,
                                          activeColor:
                                              Color.fromRGBO(41, 84, 142, 1),
                                        ),
                                        Text(
                                          'Cartão Sus',
                                          style: new TextStyle(
                                              fontFamily: 'Humanist',
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ]),
                                      TextField(
                                          controller: _documento,
                                          textInputAction: TextInputAction.next,
                                          onSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(focus);
                                          },
                                          maxLength: 18,
                                          decoration: new InputDecoration(
                                              counterText: '',
                                              labelText: "Digite o nº do " +
                                                  _dsDocumento,
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
                                            WhitelistingTextInputFormatter
                                                .digitsOnly,
                                            _tpDocumento == 0
                                                ? FormatarCPF()
                                                : FormatarCNS()
                                          ]),
                                      TextField(
                                          controller: _dataNascimento,
                                          focusNode: focus,
                                          onSubmitted: (v) {
                                            _getPaciente();
                                          },
                                          maxLength: 18,
                                          decoration: new InputDecoration(
                                              counterText: '',
                                              labelText: "Data de nascimento:",
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
                                            WhitelistingTextInputFormatter
                                                .digitsOnly,
                                            FormatarData()
                                          ]),
                                      RaisedButton.icon(
                                        onPressed: () {
                                          _getPaciente();
                                        },
                                        elevation: 5.0,
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15.0),
                                        ),
                                        //color: const Color.fromARGB(255, 175, 207, 45),
                                        color: Color.fromRGBO(41, 84, 142, 1)
                                            .withOpacity(0.7),
                                        icon: Icon(Icons.play_arrow,
                                            color: Colors.white70),
                                        label: Text(
                                          "",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white),
                                        ),
                                      )
                                    ])),
                          ),
                          Visibility(
                              visible: _dialogState != DialogState.DISMISSED,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    MensagemDialog(
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
                                          "Deseja se conectar ao Sistema de Saúde da Prefeitura de Serra-ES? \nVocê não é esta pessoa? Clique NÃO!",
                                      textoBtnOK: "Sim",
                                      textoBtnCancel: "Não",
                                      textoState:
                                          (this._documento.text.length == 14
                                                  ? "Localizando Cpf"
                                                  : "Localizando Catão SUS") +
                                              ":\n " +
                                              this._documento.text +
                                              "",
                                    )
                                  ])),
                        ],
                      ),
                    )
                  ]),
            )));
  }
}
