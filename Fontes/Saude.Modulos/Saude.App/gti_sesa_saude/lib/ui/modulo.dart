import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/blocs/modulo.bloc.dart';
import 'package:gti_sesa_saude/models/modulo.model.dart';
import 'package:gti_sesa_saude/ui/identificacao.dart';
import 'package:gti_sesa_saude/ui/unidade.dart';
import 'package:gti_sesa_saude/ui/avaliacao.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';

class Modulos extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  Modulos({@required this.paciente, @required this.pacienteId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Modulos(paciente: this.paciente, pacienteId: this.pacienteId));
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
  var _selModulos;
  DialogState _dialogState;
  String _msgErro;
  _ModulosState({@required this.paciente, @required this.pacienteId});
  List<RadioModel> dadosModulos = List<RadioModel>();

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    this._msgErro = "";
    _dialogState = DialogState.DISMISSED;
    this._getModuloss();
    super.initState();
  }

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  void _getModuloss() async {
    setState(() => _dialogState = DialogState.LOADING);
    ModuloModel moduloModel = await moduloBloc.fetchModulos().catchError((e) {
      _dialogState = DialogState.ERROR;
      _msgErro = e.message.toString().toLowerCase().contains("future")
          ? "Serviço insiponível!"
          : e.message;
    });
    _modulos = moduloModel.getModulos().toList();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        if (_modulos.isNotEmpty && _modulos[0] != null) {
          _dialogState = DialogState.COMPLETED;
          _modulos.forEach((modulo) => dadosModulos
              .add(RadioModel(false, modulo.numero, modulo.nomeModulo)));
        } else {
          _dialogState = DialogState.ERROR;
          _msgErro = "Módulos indisponíveis";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onHorizontalDragStart: (_) {
                  Navigator.pop(context);
                  SlideRightRouteR(builder: (_) => Identificacao());
                },
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/passo04.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Cabecalho(
                          state: DialogState.DISMISSED,
                          textoCabecalho: 'Escolha o serviço.',
                        ),
                      ]),
                      Row(children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _dialogState == DialogState.ERROR
                                    ? SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.55,
                                        child: MensagemDialog(
                                          state: _dialogState,
                                          paciente: "",
                                          pacienteId: "",
                                          textoTitle: "Desculpe!",
                                          textoMensagem: _msgErro,
                                          textoBtnOK: "",
                                          textoBtnCancel: "Voltar",
                                          textoState: "",
                                          slideRightRouteBtnCancel:
                                              SlideRightRoute(
                                                  builder: (_) =>
                                                      Identificacao()),
                                          color: Color.fromRGBO(
                                              125, 108, 187, 0.75),
                                        ))
                                    : SizedBox(
                                        child: Theme(
                                        data: Theme.of(context).copyWith(
                                            accentColor: Color.fromRGBO(
                                                189, 112, 162, 0.75),
                                            canvasColor: Color.fromRGBO(
                                                189, 112, 162, 0.75)),
                                        child: Container(
                                            margin: EdgeInsets.all(20),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              (_dialogState ==
                                                                      DialogState
                                                                          .LOADING
                                                                  ? 0.06
                                                                  : 0.5),
                                                      child: Theme(
                                                          data: Theme.of(context).copyWith(
                                                              accentColor:
                                                                  Color.fromRGBO(
                                                                      189,
                                                                      112,
                                                                      162,
                                                                      0.75),
                                                              canvasColor:
                                                                  Colors.black),
                                                          child:
                                                              _dialogState !=
                                                                      DialogState
                                                                          .LOADING
                                                                  ? ListView
                                                                      .builder(
                                                                      itemCount:
                                                                          dadosModulos
                                                                              .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return InkWell(
                                                                          splashColor: Color.fromRGBO(
                                                                              189,
                                                                              112,
                                                                              162,
                                                                              0.75),
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              _selModulos = dadosModulos[index].numero;
                                                                              dadosModulos.forEach((element) => element.isSelected = false);
                                                                              dadosModulos[index].isSelected = true;
                                                                            });
                                                                          },
                                                                          child:
                                                                              RadioItem(dadosModulos[index]),
                                                                        );
                                                                      },
                                                                    )
                                                                  : CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<Color>(
                                                                              Colors.white)))),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: RaisedButton.icon(
                                                        onPressed:
                                                            _dialogState ==
                                                                    DialogState
                                                                        .LOADING
                                                                ? null
                                                                : () {
                                                                    // if (this._selModulos !=
                                                                    //     "1") {
                                                                    //   Navigator.push(
                                                                    //       context,
                                                                    //       SlideRightRoute(
                                                                    //           builder: (_) => Unidade(paciente: this.paciente, pacienteId: this.pacienteId, moduloId: this._selModulos)));
                                                                    // } else {
                                                                    //   Navigator.push(
                                                                    //       context,
                                                                    //       SlideRightRoute(
                                                                    //           builder: (_) => Avaliacao(
                                                                    //                 paciente: this.paciente,
                                                                    //                 pacienteId: this.pacienteId,
                                                                    //                 moduloId: this._selModulos,
                                                                    //                 unidadeId: "",
                                                                    //               )));
                                                                    // }
                                                                    SlideRightRoute(
                                                                               builder: (_) => Unidade(paciente: this.paciente, pacienteId: this.pacienteId, moduloId: this._selModulos));
                                                                  },

                                                        elevation: 5.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                        ),
                                                        color: _dialogState ==
                                                                DialogState
                                                                    .LOADING
                                                            ? Colors.grey
                                                                .withOpacity(
                                                                    0.75)
                                                            : Color.fromRGBO(
                                                                189,
                                                                112,
                                                                162,
                                                                0.75), //Color.fromRGBO(41, 84, 142, 1),
                                                        icon: Icon(
                                                            Icons.play_arrow,
                                                            color:
                                                                Colors.white70),
                                                        label: Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Humanist',
                                                              fontSize: 30,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )),
                                                ])),
                                      ))
                              ],
                            )),
                      ])
                    ])))));
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
            height: 100.0,
            width: 100.0,
            margin: EdgeInsets.only(left: 0.0),
            child: Center(
              child: Text(_item.numero,
                  style: TextStyle(
                      fontFamily: 'Humanist',
                      color: _item.isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: BoxDecoration(
              color: _item.isSelected
                  ? Color.fromRGBO(189, 112, 162, 0.75)
                  : Colors.transparent,
              border: Border.all(
                  width: 2.0,
                  color: _item.isSelected
                      ? Color.fromRGBO(189, 112, 162, 0.75)
                      : Color.fromRGBO(189, 112, 162, 0.75)),
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  _item.nomeModulo + ".",
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
                                blurRadius: 8.0,
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
  final String nomeModulo;

  RadioModel(this.isSelected, this.numero, this.nomeModulo);
}
