import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';
import 'package:gti_sesa_saude/widgets/rodape.dart';
import 'package:gti_sesa_saude/widgets/corpo.dart';
import 'package:gti_sesa_saude/widgets/barraAcao.dart';
import 'package:gti_sesa_saude/widgets/barraInferior.dart';

class Principal extends InheritedWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(body: _Principal());
  // }
  //final Principal data;

  Principal({
    Key key,
    //@required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(Principal old) => true;

  static _PrincipalState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_PrincipalState)
        as _PrincipalState);
  }
}

class _Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<_Principal> {
  DialogState _dialogState;
  String _msgErro;

  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    this._msgErro = "";
    _dialogState = DialogState.ERROR;
    super.initState();
  }

  @override
  void dispose() {
    _dialogState = DialogState.DISMISSED;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/background.png"), fit: BoxFit.cover),
          ),
          child: Column(children: <Widget>[
            Cabecalho(
              state: DialogState.DISMISSED,
              textoCabecalho: 'Cabeçalho',
            ),
            _dialogState == DialogState.DISMISSED
                ? Corpo(
                    state: DialogState.DISMISSED,
                    textoCorpo: 'Corpo',
                  )
                : MensagemDialog(
                    state: _dialogState,
                    paciente: "",
                    pacienteId: "",
                    textoTitle: "Desculpe!",
                    textoMensagem: _msgErro,
                    textoBtnOK: "OK",
                    textoBtnCancel: "Voltar",
                    textoState: "",
                    slideRightRouteBtnCancel: null,
                    color: Color.fromRGBO(41, 84, 142, 0.5),
                  ),
            Rodape(
              state: DialogState.DISMISSED,
              textoRodape: 'Rodapé',
            ),
            BarraAcao(
              state: DialogState.DISMISSED,
              textoBarraAcao: 'Barra de Ação',
            ),
          ])),
      bottomNavigationBar: BottomAppBar(
          child: BarraInferior(
        state: DialogState.DISMISSED,
        textoBarraInferior: 'BarraInferior',
      )),
    );
  }
}
