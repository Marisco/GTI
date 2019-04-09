import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/blocs/insert.bloc.dart';
import 'package:gti_sesa_saude/models/insert.model.dart';
import 'package:gti_sesa_saude/blocs/bairro.bloc.dart';
import 'package:gti_sesa_saude/models/bairro.model.dart';
import 'package:gti_sesa_saude/src/formatacao.dart';
import 'package:gti_sesa_saude/widgets/mensagemDialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';
import 'package:gti_sesa_saude/ui/identificacao.dart';
import 'package:gti_sesa_saude/ui/modulo.dart';

class Cadastro extends StatelessWidget {
  final String documento;
  final String dataNascimento;
  Cadastro({this.documento, this.dataNascimento});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTI-SESA',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color.fromARGB(1, 41, 84, 142),
          hintColor: Colors.white),
      home: _Cadastro(
          documento: this.documento, dataNascimento: this.dataNascimento),
    );
  }
}

class _Cadastro extends StatefulWidget {
  final String documento;
  final String dataNascimento;
  _Cadastro({this.documento, this.dataNascimento});

  @override
  _CadastroState createState() => _CadastroState(
      documento: this.documento, dataNascimento: this.dataNascimento);
}

class _CadastroState extends State<_Cadastro> {
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
  String _dsErro = "";

  DialogState _dialogState;
  DateTime selectedDate = DateTime.now();

