import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/ui/passo02.dart';
import 'package:gti_sesa_saude/ui/passo01.dart';
import 'package:gti_sesa_saude/ui/app.dart';

class MensagemDialog extends StatelessWidget {
  final DialogState state;
  final String paciente;
  final String pacienteId;
  final String textoTitle;
  final String textoState;
  final String textoMensagem;
  final String textoBtnOK;
  final String textoBtnCancel;
  MensagemDialog(
      {this.state,
      this.paciente,
      this.pacienteId,
      this.textoTitle,
      this.textoState,
      this.textoMensagem,
      this.textoBtnOK,
      this.textoBtnCancel});
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 0.5;
    return state == DialogState.DISMISSED
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: AlertDialog(
              title: new Text(
                this.textoTitle,
                style: new TextStyle(
                  color: Colors.white,
                  fontFamily: 'Humanist',
                  fontSize: 25,
                  shadows: <Shadow>[
                    Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.7)),
                    Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 5.0,
                        color: Colors.black.withOpacity(0.7)),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                child: state == DialogState.LOADING
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white)),
                           Text(
                              this.textoState,
                              style: new TextStyle(
                                color: Colors.white,
                                fontFamily: 'Humanist',
                                fontSize: 25,
                                shadows: <Shadow>[
                                  Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.7)),
                                  Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 5.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ],
                              ),
                            ),
                          
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Center(
                          child: Text(
                            this.textoMensagem,
                            textAlign: TextAlign.left,
                            style: new TextStyle(
                              color: Colors.white,
                              fontFamily: 'Humanist',
                              fontSize: 25,
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Colors.black.withOpacity(0.7)),
                                Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 5.0,
                                    color: Colors.black.withOpacity(0.7)),
                              ],
                            ),
                          ),
                        )),
              ),
              actions: state == DialogState.COMPLETED
                  ? <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: maxWidth),
                              child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: <Widget>[
                                    new FlatButton(
                                        child: new Text(
                                          this.textoBtnCancel,
                                          style: new TextStyle(
                                            color: Colors.red,
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
                                                  blurRadius: 3.0,
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                            ],
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              new SlideRightRoute(
                                                  builder: (_) => Passo01()));
                                        }),
                                    new FlatButton(
                                        child: new Text(
                                          this.textoBtnOK,
                                          style: new TextStyle(
                                            color: Colors.greenAccent,
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
                                                  blurRadius: 3.0,
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                            ],
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              new SlideRightRoute(
                                                  builder: (_) => Passo02(
                                                      paciente: this.paciente,
                                                      pacienteId: this.pacienteId)));
                                        })
                                  ])))
                    ]
                  : [],
            ));
  }
}

enum DialogState {
  LOADING,
  COMPLETED,
  DISMISSED,
}
