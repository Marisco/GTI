import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/ui/passo01.dart';
import 'package:gti_sesa_saude/blocs/consulta.bloc.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';

class Passo05 extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  Passo05(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId,
      @required this.especialidadeId,
      this.consultaId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Confirmacao(
            paciente: this.paciente,
            pacienteId: this.pacienteId,
            unidadeId: this.unidadeId,
            especialidadeId: this.especialidadeId,
            consultaId: this.consultaId));
  }
}

class Confirmacao extends StatefulWidget {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  Confirmacao(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId,
      @required this.especialidadeId,
      this.consultaId});

  @override
  _ConfirmacaoState createState() => _ConfirmacaoState(
      paciente: this.paciente,
      pacienteId: this.pacienteId,
      unidadeId: this.unidadeId,
      especialidadeId: this.especialidadeId,
      consultaId: this.consultaId);
}

class _ConfirmacaoState extends State<Confirmacao> {
  final String paciente;
  final String pacienteId;
  final String unidadeId;
  final String especialidadeId;
  final String consultaId;
  var _consultas = [];
  var _mensagem = [];
  final diaMesAno = new DateFormat("d 'de' MMMM 'de' yyyy");
  final diaSemana = new DateFormat("EEEE");
  final hora = new DateFormat("Hm");
  _ConfirmacaoState(
      {@required this.paciente,
      @required this.pacienteId,
      @required this.unidadeId,
      @required this.especialidadeId,
      this.consultaId});
  @override
  void initState() {
    super.initState();
    initializeDateFormatting("pr_BR", null).then((_) {
      this._getConsultas();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getConsultas() async {
    ConsultaModel consultaModel = await consultaBloc.fetchConsultas(
        this.consultaId,
        this.unidadeId,
        this.especialidadeId,
        DateTime.now().add(new Duration(days: 1)).toString(),
        DateTime.now().add(new Duration(days: 3)).toString());
    var consulta = consultaModel.getConsultas()[0];
    setState(() {
      _consultas = [consulta];
    });
  }

  void _postConsulta() async {
    MensagemModel mensagemModel =
        await consultaBloc.pushConsulta(this.pacienteId, this.consultaId);
    var mensagem = mensagemModel.getMensagem();
    setState(() {
      _mensagem = mensagem;
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(            
            title: new Text(this._mensagem.isEmpty?"": this._mensagem[0].tipoMensagem),
            content: new Text(this._mensagem.isEmpty?"":this._mensagem[0].mensagem),
            actions: <Widget>[
              new FlatButton(
                  child: new Text("Ok."),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        new SlideRightRoute(builder: (_) => Passo01()));
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(     
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("img/passo05.jpg"),
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
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Text(
                      'Leia com atenção e confirme o agendamento de sua consulta!',
                      style: TextStyle(
                        fontFamily: 'Humanist',
                        color: Colors.white,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    new Expanded(
                        flex: 0,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                (this._consultas.isEmpty
                                    ? ""
                                    : "Paciente: " +
                                        this.paciente +
                                        ".\nData: " +
                                        diaSemana.format(DateTime.parse(
                                            this._consultas[0].dataInicio)) +
                                        ", " +
                                        diaMesAno.format(DateTime.parse(
                                            this._consultas[0].dataInicio)) +
                                        ".\nHorário: " +
                                        hora.format(DateTime.parse(
                                            this._consultas[0].dataInicio)) +
                                        ".\nUnidade: " +
                                        this._consultas[0].unidade +
                                        ".\nSala/Consultório: " +
                                        this._consultas[0].consultorio +
                                        ".\nDr(a): " +
                                        this._consultas[0].medico +
                                        ".\nEspecialidade: " +
                                        this._consultas[0].especialidade),
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Humanist',
                                    fontSize: 20,
                                    shadows: <Shadow>[
                                      Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 3.0,
                                          color: Colors.green.withOpacity(0.7)),
                                      Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 8.0,
                                          color: Colors.green.withOpacity(0.7)),
                                    ]),
                                textAlign: TextAlign.left))),
                    RaisedButton.icon(
                      onPressed: () {
                        this._postConsulta();
                      },
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.green.withOpacity(0.7),
                      icon: Icon(Icons.done_all, color: Colors.white70),
                      label: Text(
                        "Confirmar",
                        style: TextStyle(
                            fontFamily: 'Humanist',
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                  ])),
            ),
            Expanded(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
