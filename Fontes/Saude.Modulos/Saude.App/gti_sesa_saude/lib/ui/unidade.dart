import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/blocs/unidade.bloc.dart';
import 'package:gti_sesa_saude/models/unidade.model.dart';
import 'package:gti_sesa_saude/ui/identificacao.dart';
import 'package:gti_sesa_saude/ui/modulo.dart';
import 'package:gti_sesa_saude/ui/especialidade.dart';
import 'package:gti_sesa_saude/ui/avaliacao.dart';
import 'package:gti_sesa_saude/ui/principal.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class Unidade extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  Unidade(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});

  @override
  Widget build(BuildContext context) {
    return _Unidade(
        paciente: this.paciente,
        pacienteId: this.pacienteId,
        moduloId: this.moduloId);
  }
}

class _Unidade extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;

  _Unidade(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});
  @override
  _UnidadeState createState() => _UnidadeState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId);
}

class _UnidadeState extends State<_Unidade> {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  String _dialogTxtMensagem = "";
  String _dialogTxtTitulo = "";
  DialogState _dialogState = DialogState.DISMISSED;
  SlideRightRoute _slideRightRoute;  
  String _selUnidade;
  var _unidades = [];

  _UnidadeState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  void initState() {    
    this._getUnidades();
    switch (this.moduloId) {
      case "1":
        _slideRightRoute = SlideRightRoute(
            builder: (_) => Principal(
                child: Especialidade(
                    paciente: this.paciente,
                    pacienteId: this.pacienteId,
                    moduloId: this.moduloId,
                    unidadeId: this._selUnidade)));

        break;
      // case "2":
      //   _slideRightRoute = SlideRightRoute(
      //       builder: (_) => Avaliacao(
      //           paciente: this.paciente,
      //           pacienteId: this.pacienteId,
      //           moduloId: this.moduloId,
      //           unidadeId: this._selUnidade));

      //   break;
      case "2":
       _slideRightRoute = SlideRightRoute(
            builder: (_) => Principal(
                child: Especialidade(
                    paciente: this.paciente,
                    pacienteId: this.pacienteId,
                    moduloId: this.moduloId,
                    unidadeId: this._selUnidade)));

        break;
      default:
       _slideRightRoute = SlideRightRoute(
            builder: (_) => Principal(
                child: Especialidade(
                    paciente: this.paciente,
                    pacienteId: this.pacienteId,
                    moduloId: this.moduloId,
                    unidadeId: this._selUnidade)));
    }

    super.initState();
  }

  void _getUnidades() async {
    setState(() => _dialogState = DialogState.LOADING);
    UnidadeModel unidadeModel =
        await unidadeBloc.fetchUnidades().catchError((e) {
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
        _unidades = unidadeModel.getUnidades().toList();
        if (_unidades.isNotEmpty && _unidades[0] != null) {
          _dialogState = DialogState.DISMISSED;
        } else {
          _dialogState = DialogState.ERROR;
          _dialogTxtTitulo = "Desculpe!";
          _dialogTxtMensagem = "Unidades indisponíveis";
        }
      });
    });
  }

  Widget _getCorpoUnidade() {
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
                value: _selUnidade,
                items: _unidades.map((unidade) {
                  return DropdownMenuItem(
                    value: unidade.numero,
                    child: Text(unidade.nome,
                        style:
                            AppTextStyle().getEstiloTexto(TipoTexto.DROPDOWN)),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    _selUnidade = newVal;
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

  Widget _getRodapeUnidade() {
    return Expanded(
        child: FlatButton(
      onPressed: () {
        //Navigator.pop(context);
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
        ? "Selecione a unidade de saúde."
        : "";
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoUnidade();
    principal.widgetRodape = _getRodapeUnidade();
    principal.rodapeColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85);
    principal.alturaVariada = 0.6;
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.dialogTxtBtnCancel =
        _dialogState == DialogState.ERROR ? "" : "Voltar";
    principal.dialogSlideRightBtnCancel = SlideRightRoute(
        builder: (_) => Principal(
            child:
                Modulos(pacienteId: this.pacienteId, paciente: this.paciente)));
    principal.dialogTxtBtnOK = _dialogState == DialogState.ERROR ? "" : "Sim";
    principal.dialogSlideRightBtnOK = _slideRightRoute;
    principal.dialogTxtLoading = "Aguarde...";
    principal.dialogTxtMensagem = this._dialogTxtMensagem;
    principal.dialogTxtTitulo = this._dialogTxtTitulo;

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: principal.setPrincipal());
  }
}
