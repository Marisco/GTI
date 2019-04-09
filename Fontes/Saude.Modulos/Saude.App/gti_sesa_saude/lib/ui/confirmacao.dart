import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/ui/identificacao.dart';
import 'package:gti_sesa_saude/ui/consulta.dart';
import 'package:gti_sesa_saude/blocs/consulta.bloc.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';
//import 'package:gti_sesa_saude/ui/filaVirtual.dart';
import 'package:gti_sesa_saude/blocs/filaVirtual.bloc.dart';
import 'package:gti_sesa_saude/models/filaVirtual.model.dart';
import 'package:gti_sesa_saude/ui/principal.dart';

class Confirmacao extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  final String filaVirtualId;
  Confirmacao(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId,
      @required this.especialidadeId,
      @required this.consultaId,
      @required this.filaVirtualId});
  @override
  Widget build(BuildContext context) {
    return _Confirmacao(
        paciente: this.paciente,
        pacienteId: this.pacienteId,
        moduloId: this.moduloId,
        unidadeId: this.unidadeId,
        especialidadeId: this.especialidadeId,
        consultaId: this.consultaId,
        filaVirtualId: this.filaVirtualId);
  }
}

class _Confirmacao extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  final String filaVirtualId;
  _Confirmacao(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId,
      @required this.especialidadeId,
      this.consultaId,
      @required this.filaVirtualId});

  @override
  _ConfirmacaoState createState() => _ConfirmacaoState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId,
      unidadeId: this.unidadeId,
      especialidadeId: this.especialidadeId,
      consultaId: this.consultaId,
      filaVirtualId: this.filaVirtualId);
}