  int _tpSexo = 0;
  String _dsSexo = "Masculino";
  _CadastroState({this.documento, this.dataNascimento});

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("pt_BR", null).then((_) {
      this._dialogState = DialogState.DISMISSED;
      this._dataNascimento.text = this.dataNascimento;
      _cpf.text = this.documento.length == 14 ? this.documento : "";
      _cartaoSus.text = this.documento.length > 14 ? this.documento : "";
      this._dataNascimento.text = this.dataNascimento;
      this._getBairro();
      focusCpf.addListener(_onFocusChange);
    });
  }

  @override
  void dispose() {
    _cpf.dispose();
    _cartaoSus.dispose();
    _dataNascimento.dispose();
    super.dispose();
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
    InsertModel pacienteModel = await insertBloc
        .pushPaciente(
            this._nome.text,
            this._cpf.text,
            this._cartaoSus.text,
            this._dataNascimento.text,
            this._dsSexo.substring(0, 1),
            this._telefone.text,
            _selBairro)
        .catchError((e) {
      setState(() {
        _dialogState = DialogState.ERROR;
        _dsErro = e.message.toString().toLowerCase().contains("future")
            ? "Serviço insiponível!"
            : e.message;
      });
    });

    _paciente = pacienteModel.getInsertId();
    setState(() {
      _dialogState = DialogState.COMPLETED;
      if (_paciente.isNotEmpty) {
        paciente = this._nome.text;
        pacienteId = _paciente[0].numero.toString();
      }
    });
  }

  void _onFocusChange() {
    setState(() {
      //_height = MediaQuery.of(context).size.height * 0.40;
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
                        image: AssetImage("img/passo01.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Cabecalho(
                          txtCabecalho:
                              'Não o encotramos em nossa base de dados. Preencha o formulário abaixo.',
                          ),
                      Row(children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: MediaQuery.of(context).size.height *
                              (_dialogState != DialogState.DISMISSED
                                  ? 0.70
                                  : 0.5),
                          width: MediaQuery.of(context).size.width * .87,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromRGBO(41, 84, 142, 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                _dialogState != DialogState.DISMISSED
                                    ? MensagemDialog(
                                        // state: _dialogState,
                                        // paciente: this.paciente == null
                                        //     ? ""
                                        //     : this.paciente,
                                        // pacienteId: this.pacienteId == null
                                        //     ? ""
                                        //     : this.pacienteId,
                                        // textoTitle: this.pacienteId == null
                                        //     ? " Aguarde..."
                                        //     : " Olá " +
                                        //         this
                                        //             .paciente
                                        //             .toString()
                                        //             .substring(
                                        //                 0,
                                        //                 this
                                        //                     .paciente
                                        //                     .toString()
                                        //                     .indexOf(" ")) +
                                        //         "!",
                                        // textoMensagem:
                                        //     "Cadastro realizado com sucesso!\nDeseja se conectar ao Sistema de Saúde da Prefeitura de Serra-ES?",
                                        // textoBtnOK: "Sim",
                                        // textoBtnCancel: "Não",
                                        // textoState:
                                        //     "Registrando usuário no sistema...\n" +
                                        //         // " Nome:\n " + this._nome.text +
                                        //         " Cpf: " +
                                        //         this._cpf.text,
                                        // slideRightRouteBtnOK: SlideRightRoute(
                                        //     builder: (_) => Modulos(
                                        //           paciente: this.paciente,
                                        //           pacienteId: this.pacienteId,
                                        //         )),
                                        // slideRightRouteBtnCancel:
                                        //     SlideRightRoute(
                                        //         builder: (_) => Identificacao()),
                                        // color: Colors.transparent
                                        )
                                    : _dialogState == DialogState.ERROR
                                        ? MensagemDialog(
                                            // state: _dialogState,
                                            // paciente: "",
                                            // pacienteId: "",
                                            // textoTitle: "Desculpe!",
                                            // textoMensagem: _dsErro,
                                            // textoBtnOK: "",
                                            // textoBtnCancel: "Voltar",
                                            // textoState: "",
                                            // slideRightRouteBtnCancel:
                                            //     SlideRightRoute(
                                            //         builder: (_) => Cadastro(
                                            //             dataNascimento:
                                            //                 this.dataNascimento,
                                            //             documento:
                                            //                 this.paciente)),
                                            // color: Color.fromRGBO(
                                            //     41, 84, 142, 0.5),
                                          )
                                        : SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .5,
                                            child: ListView(
                                              children: <Widget>[
                                                Align(
                                                    child: Stack(
                                                        children: <Widget>[
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        'Sexo:',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Humanist',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 20),
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Radio(
                                                                            value:
                                                                                0,
                                                                            groupValue:
                                                                                _tpSexo,
                                                                            onChanged:
                                                                                _tpSexoChange,
                                                                            activeColor: Color.fromRGBO(
                                                                                41,
                                                                                84,
                                                                                142,
                                                                                9),
                                                                          )),
                                                                      Text(
                                                                        'Masculino',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Humanist',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 20),
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Radio(
                                                                            value:
                                                                                1,
                                                                            groupValue:
                                                                                _tpSexo,
                                                                            onChanged:
                                                                                _tpSexoChange,
                                                                            activeColor: Color.fromRGBO(
                                                                                41,
                                                                                84,
                                                                                142,
                                                                                9),
                                                                          )),
                                                                      Text(
                                                                        'Feminino',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Humanist',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 20),
                                                                      ),
                                                                    ]),
                                                                Theme(
                                                                    data: Theme.of(context).copyWith(
                                                                        accentColor: Color.fromRGBO(
                                                                            41,
                                                                            84,
                                                                            142,
                                                                            75),
                                                                        canvasColor: Color.fromRGBO(
                                                                            41,
                                                                            84,
                                                                            142,
                                                                            75)),
                                                                    child:
                                                                        DropdownButton(
                                                                      isDense:
                                                                          false,
                                                                      iconSize:
                                                                          36,
                                                                      hint:
                                                                          Text(
                                                                        'Bairro onde mora:',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Humanist',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              25,
                                                                          shadows: <
                                                                              Shadow>[
                                                                            Shadow(
                                                                                offset: Offset(1.0, 1.0),
                                                                                blurRadius: 3.0,
                                                                                color: Colors.black.withOpacity(0.7)),
                                                                            Shadow(
                                                                                offset: Offset(1.0, 1.0),
                                                                                blurRadius: 8.0,
                                                                                color: Colors.black.withOpacity(0.7)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      value:
                                                                          _selBairro,
                                                                      items: _bairros
                                                                          .map(
                                                                              (bairro) {
                                                                        return DropdownMenuItem(
                                                                          value:
                                                                              bairro.numero,
                                                                          child:
                                                                              Text(
                                                                            bairro.nome,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontFamily: 'Humanist',
                                                                              fontSize: 25,
                                                                              shadows: <Shadow>[
                                                                                Shadow(offset: Offset(1.0, 1.0), blurRadius: 3.0, color: Colors.black.withOpacity(0.7)),
                                                                                Shadow(offset: Offset(1.0, 1.0), blurRadius: 8.0, color: Colors.black.withOpacity(0.7)),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (newVal) {
                                                                        setState(
                                                                            () {
                                                                          _selBairro =
                                                                              newVal;
                                                                        });
                                                                      },
                                                                      style:
                                                                          TextStyle(
                                                                        //color: Colors.black,
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                      isExpanded:
                                                                          true,
                                                                      elevation:
                                                                          24,
                                                                    )),
                                                                TextField(
                                                                  controller:
                                                                      _nome,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  onSubmitted:
                                                                      (v) {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .requestFocus(
                                                                            focusCpf);
                                                                  },
                                                                  //maxLength: 11,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    counterText:
                                                                        '',
                                                                    labelText:
                                                                        "Nome comnpleto:",
                                                                    labelStyle:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Humanist',
                                                                      color: Colors
                                                                          .white70,
                                                                      fontSize:
                                                                          25,
                                                                    ),
                                                                  ),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Humanist',
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                ),
                                                                TextField(
                                                                    focusNode:
                                                                        focusCpf,
                                                                    controller: _cpf,
                                                                    textInputAction: TextInputAction.next,
                                                                    onSubmitted: (v) {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              focusCns);
                                                                    },
                                                                    maxLength: 14,
                                                                    decoration: InputDecoration(
                                                                      counterText:
                                                                          '',
                                                                      labelText:
                                                                          "Cpf:",
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Humanist',
                                                                        color: Colors
                                                                            .white70,
                                                                        fontSize:
                                                                            25,
                                                                      ),
                                                                    ),
                                                                    style: TextStyle(fontFamily: 'Humanist', color: Colors.white, fontSize: 20),
                                                                    keyboardType: TextInputType.number,
                                                                    inputFormatters: <TextInputFormatter>[
                                                                      WhitelistingTextInputFormatter
                                                                          .digitsOnly,
                                                                      FormatarCPF()
                                                                    ]),
                                                                TextField(
                                                                    focusNode:
                                                                        focusCns,
                                                                    controller: _cartaoSus,
                                                                    textInputAction: TextInputAction.next,
                                                                    onSubmitted: (v) {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              focusNasc);
                                                                    },
                                                                    maxLength: 18,
                                                                    decoration: InputDecoration(
                                                                        counterText: '',
                                                                        labelText: "Cartão SUS:",
                                                                        labelStyle: TextStyle(
                                                                          fontFamily:
                                                                              'Humanist',
                                                                          color:
                                                                              Colors.white70,
                                                                          fontSize:
                                                                              25,
                                                                        )),
                                                                    style: TextStyle(fontFamily: 'Humanist', color: Colors.white, fontSize: 20),
                                                                    keyboardType: TextInputType.number,
                                                                    inputFormatters: <TextInputFormatter>[
                                                                      WhitelistingTextInputFormatter
                                                                          .digitsOnly,
                                                                      FormatarCNS()
                                                                    ]),
                                                                TextField(
                                                                    controller:
                                                                        _dataNascimento,
                                                                    textInputAction: TextInputAction.next,
                                                                    focusNode: focusNasc,
                                                                    onSubmitted: (v) {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              focusTel);
                                                                    },
                                                                    maxLength: 10,
                                                                    decoration: InputDecoration(
                                                                        counterText: '',
                                                                        labelText: "Data de nascimento:",
                                                                        labelStyle: TextStyle(
                                                                          fontFamily:
                                                                              'Humanist',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              25,
                                                                        )),
                                                                    style: TextStyle(fontFamily: 'Humanist', color: Colors.white, fontSize: 20),
                                                                    keyboardType: TextInputType.datetime,
                                                                    inputFormatters: <TextInputFormatter>[
                                                                      WhitelistingTextInputFormatter
                                                                          .digitsOnly,
                                                                      FormatarData()
                                                                    ]),
                                                                TextField(
                                                                    controller:
                                                                        _telefone,
                                                                    textInputAction: TextInputAction.done,
                                                                    focusNode: focusTel,
                                                                    onSubmitted: (v) {
                                                                      _postPaciente();
                                                                    },
                                                                    maxLength: 15,
                                                                    decoration: InputDecoration(
                                                                        counterText: '',
                                                                        labelText: "Telefone com DDD:",
                                                                        labelStyle: TextStyle(
                                                                          fontFamily:
                                                                              'Humanist',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              25,
                                                                        )),
                                                                    style: TextStyle(fontFamily: 'Humanist', color: Colors.white, fontSize: 20),
                                                                    keyboardType: TextInputType.number,
                                                                    inputFormatters: <TextInputFormatter>[
                                                                      WhitelistingTextInputFormatter
                                                                          .digitsOnly,
                                                                      FormatarTelefone()
                                                                    ]),
                                                              ])),
                                                    ])),
                                              ],
                                            )),
                              ]),
                        )
                      ]),
                    ])))));
  }
}
