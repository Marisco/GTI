import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/models/disponibilidade.model.dart';
import 'package:gti_sesa_saude/blocs/disponibilidade.bloc.dart';
import 'package:gti_sesa_saude/ui/modulo.dart';
import 'package:gti_sesa_saude/ui/principal.dart';

class Disponibilidade extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  Disponibilidade(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});

  @override
  Widget build(BuildContext context) {
    return _Disponibilidade(
        paciente: this.paciente,
        pacienteId: this.pacienteId,
        moduloId: this.moduloId);
  }
}

class _Disponibilidade extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  _Disponibilidade(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});

  @override
  _DisponibilidadeState createState() => _DisponibilidadeState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      moduloId: this.moduloId);
}

class _DisponibilidadeState extends State<_Disponibilidade> {
  final String paciente;
  final String pacienteId;
  final String moduloId;
  final _medicacao = TextEditingController();
  final focusMedicacao = FocusNode();
  final focusPesquisar = FocusNode();
  var disponibilidade;
  var _disponibilidade = [];  
  String _dialogTxtMensagem;
  String _dialogTxtTitulo;
  String _txtCorpo;
  DialogState _dialogState;
  List<RadioModelD> dadosDisponibilidade = List<RadioModelD>();
  bool _visible = true;
  IconData _arrow;

  _DisponibilidadeState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.moduloId});

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    this._visible = true;
    this._arrow = Icons.keyboard_arrow_up;
    this._dialogState = DialogState.DISMISSED;
    this._dialogTxtTitulo = "";
    this._txtCorpo = "A disponibilidade do medicamento pode variar de acordo o estoque das Unidades.";
    this._dialogTxtMensagem = "";
    super.initState();
    
  }

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    _medicacao.dispose();
    super.dispose();
  }

  void _getDisponibilidades() async {
    setState(() { this._dialogState = DialogState.LOADING; } );

    DisponibilidadeModel disponibilidadeModel = await disponibilidadeBloc
        .fetchDisponibilidade(this._medicacao.text)
        .catchError((e) {
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
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _disponibilidade = disponibilidadeModel.getDisponibilidade().toList();        
        if (_disponibilidade.isNotEmpty && _disponibilidade[0] != null) {
          _dialogState = DialogState.DISMISSED;          
          _visible = false;
          _txtCorpo = "";
          _disponibilidade.forEach(
              (disponibilidade) => dadosDisponibilidade.add(RadioModelD(
                    disponibilidade.unidade,
                    disponibilidade.medicacao,
                  )));
        } else {
          this._dialogState = DialogState.ERROR;
          this._dialogTxtTitulo = "Desculpe!";
          this._dialogTxtMensagem = "Medicamento indisponível";
        }
      });
    });
  }

  Widget _getCorpoDisponibilidade() {
    return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height < 600
                ? MediaQuery.of(context).viewInsets.bottom * .5
                : 0),
        child: Container(
            margin: EdgeInsets.only(top: 20),
            child: ListView(children: <Widget>[
              Visibility(
                  visible: this._visible == null ? false : this._visible,                  
                  child: TextField(
                    controller: _medicacao,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: "Digite o nome do medicamento",
                      labelStyle:
                          AppTextStyle().getEstiloTexto(TipoTexto.PLACEHOLDER),
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      filled: true,
                      fillColor:
                          Color.fromRGBO(41, 84, 142, 1).withOpacity(0.35),
                    ),
                    style: AppTextStyle().getEstiloTexto(TipoTexto.PLACEHOLDER),
                    keyboardType: TextInputType.number,
                  )),
              Material(
                  color: Colors.transparent,
                  child: IconButton(
                      icon: Icon(_arrow, color: Colors.white70),
                      color: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          this._visible = !this._visible;
                          this._txtCorpo = !this._visible ? "" : "A disponibilidade do medicamento pode variar de acordo o estoque das Unidades.";
                          _arrow = _arrow == Icons.keyboard_arrow_up
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up;
                        });
                      })),
              Container(
                  height:  MediaQuery.of(context).size.height * 0.4,
                  padding: EdgeInsets.zero,
                  child: ListView.builder(
                      itemCount: dadosDisponibilidade.length,
                      itemBuilder: (BuildContext context, int index) {
                        InkWell(
                          splashColor:
                              Color.fromRGBO(41, 84, 142, 1).withOpacity(0.55),
                          onTap: () {
                            setState(() {
                              dadosDisponibilidade.forEach(
                                  (element) => element.isSelected = false);
                            });
                          },
                          child: RadioItemD( 
                              dadosDisponibilidade[index], 
                              index == 0
                                  ? null
                                  : dadosDisponibilidade[index - 1]),
                        );
                      }))
            ])));
  }

  Widget _getRodapeDisponibilidade() {
    return Expanded(
        child: FlatButton(
      onPressed: () {
        _getDisponibilidades();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        "Pesquisar",
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
        this._dialogState == DialogState.DISMISSED ? this._txtCorpo : "";
    principal.txtRodape = "";
    principal.txtBarraAcao = "";
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoDisponibilidade();
    principal.alturaVariada = 0.6;
    principal.widgetRodape = _getRodapeDisponibilidade();
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.rodapeColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85);
    principal.dialogTxtBtnCancel =
        _dialogState == DialogState.ERROR ? "" : "Não";
    principal.dialogSlideLeftBtnCancel = SlideLeftRoute(
        builder: (_) => Principal(
            child:
                Modulos(paciente: this.paciente, pacienteId: this.pacienteId)));
    principal.dialogTxtBtnOK = _dialogState == DialogState.ERROR ? "" : "Sim";
    principal.dialogSlideRightBtnOK = SlideRightRoute(
        builder: (_) => Principal(
                child: Modulos(
              paciente: this.paciente,
              pacienteId: this.pacienteId,
            )));
    principal.dialogTxtLoading =
        "Verificando a diponibilidade de " + this._medicacao.text + "...";
    principal.dialogTxtMensagem = this._dialogTxtMensagem;
    principal.dialogTxtTitulo = this._dialogTxtTitulo;

    return principal.setPrincipal();
  }
}

class RadioModelD {
  bool isSelected;
  final String unidade;
  final String medicacao;

  RadioModelD(this.unidade, this.medicacao);
}

class RadioItemD extends StatelessWidget {
  final RadioModelD _medicacao;
  final RadioModelD _medicacaoAnt;
  
  RadioItemD(this._medicacao, this._medicacaoAnt);

  @override
  Widget build(BuildContext context) {
    if (_medicacaoAnt == null ||
        (_medicacaoAnt.medicacao != _medicacao.medicacao)) {
      return Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                  ),
                  child: Text(
                    _medicacao.medicacao,
                    style: TextStyle(
                      color: Colors.black, // Color.fromRGBO(41, 84, 142, 1),
                      fontFamily: 'Humanist',
                      fontSize: 16,
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.white.withOpacity(0.7)),
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 10.0,
                            color: Colors.white.withOpacity(0.7)),
                      ],
                    ),
                  )),
            )
          ],
        ),
      );
    } else {
      return Container(
        color: Colors.red,
        margin: EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                  ),
                  child: Text(
                    _medicacao.unidade,
                    style: TextStyle(
                      color: Colors.black, // Color.fromRGBO(41, 84, 142, 1),
                      fontFamily: 'Humanist',
                      fontSize: 16,
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.white.withOpacity(0.7)),
                        Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 10.0,
                            color: Colors.white.withOpacity(0.7)),
                      ],
                    ),
                  )),
            )
          ],
        ),
      );
    }
  }
}