class _ConfirmacaoState extends State<_Confirmacao> {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  final String filaVirtualId;
  var _consultas = [];
  final diaMesAno = DateFormat("d 'de' MMMM 'de' yyyy", "pt_BR");
  final diaSemana = DateFormat("EEEE", "pt_BR");
  final hora = DateFormat("Hm", "pt_BR");
  String _tpAcao;
  SlideRightRoute _slideRightRoute;
  String _dialogTxtMensagem = "";
  String _dialogTxtTitulo = "";
  DialogState _dialogState = DialogState.DISMISSED;
  _ConfirmacaoState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId,
      @required this.especialidadeId,
      this.consultaId,
      @required this.filaVirtualId});
  @override
  void initState() {
    this._tpAcao = "Verificando";
    initializeDateFormatting("pt_BR", null);
    if (this.filaVirtualId.isEmpty) {
      this._getConsultas();
    } else {
      this._getFilasVirtuais();
    }

    super.initState();
  }

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  void _getConsultas() async {
    setState(() => _dialogState = DialogState.LOADING);
    ConsultaModel consultaModel = await consultaBloc
        .fetchConsultas(
            this.consultaId,
            this.unidadeId,
            this.especialidadeId,
            DateTime.now().add(Duration(days: 1)).toString(),
            DateTime.now().add(Duration(days: 3)).toString())
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
    _consultas = consultaModel.getConsultas().toList();
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        if (_consultas.isNotEmpty && _consultas[0] != null) {
          _dialogState = DialogState.DISMISSED;
        } else {
          this._dialogState = DialogState.ERROR;
          this._dialogTxtTitulo = "Desculpe!";
          this._dialogTxtMensagem = "Confirmação indisponível";
        }
      });
    });
  }

  void _postConsulta() async {
    setState(() {
      _dialogState = DialogState.LOADING;
      _tpAcao = "Registrando";
      this._dialogTxtTitulo = "Aguarde!";
      this._dialogTxtMensagem = _tpAcao + " agendamento no sistema...";
    });

    MensagemModel mensagemModel =
        await consultaBloc.pushConsulta(this.pacienteId, this.consultaId);
    var mensagem = mensagemModel.getMensagem();
    setState(() {
      _dialogState = DialogState.COMPLETED;
      this._dialogTxtTitulo = "Parabéns!";
      this._dialogTxtMensagem = mensagem[0].mensagem;
    });
  }

  void _getFilasVirtuais() async {
    setState(() => _dialogState = DialogState.LOADING);
    FilaVirtualModel consultaModel = await filaVirtualBloc
        .fetchFilasVirtuais(
            this.consultaId,
            this.unidadeId,
            this.especialidadeId,
            DateTime.now().add(Duration(days: 1)).toString(),
            DateTime.now().add(Duration(days: 3)).toString())
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
    _consultas = consultaModel.getFilasVirtuais().toList();
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        if (_consultas.isNotEmpty && _consultas[0] != null) {
          _dialogState = DialogState.DISMISSED;
        } else {
          this._dialogState = DialogState.ERROR;
          this._dialogTxtTitulo = "Desculpe!";
          this._dialogTxtMensagem = "Fila indisponível";
        }
      });
    });
  }

  void _postFilaVirtual() async {
    setState(() {
      _dialogState = DialogState.LOADING;
      _tpAcao = "Registrando";
    });

    MensagemModel mensagemModel =
        await filaVirtualBloc.pushFilaVirtual(this.pacienteId, this.consultaId);
    //var mensagem = mensagemModel.getMensagem();
    setState(() {
      _dialogState = DialogState.COMPLETED;
      //_mensagem = mensagem;
    });
  }

  Widget _getCorpoConfirmacao() {
    return ListView(padding: EdgeInsets.zero, children: <Widget>[
      Text(
          (this._consultas.isEmpty
              ? ""
              : "Paciente: " +
                  this.paciente +
                  ".\nData: " +
                  diaSemana
                      .format(DateTime.parse(this._consultas[0].dataInicio)) +
                  ", " +
                  diaMesAno
                      .format(DateTime.parse(this._consultas[0].dataInicio)) +
                  ".\nHorário: " +
                  hora.format(DateTime.parse(this._consultas[0].dataInicio)) +
                  ".\nUnidade: " +
                  this._consultas[0].unidade +
                  ".\nSala/Consultório: " +
                  this._consultas[0].consultorio +
                  ".\nDr(a): " +
                  this._consultas[0].medico +
                  ".\nEspecialidade: " +
                  this._consultas[0].especialidade),
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Humanist',
              fontSize: 20,
              shadows: <Shadow>[
                Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45)),
                Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 8.0,
                    color: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45)),
              ]),
          textAlign: TextAlign.left),
    ]);
  }

  Widget _getRodapeConfirmacao() {
    return Expanded(
        child: FlatButton(
      onPressed: () {
        if (this.filaVirtualId.isEmpty) {
          this._postConsulta();
        } else {
          this._postFilaVirtual();
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        "Confirmar",
        style: AppTextStyle().getEstiloTexto(TipoTexto.BTNOK),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var principal = Principal.of(context);
    principal.imagemFundo = AssetImage("img/unidade.png");
    principal.txtCabecalho = "";
    principal.txtCorpo = _dialogState == DialogState.DISMISSED
        ? "Atenção!!!\nConfira todos os dados antes de confirmar seu agendamento!'"
        : "";
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoConfirmacao();
    principal.widgetRodape = _getRodapeConfirmacao();
    principal.rodapeColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85);
    principal.alturaVariada = 0.6;
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.dialogTxtBtnCancel = _dialogState == DialogState.ERROR ? "" : "";
    principal.dialogSlideRightBtnCancel = SlideRightRoute(
        builder: (_) => Principal(
                child: Consulta(
              pacienteId: this.pacienteId,
              paciente: this.paciente,
              moduloId: this.moduloId,
              unidadeId: this.unidadeId,
              especialidadeId: this.especialidadeId,
            )));
    principal.dialogTxtBtnOK = _dialogState == DialogState.ERROR ? "" : "Ok";
    principal.dialogSlideRightBtnOK =
        SlideRightRoute(builder: (_) => Principal(child: Identificacao()));
    principal.dialogTxtLoading = "Aguarde...";
    principal.dialogTxtMensagem = this._dialogTxtMensagem;
    principal.dialogTxtTitulo = this._dialogTxtTitulo;

    return principal.setPrincipal();
  }
}
