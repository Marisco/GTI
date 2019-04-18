import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/ui/cadastro.dart';
import 'package:gti_sesa_saude/models/paciente.model.dart';
import 'package:gti_sesa_saude/blocs/paciente.bloc.dart';
import 'package:gti_sesa_saude/src/formatacao.dart';
import 'package:gti_sesa_saude/ui/modulo.dart';
import 'package:gti_sesa_saude/ui/principal.dart';

class Identificacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Identificacao();
  }
}

class _Identificacao extends StatefulWidget {
  @override
  _IdentificacaoState createState() => _IdentificacaoState();
}

class _IdentificacaoState extends State<_Identificacao> {
  final _documento = TextEditingController();
  final _dataNascimento = TextEditingController();
  final focusDocumento = FocusNode();
  final focusDataNascimento = FocusNode();
  final btnEntrar = FocusNode();
  int _tpDocumento = 1;
  var paciente;
  var pacienteId;
  var _paciente = [];
  var _maxLength;
  DateTime selectedDate = DateTime.now();
  String _dsDocumento;
  String _dialogTxtMensagem;
  String _dialogTxtTitulo;
  DialogState _dialogState;

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    _tpDocumentoChange(0);    
    this._dialogState = DialogState.DISMISSED;        
    _dialogTxtTitulo = "";
    _dialogTxtMensagem = "";    
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
      _maxLength = _tpDocumento == 0 ? 14 : 18;
      switch (_tpDocumento) {
        case 0:
          _dsDocumento = "CPF:";
          break;
        case 1:
          _dsDocumento = "CNS:";
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
        this._dialogTxtTitulo = "Desculpe!";
        this._dialogTxtMensagem = e.message
                .toString()
                .toLowerCase()
                .contains("future")
            ? "Serviço temporariamente indisponível!\nTente novamente mais tarde."
            : e.message;
      });
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _paciente = [pacienteModel.getPaciente()];
        if (_paciente.isNotEmpty && _paciente[0] != null) {
          paciente = _paciente[0].nome;
          pacienteId = _paciente[0].numero.toString();
          this._dialogState = DialogState.COMPLETED;
          this._dialogTxtTitulo = " Olá " + this.paciente + "!";
          this._dialogTxtMensagem =
              "Deseja se conectar ao Sistema de Saúde da Prefeitura de Serra-ES? \nClique NÃO se você não é esta pessoa!";
        } else {  
          this._dialogState = DialogState.DISMISSED;        
          Navigator.push(
              context,
              SlideRightRoute(
                  builder: (_) => Principal(child: Cadastro(
                      documento: this._documento.text,
                      dataNascimento: this._dataNascimento.text))));
        }
      });
    });
  }

  Widget _getCorpoIdentificacao() {
    return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height < 600
                ? MediaQuery.of(context).viewInsets.bottom * .5
                : 0),
        child: Container(
            margin: EdgeInsets.only(top: 20),
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                    flex: 0,
                    child: Text('Documento:',
                        style: AppTextStyle().getEstiloTexto(TipoTexto.RADIO))),
                Radio(
                  value: 0,
                  groupValue: _tpDocumento,
                  onChanged: _tpDocumentoChange,
                  activeColor: Color.fromRGBO(41, 84, 142, 1),
                ),
                Expanded(
                    child: Text('Cpf',
                        style: AppTextStyle().getEstiloTexto(TipoTexto.RADIO))),
                Radio(
                  value: 1,
                  groupValue: _tpDocumento,
                  onChanged: _tpDocumentoChange,
                  activeColor: Color.fromRGBO(41, 84, 142, 1),
                ),
                Text('Cartão Sus',
                    style: AppTextStyle().getEstiloTexto(TipoTexto.RADIO)),
              ]),
              TextField(
                  controller: _documento,
                  textInputAction: TextInputAction.next,                  
                  onChanged: (_){
                    if(_documento.text.length == _maxLength){
                      FocusScope.of(context).requestFocus(focusDataNascimento);
                    }
                  },
                  maxLength: _maxLength,
                  decoration: InputDecoration(
                    counterText: '',
                    labelText: "Digite o nº do " + _dsDocumento,
                    labelStyle:
                        AppTextStyle().getEstiloTexto(TipoTexto.PLACEHOLDER),
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.35),
                  ),
                  style: AppTextStyle().getEstiloTexto(TipoTexto.PLACEHOLDER),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                    _tpDocumento == 0 ? FormatarCPF() : FormatarCNS()
                  ]),
              SizedBox(height: 10),
              TextField(
                  controller: _dataNascimento,
                  focusNode: focusDataNascimento,
                  textInputAction: TextInputAction.done,
                   onChanged: (_){
                    if(_dataNascimento.text.length == 10){
                      focusDataNascimento.unfocus();
                    }
                  },
                  maxLength: 10,
                  decoration: InputDecoration(
                    counterText: '',
                    labelText: "Data de nascimento:",
                    labelStyle:
                        AppTextStyle().getEstiloTexto(TipoTexto.PLACEHOLDER),
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.35),
                  ),
                  style: AppTextStyle().getEstiloTexto(TipoTexto.PLACEHOLDER),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                    FormatarData()
                  ])
            ])));
  }

  Widget _getRodapeIdentificacao() {
    return Expanded(
        child: FlatButton(
      onPressed: () {
        _getPaciente();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        "Entrar",
        style: AppTextStyle().getEstiloTexto(TipoTexto.BTNOK),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var principal = Principal.of(context);
    principal.idPacienteId = this.pacienteId;
    principal.imagemFundo = AssetImage("img/background.png");
    principal.txtCabecalho = "";
    principal.txtCorpo = this._dialogState == DialogState.DISMISSED
        ? "Olá! Seja bem vindo ao Aplicativo Saúde-Serra."
        : "";
    principal.txtRodape = "";
    principal.txtBarraAcao = "";
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoIdentificacao();
    principal.alturaVariada = 0.6;
    principal.widgetRodape = _getRodapeIdentificacao();
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.rodapeColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85);
    principal.dialogTxtBtnCancel =
        _dialogState == DialogState.ERROR ? "" : "Não";
    principal.dialogSlideLeftBtnCancel =
        SlideLeftRoute(builder: (_) => Principal(child: Identificacao()));
    principal.dialogTxtBtnOK = _dialogState == DialogState.ERROR ? "" : "Sim";
    principal.dialogSlideRightBtnOK = SlideRightRoute(
        builder: (_) => Principal(
                child: Modulos(
              paciente: this.paciente,
              pacienteId: this.pacienteId,
            )));
    principal.dialogTxtLoading =
        "Localizando " + this._dsDocumento + "\n" + this._documento.text;
    principal.dialogTxtMensagem = this._dialogTxtMensagem;
    principal.dialogTxtTitulo = this._dialogTxtTitulo;

    return principal.setPrincipal();
  }
}
