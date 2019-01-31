import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/blocs/unidade.bloc.dart';
import 'package:gti_sesa_saude/models/unidade.model.dart';
import 'package:gti_sesa_saude/ui/passo03.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';

class Passo02 extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  Passo02({@required this.paciente, @required this.pacienteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Unidade(paciente: this.paciente, pacienteId: this.pacienteId));
  }
}

class Unidade extends StatefulWidget {
  final String paciente;
  final String pacienteId;

  Unidade({@required this.paciente, @required this.pacienteId});
  @override
  _UnidadeState createState() =>
      _UnidadeState(paciente: this.paciente, pacienteId: this.pacienteId);
}

class _UnidadeState extends State<Unidade> {
  final String paciente;
  final String pacienteId;
  var _unidades = [];
  String _selUnidade;
  _UnidadeState({@required this.paciente, @required this.pacienteId});

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this._getUnidades();
  }

  void _getUnidades() async {
    UnidadeModel unidadeModel = await unidadeBloc.fetchUnidades();
    var unidade = unidadeModel.getUnidades();
    setState(() {
      _unidades = unidade;
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
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/passo02.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Cabecalho(
                          state: DialogState.DISMISSED,
                          textoMensagem: this
                                  .paciente
                                  .substring(0, this.paciente.indexOf(" ")) +
                              ', escolha a unidade de saúde mais próxima ou a unidade de sua preferência',
                        ),
                      ]),
                      Row(children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                    child: new Theme(
                                  data: Theme.of(context).copyWith(
                                      accentColor:
                                          Color.fromRGBO(125, 108, 187, 0.75),
                                      canvasColor:
                                          Color.fromRGBO(125, 108, 187, 0.75)),
                                  child: Container(
                                      margin: EdgeInsets.all(40),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            DropdownButton(
                                              isDense: false,
                                              hint: new Text(
                                                'Escolha uma opção:',
                                                style: new TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Humanist',
                                                  fontSize: 28,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                        offset:
                                                            Offset(1.0, 1.0),
                                                        blurRadius: 3.0,
                                                        color: Colors.black
                                                            .withOpacity(0.7)),
                                                    Shadow(
                                                        offset:
                                                            Offset(1.0, 1.0),
                                                        blurRadius: 8.0,
                                                        color: Colors.black
                                                            .withOpacity(0.7)),
                                                  ],
                                                ),
                                              ),
                                              value: _selUnidade,
                                              items: _unidades.map((unidade) {
                                                return new DropdownMenuItem(
                                                  value: unidade.numero,
                                                  child: new Text(
                                                    unidade.nome,
                                                    style: new TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Humanist',
                                                      fontSize: 25,
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                            offset: Offset(
                                                                1.0, 1.0),
                                                            blurRadius: 3.0,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.7)),
                                                        Shadow(
                                                            offset: Offset(
                                                                1.0, 1.0),
                                                            blurRadius: 8.0,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.7)),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (newVal) {
                                                setState(() {
                                                  _selUnidade = newVal;
                                                });
                                              },
                                              style: new TextStyle(
                                                //color: Colors.black,
                                                fontSize: 20,
                                              ),
                                              isExpanded: true,
                                              elevation: 24,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(40),
                                                child: RaisedButton.icon(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        new SlideRightRoute(
                                                            builder: (_) => Passo03(
                                                                paciente: this
                                                                    .paciente,
                                                                pacienteId: this
                                                                    .pacienteId,
                                                                unidadeId: this
                                                                    ._selUnidade)));
                                                  },
                                                  elevation: 5.0,
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(30.0),
                                                  ),
                                                  //color: const Color.fromARGB(255, 175, 207, 45),
                                                  color: Color.fromRGBO(
                                                      125,
                                                      108,
                                                      187,
                                                      0.75), //Color.fromRGBO(41, 84, 142, 1),
                                                  icon: Icon(Icons.play_arrow,
                                                      color: Colors.white70),
                                                  label: Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontFamily: 'Humanist',
                                                        fontSize: 30,
                                                        color: Colors.white),
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
