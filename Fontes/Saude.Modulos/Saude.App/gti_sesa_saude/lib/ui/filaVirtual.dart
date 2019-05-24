import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/blocs/filaVirtual.bloc.dart';
import 'package:gti_sesa_saude/models/filaVirtual.model.dart';
import 'package:gti_sesa_saude/ui/unidade.dart';
import 'package:gti_sesa_saude/ui/confirmacao.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/ui/principal.dart';

class FilaVirtual extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;

  FilaVirtual(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId});
  @override
  Widget build(BuildContext context) {
    return _FilaVirtual(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId,
      unidadeId: this.unidadeId,
    );
  }
}

class _FilaVirtual extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;

  _FilaVirtual({
    @required this.paciente,
    @required this.pacienteId,
    @required this.moduloId,
    @required this.unidadeId,
  });
  @override
  _FilaVirtualState createState() => _FilaVirtualState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId,
      unidadeId: this.unidadeId);
}

class _FilaVirtualState extends State<_FilaVirtual> {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;

  var _filaVirtuais = [];
  var _selFilaVirtual;
  var _selUnidadeNome;
  var _selEspecialidadeNome;
  SlideRightRoute _slideRightRoute;
  String _dialogTxtMensagem = "";
  String _dialogTxtTitulo = "";
  String _txtCorpo = "";
  DialogState _dialogState = DialogState.DISMISSED;

  _FilaVirtualState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId});
  List<RadioModel> dadosFilaVirtual = List<RadioModel>();

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    this._getFilasVirtuais();
    super.initState();
  }

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  void _getFilasVirtuais() async {
    setState(() => _dialogState = DialogState.LOADING);
    FilaVirtualModel filaVirtualModel = await filaVirtualBloc
        .fetchFilasVirtuais("0", this.unidadeId)
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
    _filaVirtuais = filaVirtualModel.getFilasVirtuais().toList();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        if (_filaVirtuais.isNotEmpty && _filaVirtuais[0] != null) {
          _dialogState = DialogState.DISMISSED;
          _txtCorpo = _filaVirtuais[0].unidade;
          _filaVirtuais.forEach((filaVirtual) => dadosFilaVirtual.add(
              RadioModel(
                  false,
                  filaVirtual.numero,
                  filaVirtual.unidade,
                  filaVirtual.especialidade,
                  filaVirtual.dataInicio,
                  filaVirtual.dataFim)));
        } else {
          this._dialogState = DialogState.ERROR;
          this._dialogTxtTitulo = "Desculpe!";
          this._dialogTxtMensagem = "Fila Virtual indisponível";
        }
      });
    });
  }

  Widget _getCorpoFilaVirtual() {
    return ListView.builder(
        itemCount: dadosFilaVirtual.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            splashColor: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45),
            onTap: () {
              setState(() {
                _selFilaVirtual = dadosFilaVirtual[index].numero;
                _selUnidadeNome = dadosFilaVirtual[index].unidade;
                _selEspecialidadeNome = dadosFilaVirtual[index].especialidade;
                dadosFilaVirtual
                    .forEach((element) => element.isSelected = false);
                dadosFilaVirtual[index].isSelected = true;
              });
            },
            child: RadioItem(dadosFilaVirtual[index]),
          );
        });
  }

  Widget _getRodapeFilaVirtual() {
    return Expanded(
        child: FlatButton(
      onPressed: () {
        Navigator.push(
            context,
            SlideRightRoute(
                builder: (_) => Principal(
                    child: Confirmacao(
                        paciente: this.paciente,
                        pacienteId: this.pacienteId,
                        moduloId: this.moduloId,
                        unidadeId: this.unidadeId,
                        especialidadeId: "",
                        filaVirtualId: this._selFilaVirtual,
                        consultaId: "",
                        unidadeNome: _selUnidadeNome,
                        especialidadeNome: _selEspecialidadeNome))));
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
    principal.idPacienteId = this.pacienteId;
    principal.imagemFundo = AssetImage("img/background.png");
    principal.txtCabecalho = "";
    principal.txtCorpo = _dialogState == DialogState.DISMISSED
        ? "Filas disponbíveis na " + _txtCorpo + "."
        : "";
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoFilaVirtual();
    principal.widgetRodape = _getRodapeFilaVirtual();
    principal.rodapeColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85);
    principal.alturaVariada = 0.6;
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.dialogTxtBtnCancel =
        _dialogState == DialogState.ERROR ? "" : "Voltar";
    principal.dialogSlideLeftBtnCancel = SlideLeftRoute(
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

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  final diaMesAno = DateFormat("d 'de' MMMM 'de' yyyy", "pt_BR");
  final diaSemana = DateFormat("EEEE", "pt_BR");
  final hora = DateFormat("Hm", "pt_BR");
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .12,
            width: MediaQuery.of(context).size.height * .12,              
            margin: EdgeInsets.only(left: 0.0),
            child: Center(
              child: Text(
                "Fila #\n" + _item.numero,
                style: TextStyle(
                    fontFamily: 'Humanist',
                    color: _item.isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
              color: _item.isSelected
                  ? Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45)
                  : Colors.transparent,
              border: Border.all(
                  width: 2.0,
                  color: _item.isSelected
                      ? Color.fromRGBO(41, 84, 142, 1).withOpacity(0.75)
                      : Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45)),
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
          ),
          Expanded(
            child: Container( 
                alignment: Alignment(-1.0, 0.0),             
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.height * .12,              
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: _item.isSelected
                      ? Colors.white.withOpacity(.4)
                      : Colors.white.withOpacity(.2),
                ),
                child: Text(
                  _item.especialidade + ".",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Humanist',
                    fontSize: 16,
                    shadows: _item.isSelected
                        ? <Shadow>[
                            Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: Colors.white.withOpacity(0.7)),
                            Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 10.0,
                                color: Colors.white.withOpacity(0.7)),
                          ]
                        : [],
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String numero;
  final String unidade;
  final String especialidade;
  final String dataInicio;
  final String dataFim;

  RadioModel(this.isSelected, this.numero, this.unidade, this.especialidade,
      this.dataInicio, this.dataFim);
}
