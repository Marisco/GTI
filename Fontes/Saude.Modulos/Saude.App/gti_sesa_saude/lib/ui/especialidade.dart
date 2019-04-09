import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/blocs/especialidade.bloc.dart';
import 'package:gti_sesa_saude/models/especialidade.model.dart';
import 'package:gti_sesa_saude/ui/unidade.dart';
import 'package:gti_sesa_saude/ui/consulta.dart';
import 'package:gti_sesa_saude/ui/filaVirtual.dart';
import 'package:gti_sesa_saude/ui/principal.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class Especialidade extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;

  Especialidade({
    @required this.paciente,
    @required this.pacienteId,
    @required this.moduloId,
    @required this.unidadeId,
  });

  @override
  Widget build(BuildContext context) {
    return _Especialidade(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId,
      unidadeId: this.unidadeId,
    );
  }
}

class _Especialidade extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;

  _Especialidade({
    @required this.paciente,
    @required this.pacienteId,
    @required this.moduloId,
    @required this.unidadeId,
  });
  @override
  _EspecialidadeState createState() => _EspecialidadeState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId,
      unidadeId: this.unidadeId);
}

class _EspecialidadeState extends State<_Especialidade> {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;

  var _especialidades = [];
  String _selEspecialidade;
  SlideRightRoute _slideRightRoute;
  String _dialogTxtMensagem = "";
  String _dialogTxtTitulo = "";
  DialogState _dialogState = DialogState.DISMISSED;

  _EspecialidadeState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId});

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    this._getEspecialidades();

    switch (this.moduloId) {
      case "1":
        _slideRightRoute = SlideRightRoute(
            builder: (_) => Principal(
                child: Consulta(
                    paciente: this.paciente,
                    pacienteId: this.pacienteId,
                    moduloId: this.moduloId,
                    unidadeId: this.unidadeId,
                    especialidadeId: this._selEspecialidade)));

        break;
      // case "3":
      //   _slideRightRoute = SlideRightRoute(
      //       builder: (_) => FilaVirtual(
      //           paciente: this.paciente,
      //           pacienteId: this.pacienteId,
      //           moduloId: this.moduloId,
      //           unidadeId: this.unidadeId,
      //           especialidadeId: this._selEspecialidade));

      //   break;
      default:
        _slideRightRoute = SlideRightRoute(
            builder: (_) => Principal(
                child: Consulta(
                    paciente: this.paciente,
                    pacienteId: this.pacienteId,
                    moduloId: this.moduloId,
                    unidadeId: this.unidadeId,
                    especialidadeId: this._selEspecialidade)));
    }

    super.initState();
  }

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  void _getEspecialidades() async {
    setState(() => _dialogState = DialogState.LOADING);
    EspecialidadeModel especialidadeModel = await especialidadeBloc
        .fetchEspecialidades(this.unidadeId, DateTime.now().toString(),
            DateTime.now().add(Duration(days: 4)).toString())
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
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _especialidades = especialidadeModel.getEspecialidades().toList();
        if (_especialidades.isNotEmpty && _especialidades[0] != null) {
          _dialogState = DialogState.DISMISSED;
        } else {
          this._dialogState = DialogState.ERROR;
          this._dialogTxtTitulo = "Desculpe!";
          this._dialogTxtMensagem = "Especialidade indisponível";
        }
      });
    });
  }

  Widget _getCorpoEspecilidade() {
    return Theme(
        data: Theme.of(context).copyWith(            
            accentColor: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45),
            canvasColor: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                iconSize: 36,
                isDense: false,
                hint: Text('Escolha uma opção:',
                    style: AppTextStyle().getEstiloTexto(TipoTexto.DROPDOWN)),
                value: _selEspecialidade,
                items: _especialidades.map((unidade) {
                  return DropdownMenuItem(
                    value: unidade.numero,
                    child: Text(unidade.nome,
                        style:
                            AppTextStyle().getEstiloTexto(TipoTexto.DROPDOWN)),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    _selEspecialidade = newVal;
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                isExpanded: true,
                elevation: 24,
              )
            ]));
  }

  Widget _getRodapeEspecialidade() {
    return Expanded(
        child: FlatButton(
      onPressed: () {
        Navigator.push(context, _slideRightRoute);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        "Avançar",
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
        ? "Selecione a especialidade."
        : "";
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoEspecilidade();
    principal.widgetRodape = _getRodapeEspecialidade();
    principal.rodapeColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85);
    principal.alturaVariada = 0.6;
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.dialogTxtBtnCancel =
        _dialogState == DialogState.ERROR ? "" : "Voltar";
    principal.dialogSlideRightBtnCancel = SlideRightRoute(
        builder: (_) => Principal(
            child: Unidade(
                pacienteId: this.pacienteId,
                paciente: this.paciente,
                moduloId: this.moduloId)));
    principal.dialogTxtBtnOK = _dialogState == DialogState.ERROR ? "" : "Sim";
    principal.dialogSlideRightBtnOK = _slideRightRoute;
    principal.dialogTxtLoading = "Aguarde...";
    principal.dialogTxtMensagem = this._dialogTxtMensagem;
    principal.dialogTxtTitulo = this._dialogTxtTitulo;

    return principal.setPrincipal();
  }
}
