import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/blocs/especialidade.bloc.dart';
import 'package:gti_sesa_saude/models/especialidade.model.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/ui/passo04.dart';

class Passo03 extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  Passo03({@required this.paciente, @required this.pacienteId, @required this.unidadeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Especialidade(
            paciente: this.paciente, pacienteId: this.pacienteId, unidadeId: this.unidadeId));
  }
}

class Especialidade extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  Especialidade(
      {@required this.paciente, @required this.pacienteId, @required this.unidadeId});
  @override
  _EspecialidadeState createState() => _EspecialidadeState(
      paciente: this.paciente, pacienteId: this.pacienteId, unidadeId: this.unidadeId);
}

class _EspecialidadeState extends State<Especialidade> {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  var _especialidades = [];
  String _selEspecialidade;
  _EspecialidadeState(
      {@required this.paciente, @required this.pacienteId, @required this.unidadeId});

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
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Passo 3"),
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            new Image.asset(
              "img/logo_icon.png",
              width: 50,
            )
          ]),
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("img/passo03.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Expanded(
                flex: 6,
                child: new Theme(
                  data: Theme.of(context)
                      .copyWith(canvasColor: Colors.cyan.withOpacity(0.7)),
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Text(
                          'Escolha a especialidade médica disponível',
                          style: TextStyle(
                            fontFamily: 'Humanist',
                            color: Colors.white,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Expanded(
                            flex: 0,
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: DropdownButton(
                                  hint: new Text(
                                    'Escolha uma opção:',
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Humanist',
                                      fontSize: 28,
                                      shadows: <Shadow>[
                                        Shadow(
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 3.0,
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                        Shadow(
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 8.0,
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                      ],
                                    ),
                                  ),
                                  value: _selEspecialidade,
                                  items: _especialidades.map((especiliadade) {
                                    return new DropdownMenuItem(
                                      value: especiliadade.numero,
                                      child: new Text(
                                        especiliadade.nome,
                                        style: new TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Humanist',
                                          fontSize: 25,
                                          shadows: <Shadow>[
                                            Shadow(
                                                offset: Offset(1.0, 1.0),
                                                blurRadius: 3.0,
                                                color: Colors.black
                                                    .withOpacity(0.7)),
                                            Shadow(
                                                offset: Offset(1.0, 1.0),
                                                blurRadius: 8.0,
                                                color: Colors.black
                                                    .withOpacity(0.7)),
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
                                    //color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  isExpanded: true,
                                  elevation: 5,
                                ))),
                        Text(
                          '',
                          style: TextStyle(
                            fontFamily: 'Humanist',
                            color: Colors.white,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        RaisedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                new SlideRightRoute(
                                    builder: (_) => Passo04(
                                        paciente: this.paciente,
                                        pacienteId: this.pacienteId,
                                        unidadeId: this.unidadeId,
                                        especialidadeId:
                                            this._selEspecialidade)));
                          },
                          elevation: 5.0,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          
                          color: Colors.cyan.withOpacity(0.7),
                          icon: Icon(Icons.play_arrow, color: Colors.white70),
                          label: Text(
                            "",
                            style: TextStyle(
                                fontFamily: 'Humanist',
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        ),
                      ])),
                )),
            Expanded(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
