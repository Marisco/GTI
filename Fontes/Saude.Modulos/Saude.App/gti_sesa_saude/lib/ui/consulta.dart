import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/blocs/consulta.bloc.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/ui/especialidade.dart';
import 'package:gti_sesa_saude/ui/confirmacao.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/ui/principal.dart';

class Consulta extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;
  final String especialidadeId;

  Consulta(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId,
      @required this.especialidadeId});
  @override
  Widget build(BuildContext context) {
    return _Consulta(
        paciente: this.paciente,
        pacienteId: this.pacienteId,
        moduloId: this.moduloId,
        unidadeId: this.unidadeId,
        especialidadeId: this.especialidadeId);
  }
}

class _Consulta extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;
  final String especialidadeId;

  _Consulta(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId,
      @required this.especialidadeId});
  @override
  _ConsultaState createState() => _ConsultaState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId,
      unidadeId: this.unidadeId,
      especialidadeId: this.especialidadeId);
}

class _ConsultaState extends State<_Consulta> {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final String unidadeId;
  final String especialidadeId;

  var _consultas = [];
  var _selConsulta;
  SlideRightRoute _slideRightRoute;
  String _dialogTxtMensagem = "";
  String _dialogTxtTitulo = "";
  DialogState _dialogState = DialogState.DISMISSED;

  _ConsultaState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId,
      @required this.unidadeId,
      @required this.especialidadeId});
  List<RadioModel> dadosConsulta = List<RadioModel>();

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    this._getConsultas();
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
            "0",
            this.unidadeId,
            this.especialidadeId,
            DateTime.now().add(Duration(days: 1)).toString(),
            DateTime.now().add(Duration(days: 7)).toString())
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
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        if (_consultas.isNotEmpty && _consultas[0] != null) {
          _dialogState = DialogState.DISMISSED;
          _consultas.forEach((consulta) => dadosConsulta.add(RadioModel(
              false,
              consulta.numero,
              consulta.consultorio,
              consulta.especialidade,
              consulta.medico,
              consulta.dataInicio,
              consulta.dataFim)));
        } else {
          this._dialogState = DialogState.ERROR;
          this._dialogTxtTitulo = "Desculpe!";
          this._dialogTxtMensagem = "Consulta indisponível";
        }
      });
    });
  }

  Widget _getCorpoConsulta() {
    return ListView.builder(
        itemCount: dadosConsulta.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            splashColor: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.55),
            onTap: () {
              setState(() {
                _selConsulta = dadosConsulta[index].numero;
                dadosConsulta.forEach((element) => element.isSelected = false);
                dadosConsulta[index].isSelected = true;
              });
            },
            child: RadioItem(dadosConsulta[index]),
          );
        });
  }

  Widget _getRodapeConsulta() {
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
                      especialidadeId: this.especialidadeId,
                      consultaId: this._selConsulta,
                      filaVirtualId: "",
                      especialidadeNome: "",
                      unidadeNome: "",
                    ))));
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
    principal.txtCorpo =
        _dialogState == DialogState.DISMISSED ? "Selecione o horário" : "";
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoConsulta();
    principal.widgetRodape = _getRodapeConsulta();
    principal.rodapeColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85);
    principal.alturaVariada = 0.6;
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.dialogTxtBtnCancel =
        _dialogState == DialogState.ERROR ? "" : "Voltar";
    principal.dialogSlideLeftBtnCancel = SlideLeftRoute(
        builder: (_) => Principal(
            child: Especialidade(
                pacienteId: this.pacienteId,
                paciente: this.paciente,
                moduloId: this.moduloId,
                unidadeId: this.unidadeId)));
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
            height: MediaQuery.of(context).size.height * .12, // 86.0,
            width: MediaQuery.of(context).size.height * .12, // 86.0,
            margin: EdgeInsets.only(left: 0.0),
            child: Center(
              child: Text(hora.format(DateTime.parse(_item.dataInicio)),
                  style: TextStyle(
                      fontFamily: 'Humanist',
                      color: _item.isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
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
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: _item.isSelected
                      ? Colors.white.withOpacity(.4)
                      : Colors.white.withOpacity(.2),
                ),
                child: Text(
                  diaSemana
                          .format(DateTime.parse(_item.dataInicio))
                          .toString()
                          .toUpperCase() +
                      "\n" +
                      diaMesAno.format(DateTime.parse(_item.dataInicio)) +
                      "." +
                      "\nSala: " +
                      _item.consultorio +
                      "." +
                      //"\nDr(a): " +
                      //_item.medico +
                      //"." +
                      "\nEsp.: " +
                      _item.especialidade +
                      ".",
                  style: TextStyle(
                    color: Colors.black, // Color.fromRGBO(41, 84, 142, 1),
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
  final String consultorio;
  final String especialidade;
  final String medico;
  final String dataInicio;
  final String dataFim;

  RadioModel(this.isSelected, this.numero, this.consultorio, this.especialidade,
      this.medico, this.dataInicio, this.dataFim);
}
