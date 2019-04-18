import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/blocs/modulo.bloc.dart';
import 'package:gti_sesa_saude/models/modulo.model.dart';
import 'package:gti_sesa_saude/models/radioModel.dart';
import 'package:gti_sesa_saude/ui/identificacao.dart';
import 'package:gti_sesa_saude/ui/unidade.dart';
import 'package:gti_sesa_saude/ui/avaliacao.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/ui/principal.dart';

class Modulos extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  Modulos({@required this.paciente, @required this.pacienteId});
  @override
  Widget build(BuildContext context) {
    return _Modulos(paciente: this.paciente, pacienteId: this.pacienteId);
  }
}

class _Modulos extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  _Modulos({@required this.paciente, @required this.pacienteId});
  @override
  _ModulosState createState() => _ModulosState(
        paciente: this.paciente,
        pacienteId: this.pacienteId,
      );
}

class _ModulosState extends State<_Modulos> {
  final String paciente;
  final String pacienteId;
  var _modulos = [];
  String _dialogTxtMensagem;
  String _dialogTxtTitulo;
  DialogState _dialogState;

  _ModulosState({@required this.paciente, @required this.pacienteId});
  List<RadioModel> dadosModulos = List<RadioModel>();

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    _dialogState = DialogState.DISMISSED;
    _dialogTxtTitulo = "";
    _dialogTxtMensagem = "";
    this._getModuloss();
    super.initState();
  }

  @override
  void dispose() {
    this._dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  void _getModuloss() async {
    setState(() => _dialogState = DialogState.LOADING);
    ModuloModel moduloModel = await moduloBloc.fetchModulos().catchError((e) {
      setState(() {
        this._dialogState = DialogState.ERROR;
        this._dialogTxtTitulo = "Desculpe!";
        this._dialogTxtMensagem = e.message
                .toString()
                .toLowerCase()
                .contains("future")
            ? "Serviço temporariamente indisponível!\nTente novamente mais tarde."
            : e.message;
      });
    });
    _modulos = moduloModel.getModulos().toList();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        if (_modulos.isNotEmpty && _modulos[0] != null) {
          _dialogState = DialogState.DISMISSED;
          _modulos.forEach((modulo) => dadosModulos
              .add(RadioModel(false, modulo.numero, modulo.nomeModulo)));
        } else {
          this._dialogState = DialogState.ERROR;
          this._dialogTxtTitulo = "Desculpe!";
          this._dialogTxtMensagem = "Módulos indisponíveis";
        }
      });
    });
  }

  Card makeCard(BuildContext context, int index) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(113, 138, 200, 1).withOpacity(0.85),
          Color.fromRGBO(43, 144, 183, 1)
        ])),
        child: makeListTile(context, index),
      ),
    );
  }

  getImagemModulo(String modulo) {
    switch (modulo) {
      case "1":
        return "img/ic_agendamento.png";
        break;
      case "2":
        return "img/ic_avaliacao.png";
        break;
      case "3":
        return "img/ic_fila.png";
        break;
      default:
        return "img/ic_agendamento.png";
    }
  }

  SlideRightRoute getRotaModulo(String modulo) {
    switch (modulo) {
      case "1":
        return SlideRightRoute(
            builder: (_) => Principal(
                child: Unidade(
                    pacienteId: this.pacienteId,
                    paciente: this.paciente,
                    moduloId: modulo)));
        break;
      case "2":
        return SlideRightRoute(
            builder: (_) => Principal(
                child: Avalicacao(
                    pacienteId: this.pacienteId,
                    paciente: this.paciente,
                    moduloId: modulo)));
        break;
      case "3":
        return SlideRightRoute(
            builder: (_) => Principal(
                child: Unidade(
                    pacienteId: this.pacienteId,
                    paciente: this.paciente,
                    moduloId: modulo)));
        break;
      default:
        return SlideRightRoute(
            builder: (_) => Principal(
                child: Unidade(
                    pacienteId: this.pacienteId,
                    paciente: this.paciente,
                    moduloId: modulo)));
    }
  }

  Widget makeListTile(BuildContext context, int index) {
    return ListTile(
        onTap: () {
          Navigator.push(context, getRotaModulo(dadosModulos[index].numero));
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        leading: Container(
            padding: EdgeInsets.only(right: 15.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Image.asset(getImagemModulo(dadosModulos[index].numero),
                height: MediaQuery.of(context).size.height * 0.08)),
        title: Text(
          dadosModulos[index].descricao,
          style: AppTextStyle().getEstiloTexto(TipoTexto.PLACEHOLDER),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.arrow_forward, color: Colors.white24),
            Text(" Descricao", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right,
            color: Colors.white.withOpacity(0.75), size: 30.0));
  }

  _getCorpoModulo() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dadosModulos.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(context, index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var principal = Principal.of(context);
    principal.idPacienteId = this.pacienteId;
    principal.imagemFundo = AssetImage("img/background.png");
    principal.txtCabecalho = "";
    principal.txtCorpo = _dialogState == DialogState.DISMISSED ? "" : "";
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoModulo();
    principal.alturaVariada = 0.7;
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.dialogTxtBtnCancel =
        _dialogState == DialogState.ERROR ? "" : "Voltar";
    principal.dialogSlideLeftBtnCancel =
        SlideLeftRoute(builder: (_) => Principal(child: Identificacao()));
    principal.dialogTxtBtnOK = _dialogState == DialogState.ERROR ? "" : "Sim";
    principal.dialogSlideRightBtnOK = SlideRightRoute(
        builder: (_) => Principal(
                child: Modulos(
              paciente: this.paciente,
              pacienteId: this.pacienteId,
            )));
    principal.dialogTxtLoading = "Aguarde...";
    principal.dialogTxtMensagem = this._dialogTxtMensagem;
    principal.dialogTxtTitulo = this._dialogTxtTitulo;
    return principal.setPrincipal();
  }
}
