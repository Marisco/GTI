import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class MensagemDialog extends StatelessWidget {
  AppTextStyle texto = AppTextStyle();
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
    return state == DialogState.DISMISSED
        ? Container()
        : Container(
            decoration: BoxDecoration(
                color: this.color,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: EdgeInsets.all(40),
            padding: EdgeInsets.all(10),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              title: Center(
                  child: Text(this.textoTitle,
                      textAlign: TextAlign.center,
                      style: texto.getEstiloTexto(TipoTexto.TITULO))),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                margin: EdgeInsets.only(top: 50),
                child: state == DialogState.LOADING
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white)),
                            Text(this.textoState,
                                style: texto.getEstiloTexto(TipoTexto.LOADING)),
                          ])
                    : Center(
                        child: Text(this.textoMensagem,
                            textAlign: TextAlign.start,
                            style: texto.getEstiloTexto(TipoTexto.CORPO)),
                      ),
              ),
              actions: state == DialogState.COMPLETED ||
                      (state == DialogState.ERROR)
                  ? <Widget>[
                      FlatButton(
                          child: Text(this.textoBtnCancel,
                              style: texto.getEstiloTexto(TipoTexto.BTNCANCEL)),
                          onPressed: () {
                            Navigator.push(context, slideRightRouteBtnCancel);
                          }),
                      FlatButton(
                          child: Text(this.textoBtnOK,
                              style: texto.getEstiloTexto(TipoTexto.BTNOK)),
                          onPressed: () {
                            Navigator.push(context, slideRightRouteBtnOK);
                          })
                    ]
                  : [],
            ));
  }
}
