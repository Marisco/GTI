import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/blocs/especialidade.bloc.dart';
import 'package:gti_sesa_saude/models/especialidade.model.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/ui/passo04.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';

class Passo03 extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  Passo03(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Especialidade(
            paciente: this.paciente,
            pacienteId: this.pacienteId,
            unidadeId: this.unidadeId));
  }
}

class Especialidade extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  Especialidade(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId});
  @override
  _EspecialidadeState createState() => _EspecialidadeState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      unidadeId: this.unidadeId);
}

class _EspecialidadeState extends State<Especialidade> {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  var _especialidades = [];
  String _selEspecialidade;
  _EspecialidadeState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId});

  @override
  void initState() {
    super.initState();
    this._getEspecialidades();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getEspecialidades() async {
    EspecialidadeModel especialidadeModel =
        await especialidadeBloc.fetchEspecialidades(
            this.unidadeId,
            DateTime.now().toString(),
            DateTime.now().add(new Duration(days: 2)).toString());
    var especialidade = especialidadeModel.getEspecialidades();
    setState(() {
      _especialidades = especialidade;
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
                        image: AssetImage("img/passo03.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Cabecalho(
                          state: DialogState.DISMISSED,
                          textoMensagem:
                              'Agora, escolha a especialidade médica disponível',
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
                                          Color.fromRGBO(63, 157, 184, 0.75),
                                      canvasColor:
                                          Color.fromRGBO(63, 157, 184, 0.75)),
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
                                              value: _selEspecialidade,
                                              items: _especialidades
                                                  .map((unidade) {
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
                                                  _selEspecialidade = newVal;
                                                });
                                              },
                                              style: new TextStyle(
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
                                                            builder: (_) => Passo04(
                                                                paciente: this
                                                                    .paciente,
                                                                pacienteId: this
                                                                    .pacienteId,
                                                                unidadeId: this
                                                                    .unidadeId,
                                                                especialidadeId:
                                                                    this._selEspecialidade)));
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
                                                      63,
                                                      157,
                                                      184,
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
