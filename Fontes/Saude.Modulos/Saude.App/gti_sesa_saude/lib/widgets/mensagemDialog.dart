import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class MensagemDialog extends StatelessWidget {
  final DialogState dialogState;
  final Color dialogColor;
  final String dialogTxtTitulo;
  final String dialogTxtLoading;
  final String dialogTxtMensagem;
  final String dialogTxtBtnOK;
  final String dialogTxtBtnCancel;
  final SlideRightRoute dialogSlideRightBtnOK;
  final SlideRightRoute dialogSlideRightBtnCancel;

  MensagemDialog(
      {this.dialogState,
      this.dialogColor,
      this.dialogTxtTitulo,
      this.dialogTxtLoading,
      this.dialogTxtMensagem,
      this.dialogTxtBtnOK,
      this.dialogTxtBtnCancel,
      this.dialogSlideRightBtnOK,
      this.dialogSlideRightBtnCancel});
  @override
  Widget build(BuildContext context) {
    return dialogState == DialogState.DISMISSED
        ? Container()
        : Stack(children: <Widget>[
            AlertDialog(
              backgroundColor: this.dialogColor,
              contentPadding: EdgeInsets.all(15),
              elevation: 0,
              title: Text(this.dialogTxtTitulo,
                  textAlign: TextAlign.left,
                  style: AppTextStyle().getEstiloTexto(TipoTexto.TITULO)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              content: dialogState == DialogState.LOADING
                  ? Column(children: [
                      CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)),
                      SizedBox(height: 10),
                      Text(this.dialogTxtLoading,
                          style:
                              AppTextStyle().getEstiloTexto(TipoTexto.LOADING))
                    ])
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(this.dialogTxtMensagem,
                              textAlign: TextAlign.start,
                              style: AppTextStyle()
                                  .getEstiloTexto(TipoTexto.CABECALHO)),
                        ]),
              actions: dialogState == DialogState.COMPLETED ||
                      (dialogState == DialogState.ERROR)
                  ? <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                          child: FlatButton(
                              child: Text(this.dialogTxtBtnCancel,
                                  style: AppTextStyle()
                                      .getEstiloTexto(TipoTexto.BTNCANCEL)),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context, dialogSlideRightBtnCancel);
                              })),
                      FlatButton(
                          child: Text(this.dialogTxtBtnOK,
                              style: AppTextStyle()
                                  .getEstiloTexto(TipoTexto.BTNOK)),
                          onPressed: () {
                            Navigator.push(context, dialogSlideRightBtnOK);
                          }),
                    ]
                  : [],
            ),
            Positioned(
                top: 16,
                right: 32,
                child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: FloatingActionButton(
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 20,
                        ),
                        backgroundColor: Colors.white.withOpacity(
                            .9), // fromRGBO(41, 84, 142, 1).withOpacity(0.85),
                        //Colors.transparent,
                        //this.dialogColor,
                        elevation: 0,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context, dialogSlideRightBtnCancel);
                        }))),
          ]);
  }
}
