import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/ui/modulo.dart';
import 'package:gti_sesa_saude/blocs/avaliacao.bloc.dart';
import 'package:gti_sesa_saude/models/avaliacao.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';
import 'package:gti_sesa_saude/ui/principal.dart';

class Avalicacao extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  Avalicacao({
    @required this.paciente,
    @required this.pacienteId,
    @required this.moduloId,
  });
  @override
  Widget build(BuildContext context) {
    return _Avalicacao(
        paciente: this.paciente,
        pacienteId: this.pacienteId,
        moduloId: this.moduloId);
  }
}

class _Avalicacao extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;

  _Avalicacao(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});

  @override
  _AvalicacaoState createState() => _AvalicacaoState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId);
}

class _AvalicacaoState extends State<_Avalicacao> {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  String unidadeId;
  String especialidadeId;
  String atendimento;

  var _avaliacoes = [];
  final diaMesAno = DateFormat("d 'de' MMMM 'de' yyyy", "pt_BR");
  final diaSemana = DateFormat("EEEE", "pt_BR");
  final hora = DateFormat("Hm", "pt_BR");
  int _index;
  String _tpAcao;
  String _nota;
  SlideRightRoute _slideRightRoute;
  String _dialogTxtMensagem = "";
  String _dialogTxtTitulo = "";
  String _dialogTxtLoading = "";  
  String _txtCorpo = "";
  DialogState _dialogState = DialogState.DISMISSED;
  final _focusTexto = FocusNode();
  final _texto = TextEditingController();
  _AvalicacaoState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});
  @override
  void initState() {
    this._tpAcao = "Verificando";
    initializeDateFormatting("pt_BR", null);
    _index = 0;
    _txtCorpo = "";
    this._getAvaliacoes();
    super.initState();
  }

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  void _getAvaliacoes() async {
    setState(() {
      _dialogState = DialogState.LOADING;
      this._dialogTxtTitulo = "Aguarde!";     
      _dialogTxtLoading =  "Estamos localizando seus últimos atendimentos";            
    });
    AvaliacaoModel avaliacaoModel =
        await avaliacaoBloc.fetchAvaliacoes(this.pacienteId).catchError((e) {
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
    _avaliacoes = avaliacaoModel.getAvaliacoes().toList();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        if (_avaliacoes.isNotEmpty && _avaliacoes[0] != null) {
          _dialogState = DialogState.DISMISSED;
          _txtCorpo = this._avaliacoes[_index].descricao;
        } else {
          this._dialogState = DialogState.ERROR;
          this._dialogTxtTitulo = "Desculpe!";
          this._dialogTxtMensagem = "Não existem atendimentos à serem avaliados.";
        }
      });
    });
  }

  void _postAvaliacao(int nota) async {
    setState(() {
      _dialogState = DialogState.LOADING;
      this._dialogTxtTitulo = "Aguarde!";      
      _dialogTxtLoading =  "Estamos registrando sua avaliação.";      
      
    });

    MensagemModel mensagemModel = await avaliacaoBloc.pushAvaliacao(
        this.pacienteId,
        this._avaliacoes[_index].tipoAvaliacao,
        this._avaliacoes[_index].dataAtendimento,
        nota.toString(),
        _texto.text,
        "",
        this._avaliacoes[_index].numero);
    var mensagem = mensagemModel.getMensagem();
    setState(() {
      if (_index < this._avaliacoes.length - 1) {
        _index = _index + 1;
        _dialogState = DialogState.DISMISSED;
      } else {
        _dialogState = DialogState.COMPLETED;
        this._dialogTxtTitulo = "Obrigado!";
        this._dialogTxtMensagem =
            "Não existem mais atendimentos à serem avaliados.";
      }
    });
  }

  Widget _getCorpoAvalicacao() {
    return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height < 600
                ? MediaQuery.of(context).viewInsets.bottom * .5
                : 0),
        child: _avaliacoes.length == 0 ?
        Container():
        Container(
            margin: EdgeInsets.only(top: 20),
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[              
              Text(this.paciente.substring(0, paciente.indexOf(" ")) +
                      ". \nQual a sua avalição para o " +
                      this
                          ._avaliacoes[_index]
                          .descricao
                          .toString()
                          .toLowerCase() +
                      " da " +
                      this._avaliacoes[_index].nomeUnidade +                      
                      (this._avaliacoes[_index].especialidade != ""
                          ? " em consulta com " +
                              this._avaliacoes[_index].especialidade
                          : "") +                      
                      
                      "?",
                  style: AppTextStyle().getEstiloTexto(TipoTexto.DROPDOWN),
                  textAlign: TextAlign.left),
                  Text("\nAtendimento: "+ diaSemana.format(DateTime.parse(
                          this._avaliacoes[_index].dataAtendimento)) +
                      ", " +
                      diaMesAno.format(DateTime.parse(
                          this._avaliacoes[_index].dataAtendimento)) +
                      " às " +
                      hora.format(DateTime.parse(
                          this._avaliacoes[_index].dataAtendimento))+".",
                  style: AppTextStyle().getEstiloTexto(TipoTexto.LOADING),
                  textAlign: TextAlign.left),
              SizedBox(height: 10),
              TextField(
                  controller: _texto,
                  focusNode: _focusTexto,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) {
                    _focusTexto.unfocus();
                  },
                  maxLength: 140,
                  maxLines: null,
                  decoration: InputDecoration(
                    counterText: '',
                    labelText:
                        "Se preferir, digite aqui o seu elogio ou reclamação.",
                    labelStyle:
                        AppTextStyle().getEstiloTexto(TipoTexto.PLACEHOLDER),
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.35),
                  ),
                  style: AppTextStyle().getEstiloTexto(TipoTexto.PLACEHOLDER),
                  keyboardType: TextInputType.multiline)
            ])));
  }

  Widget _getRodapeAvalicacao() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 0.06;
    //return Container();
    return Expanded(
        child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
      Container(
          width: width * .20,
          //padding: EdgeInsets.only(top: 1),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: FlatButton(
                      onPressed: () => {_postAvaliacao(1)},
                      child:
                          Image.asset("img/ic_pessimo.png", height: height))),
              Text(
                "Péssimo",
                style: AppTextStyle().getEstiloTexto(TipoTexto.RODAPE),
              )
            ],
          )),
      Container(
          width: width * .20,
          //padding: EdgeInsets.only(top: 1),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: FlatButton(
                      onPressed: () => {_postAvaliacao(2)},
                      child: Image.asset("img/ic_ruim.png", height: height))),
              Text(
                "Ruim",
                style: AppTextStyle().getEstiloTexto(TipoTexto.RODAPE),
              )
            ],
          )),
      Container(
          width: width * .20,
          //padding: EdgeInsets.only(top: 1),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: FlatButton(
                      onPressed: () => {_postAvaliacao(3)},
                      child:
                          Image.asset("img/ic_regular.png", height: height))),
              Text(
                "Regular",
                style: AppTextStyle().getEstiloTexto(TipoTexto.RODAPE),
              )
            ],
          )),
      Container(
          width: width * .20,
          //padding: EdgeInsets.only(top: 1),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: FlatButton(
                      onPressed: () => {_postAvaliacao(4)},
                      child: Image.asset("img/ic_bom.png", height: height))),
              Text(
                "Bom",
                style: AppTextStyle().getEstiloTexto(TipoTexto.RODAPE),
              )
            ],
          )),
      Container(
          width: width * .20,
          //padding: EdgeInsets.only(top: 1),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: FlatButton(
                      onPressed: () => {_postAvaliacao(5)},
                      child: Image.asset("img/ic_otimo.png", height: height))),
              Text(
                "Ótimo",
                style: AppTextStyle().getEstiloTexto(TipoTexto.RODAPE),
              )
            ],
          )),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    var principal = Principal.of(context);
    principal.imagemFundo = AssetImage("img/background.png");
    principal.txtCabecalho = "";
    principal.txtCorpo = this._txtCorpo;
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoAvalicacao();
    principal.widgetRodape = _getRodapeAvalicacao();
    principal.rodapeColor =  Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85);
        //Colors.transparent; 
    principal.alturaVariada = 0.6;
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.dialogTxtBtnCancel = _dialogState == DialogState.ERROR ? "" : "";
    principal.dialogSlideRightBtnCancel = SlideRightRoute(
        builder: (_) => Principal(
            child:
                Modulos(pacienteId: this.pacienteId, paciente: this.paciente)));
    principal.dialogTxtBtnOK = _dialogState == DialogState.ERROR ? "" : "Ok";
    principal.dialogSlideRightBtnOK =
        SlideRightRoute(builder: (_) => Principal(child: Modulos(paciente: this.paciente, pacienteId: this.pacienteId )));
    principal.dialogTxtLoading = this._dialogTxtLoading;        
    principal.dialogTxtMensagem = this._dialogTxtMensagem;
    principal.dialogTxtTitulo = this._dialogTxtTitulo;

    return principal.setPrincipal();
  }
}
