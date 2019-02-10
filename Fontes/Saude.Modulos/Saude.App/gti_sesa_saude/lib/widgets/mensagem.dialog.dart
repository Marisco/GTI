import 'package:flutter/material.dart';
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
  final SlideRightRoute slideRightRouteBtnOK;
  final SlideRightRoute slideRightRouteBtnCancel;
  final Color color;
  MensagemDialog(
      {this.state,
      this.paciente,
      this.pacienteId,
      this.textoTitle,
      this.textoState,
      this.textoMensagem,
      this.textoBtnOK,
      this.textoBtnCancel,
      this.slideRightRouteBtnOK,
      this.slideRightRouteBtnCancel,
      this.color});
  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return state == DialogState.DISMISSED
        ? Container()
        : Container(
            height: maxHeight * .55,
            width: maxWidth,
            decoration: BoxDecoration(
                color: this.color,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            margin: EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              AlertDialog(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  this.textoTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Humanist',
                    fontSize: 25,
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.7)),
                      Shadow(
                          offset: Offset(2.0, 2.0),
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
                  margin: EdgeInsets.only(top: 10),
                  height: maxHeight * 0.25,
                  child: state == DialogState.LOADING
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white)),
                              Text(
                                this.textoState,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Humanist',
                                  fontSize: 20,
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
                            ])
                      : Center(
                          child: Text(
                            this.textoMensagem,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Humanist',
                              fontSize: 20,
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
                        ),
                ),
                actions: state == DialogState.COMPLETED ||(state == DialogState.ERROR)
                    ? <Widget>[
                        FlatButton(
                            child: Text(
                              this.textoBtnCancel,
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Humanist',
                                fontSize: 25,
                                shadows: <Shadow>[
                                  Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.7)),
                                  Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ],
                              ),
                            ),
                            onPressed: () {
                               Navigator.pop(context);
                              Navigator.push(context, slideRightRouteBtnCancel);
                            }),
                        FlatButton(
                            child: Text(
                              this.textoBtnOK,
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontFamily: 'Humanist',
                                fontSize: 25,
                                shadows: <Shadow>[
                                  Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.7)),
                                  Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ],
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(context, slideRightRouteBtnOK);
                            })
                      ]
                    : [],
              )
            ]));
  }
}

enum DialogState {
  LOADING,
  COMPLETED,
  DISMISSED,
  ERROR  
}
