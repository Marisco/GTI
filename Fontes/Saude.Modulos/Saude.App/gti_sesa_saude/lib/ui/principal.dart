import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';
import 'package:gti_sesa_saude/widgets/rodape.dart';
import 'package:gti_sesa_saude/widgets/corpo.dart';
import 'package:gti_sesa_saude/widgets/barraAcao.dart';
import 'package:gti_sesa_saude/widgets/barraInferior.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/widgets/mensagemDialog.dart';

class Principal extends StatefulWidget {
  final Widget child;

  Principal({@required this.child});

  static _PrincipalState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedPrincipalState)
            as _InheritedPrincipalState)
        .principalState;
  }

  @override
  _PrincipalState createState() => new _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  AssetImage imagemFundo;
  String msgErro;
  String textoCabecalho;
  String textoCorpo;
  String textoRodape;
  String textoBarraAcao;
  String textoBarraInferior;
  String paciente;
  String pacienteId;
  Widget widgetCorpo;
  Widget widgetRodape;
  Widget widgetBarrraAcao;
  DialogState dialogState;
  Color dialogColor;
  String dialogTxtLoading;
  String dialogTxtTitulo;
  String dialogTxtMensagem;
  String dialogTxtBtnOK;
  String dialogTxtBtnCancel;
  SlideRightRoute dialogSlideRightBtnOK;
  SlideRightRoute dialogSlideRightBtnCancel;

  _PrincipalState();

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    super.initState();
  }

  @override
  void dispose() {
    dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new _InheritedPrincipalState(
        principalState: this, child: widget.child);
  }

  Widget getPrincipal() {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: imagemFundo, fit: BoxFit.cover),
          ),
          child: this.dialogState == DialogState.DISMISSED
              ? Column(children: <Widget>[
                  Cabecalho(
                    textoCabecalho: this.textoCabecalho,
                  ),
                  Corpo(
                    textoCorpo: this.textoCorpo,
                    widgetCorpo: widgetCorpo,
                  ),
                  Rodape(
                      textoRodape: this.textoRodape,
                      widgetRodape: widgetRodape),
                  BarraAcao(
                      textoBarraAcao: this.textoBarraAcao,
                      widgetBarrraAcao: widgetBarrraAcao),
                ])
              : Container(
                padding: EdgeInsets.only(top: height * 0.15, bottom: height *0.15),
                child: 
              MensagemDialog(
                  dialogState: this.dialogState,
                  dialogTxtTitulo: this.dialogTxtTitulo,
                  dialogTxtMensagem: this.dialogTxtMensagem,
                  dialogTxtBtnOK: this.dialogTxtBtnOK,
                  dialogTxtBtnCancel: this.dialogTxtBtnCancel,
                  dialogTxtLoading: this.dialogTxtLoading,
                  dialogSlideRightBtnCancel: this.dialogSlideRightBtnCancel,
                  dialogSlideRightBtnOK: this.dialogSlideRightBtnOK,
                  dialogColor: this.dialogColor))),
      bottomNavigationBar: BottomAppBar(
          child: BarraInferior(textoBarraInferior: this.textoBarraInferior)),
    );
  }
}

class _InheritedPrincipalState extends InheritedWidget {
  final _PrincipalState principalState;

  _InheritedPrincipalState(
      {Key key, @required this.principalState, @required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedPrincipalState old) => true;
}
