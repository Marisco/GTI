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
import 'package:gti_sesa_saude/ui/principal.dart';
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
  final focusNome = FocusNode();
  final focusCpf = FocusNode();
  final focusCns = FocusNode();
  final focusNasc = FocusNode();
  final focusTel = FocusNode();
  var paciente;
  var pacienteId;
  var _paciente = [];
  var _bairros = [];
  String _selBairro;
  String _dialogTxtMensagem = "";
  String _dialogTxtTitulo = "";

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
        this._dialogTxtTitulo = "Desculpe!";
        this._dialogTxtMensagem = e.message
                .toString()
                .toLowerCase()
                .contains("future")
            ? "Serviço temporariamente indisponível!\nTente novamente mais tarde."
            : e.message;
      });
    });

    _paciente = pacienteModel.getInsertId();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        this._dialogState = DialogState.COMPLETED;
        paciente = this._nome.text;
        pacienteId = _paciente[0].numero.toString();
        this._dialogTxtTitulo = " Olá " + this.paciente + "!";
        this._dialogTxtMensagem =
            "Cadastro realizado com sucesso!\nDeseja se conectar ao Sistema de Saúde da Prefeitura de Serra-ES?";
      });
    });
  }

  void _onFocusChange() {
    setState(() {
      //_height = MediaQuery.of(context).size.height * 0.40;
    });
  }

  Widget _getCorpoCadastro() {
    return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height < 600
                ? MediaQuery.of(context).viewInsets.bottom * .5
                : 0),
        child: Container(
            margin: EdgeInsets.only(top: 20),
            child: ListView(children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                    flex: 0,
                    child: Text('Sexo:',
                        style: AppTextStyle().getEstiloTexto(TipoTexto.RADIO))),
                Radio(
                  value: 0,
                  groupValue: _tpSexo,
                  onChanged: _tpSexoChange,
                  activeColor: Color.fromRGBO(41, 84, 142, 1),
                ),
                Expanded(
                    child: Text('Masculino',
                        style: AppTextStyle().getEstiloTexto(TipoTexto.RADIO))),
                Radio(
                    value: 1,
                    groupValue: _tpSexo,
                    onChanged: _tpSexoChange,
                    activeColor: Color.fromRGBO(41, 84, 142, 1)),
                Text('Femimino',
                    style: AppTextStyle().getEstiloTexto(TipoTexto.RADIO))
              ]),
              Theme(
                  data: Theme.of(context).copyWith(
                      accentColor:
                          Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45),
                      canvasColor:
                          Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            //padding: EdgeInsets.fromLTRB(0, 80, 10, 100),
                            child: DropdownButton(
                                iconSize: 36,
                                isDense: false,
                                hint: Text('Bairro onde mora:',
                                    style: AppTextStyle()
                                        .getEstiloTexto(TipoTexto.DROPDOWN)),
                                value: _selBairro,
                                items: _bairros.map((bairro) {
                                  return DropdownMenuItem(
                                      value: bairro.numero,
                                      child: Text(bairro.nome,
                                          style: AppTextStyle().getEstiloTexto(
                                              TipoTexto.DROPDOWN)));
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    _selBairro = newVal;
                                  });
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                                isExpanded: true,
                                elevation: 24)),
                        TextField(
                          controller: _nome,
                          focusNode: focusNome,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focusCpf);
                          },
                          //maxLength: 11,
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: "Nome comnpleto:",
                            labelStyle: AppTextStyle()
                                .getEstiloTexto(TipoTexto.PLACEHOLDER),
                          ),
                          style: AppTextStyle()
                              .getEstiloTexto(TipoTexto.PLACEHOLDER),
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                            focusNode: focusCpf,
                            controller: _cpf,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focusCns);
                            },
                            maxLength: 14,
                            decoration: InputDecoration(
                              counterText: '',
                              labelText: "Cpf:",
                              labelStyle: AppTextStyle()
                                  .getEstiloTexto(TipoTexto.PLACEHOLDER),
                            ),
                            style: AppTextStyle()
                                .getEstiloTexto(TipoTexto.PLACEHOLDER),
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
                              labelStyle: AppTextStyle()
                                  .getEstiloTexto(TipoTexto.PLACEHOLDER),
                            ),
                            style: AppTextStyle()
                                .getEstiloTexto(TipoTexto.PLACEHOLDER),
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
                              labelStyle: AppTextStyle()
                                  .getEstiloTexto(TipoTexto.PLACEHOLDER),
                            ),
                            style: AppTextStyle()
                                .getEstiloTexto(TipoTexto.PLACEHOLDER),
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
                            maxLength: 15,
                            onChanged: (_) {
                              if (_telefone.text.length == 15) {
                                focusTel.unfocus();
                              }
                            },
                            decoration: InputDecoration(
                                counterText: '',
                                labelText: "Telefone com DDD:",
                                labelStyle: AppTextStyle()
                                    .getEstiloTexto(TipoTexto.PLACEHOLDER)),
                            style: AppTextStyle()
                                .getEstiloTexto(TipoTexto.PLACEHOLDER),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                              FormatarTelefone()
                            ]),
                      ])),
            ])));
  }

  Widget _getRodapeCadastro() {
    return Expanded(
        child: FlatButton(
      onPressed: () {
        _postPaciente();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        "Cadastrar",
        style: AppTextStyle().getEstiloTexto(TipoTexto.BTNOK),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var principal = Principal.of(context);
    principal.imagemFundo = AssetImage("img/background.png");
    principal.txtCabecalho = "";
    principal.txtCorpo = _dialogState == DialogState.DISMISSED
        ? "Não o encotramos em nossa base de dados. Preencha o formulário abaixo."
        : "";
    principal.txtRodape = "";
    principal.txtBarraAcao = "";
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoCadastro();
    principal.alturaVariada = 0.6;
    principal.widgetRodape = _getRodapeCadastro();
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.rodapeColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85);
    principal.dialogTxtBtnCancel =
        _dialogState == DialogState.ERROR ? "" : "Não";
    principal.dialogSlideLeftBtnCancel = SlideLeftRoute(builder: (_) => Principal(child: Identificacao()));
    principal.dialogTxtBtnOK = _dialogState == DialogState.ERROR ? "" : "Sim";
    principal.dialogSlideRightBtnOK = SlideRightRoute(
        builder: (_) => Principal(
                child: Modulos(
              paciente: this.paciente,
              pacienteId: this.pacienteId,
            )));
    principal.dialogTxtLoading = "Registrando...";
    principal.dialogTxtMensagem = this._dialogTxtMensagem;
    principal.dialogTxtTitulo = this._dialogTxtTitulo;

    return principal.setPrincipal();
  }
}
