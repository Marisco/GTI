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
    double maxWidth = MediaQuery.of(context).size.width * 0.5;
    return state == DialogState.DISMISSED
        ? Container()
        : Container(
            decoration: BoxDecoration(
                color: this.color,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            margin: EdgeInsets.all(20),
            child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: AlertDialog(
                  contentPadding: EdgeInsets.all(5),
                  title: Text(
                    this.textoTitle,
                    style: TextStyle(
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
                    //width: MediaQuery.of(context).size.width * 1.5 ,
                    //height: MediaQuery.of(context).size.height,
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
                                textAlign: TextAlign.start,
                                style: TextStyle(
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
                              padding: const EdgeInsets.all(15.0),
                              child: ConstrainedBox(
                                  constraints:
                                      BoxConstraints(maxWidth: maxWidth),
                                  child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(right: 50),
                                            child: FlatButton(
                                                child: Text(
                                                  this.textoBtnCancel,
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontFamily: 'Humanist',
                                                    fontSize: 30,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                          offset:
                                                              Offset(1.0, 1.0),
                                                          blurRadius: 3.0,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.7)),
                                                      Shadow(
                                                          offset:
                                                              Offset(1.0, 1.0),
                                                          blurRadius: 3.0,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.7)),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(context,
                                                      slideRightRouteBtnCancel);
                                                })),
                                        Container(
                                            margin: EdgeInsets.only(left: 0),
                                            child: FlatButton(
                                                child: Text(
                                                  this.textoBtnOK,
                                                  style: TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontFamily: 'Humanist',
                                                    fontSize: 30,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                          offset:
                                                              Offset(1.0, 1.0),
                                                          blurRadius: 3.0,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.7)),
                                                      Shadow(
                                                          offset:
                                                              Offset(1.0, 1.0),
                                                          blurRadius: 3.0,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.7)),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(context,
                                                      slideRightRouteBtnOK);
                                                }))
                                      ])))
                        ]
                      : [],
                )));
  }
}

enum DialogState {
  LOADING,
  COMPLETED,
  DISMISSED,
}
