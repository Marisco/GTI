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
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  AssetImage imagemFundo;
  String msgErro;
  String txtCabecalho;
  String txtCorpo;
  double alturaVariada;
  String txtRodape;
  String txtBarraAcao;
  String txtBarraInferior;
  String nomePaciente;
  String idPacienteId;
  Widget widgetCorpo;
  Widget widgetRodape;
  Widget widgetBarrraAcao;
  DialogState dialogState;
  Color dialogColor;
  Color rodapeColor;
  String dialogTxtLoading;
  String dialogTxtTitulo;
  String dialogTxtMensagem;
  String dialogTxtBtnOK;
  String dialogTxtBtnCancel;
  SlideRightRoute dialogSlideRightBtnOK;
  SlideLeftRoute dialogSlideLeftBtnCancel;

  _PrincipalState();

  @override
  void initState() {
    dialogState = DialogState.DISMISSED;
    dialogTxtLoading = "";
    dialogTxtTitulo = "";
    dialogTxtMensagem = "";
    dialogTxtBtnOK = "";
    dialogTxtBtnCancel = "";
    super.initState();   
  }

  void didChangeDependecies() {
    this.dialogState = DialogState.DISMISSED;
    initializeDateFormatting("pt_BR", null);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  Widget build(BuildContext context) {
    return _InheritedPrincipalState(
        principalState: this, child: widget.child);
  }

  Widget setPrincipal() {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () {
          setState(() {
            this.dialogState = DialogState.DISMISSED;
            Navigator.push(context, this.dialogSlideLeftBtnCancel);
          });
        },
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            onHorizontalDragStart: (_) {
              this.dialogState = DialogState.DISMISSED;
              Navigator.push(context, this.dialogSlideLeftBtnCancel);
            },
            child: Scaffold(
              resizeToAvoidBottomPadding: false,
              body: Container(
                  height: height,
                  decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("img/unidade.png"), fit: BoxFit.cover),
                  ),
                  child: this.dialogState == DialogState.DISMISSED
                      ? Column(children: <Widget>[
                          Cabecalho(
                            txtCabecalho: this.txtCabecalho,
                            setaLVisible: this.idPacienteId != null,
                          ),
                          Corpo(
                            txtCorpo: this.txtCorpo,
                            widgetCorpo: this.widgetCorpo,
                            alturaVariada: this.alturaVariada,
                          ),
                          this.widgetRodape != null
                              ? Rodape(
                                  txtRodape: this.txtRodape,
                                  widgetRodape: widgetRodape,
                                  rodapeColor: this.rodapeColor,
                                )
                              : Container(),
                          BarraAcao(
                              txtBarraAcao: this.txtBarraAcao,
                              widgetBarrraAcao: widgetBarrraAcao),
                        ])
                      : Container(
                          padding: EdgeInsets.only(
                              top: height * 0.15, bottom: height * 0.15),
                          child: MensagemDialog(
                              dialogState: this.dialogState,
                              dialogTxtTitulo: this.dialogTxtTitulo,
                              dialogTxtMensagem: this.dialogTxtMensagem,
                              dialogTxtBtnOK: this.dialogTxtBtnOK,
                              dialogTxtBtnCancel: this.dialogTxtBtnCancel,
                              dialogTxtLoading: this.dialogTxtLoading,
                              dialogSlideLeftBtnCancel:
                                  this.dialogSlideLeftBtnCancel,
                              dialogSlideRightBtnOK: this.dialogSlideRightBtnOK,
                              dialogColor: this.dialogColor))),
              bottomNavigationBar: BottomAppBar(
                  child:
                      BarraInferior(txtBarraInferior: this.txtBarraInferior)),
            )));
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
