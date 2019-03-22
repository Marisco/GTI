import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
import 'package:gti_sesa_saude/widgets/cabecalho.dart';
import 'package:gti_sesa_saude/ui/passo01.dart';
import 'package:gti_sesa_saude/ui/passo02.dart';

class Principal extends StatelessWidget {
  final String paciente;
  final String pacienteId;
  Principal({@required this.paciente, @required this.pacienteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            MenuServicos(paciente: this.paciente, pacienteId: this.pacienteId));
  }
}

class MenuServicos extends StatefulWidget {
  final String paciente;
  final String pacienteId;

  MenuServicos({@required this.paciente, @required this.pacienteId});
  @override
  _MenuServicos createState() =>
      _MenuServicos(paciente: this.paciente, pacienteId: this.pacienteId);
}

class _MenuServicos extends State<MenuServicos> {
  final String paciente;
  final String pacienteId;
  DialogState _dialogState;
  String _msgErro;
  _MenuServicos({@required this.paciente, @required this.pacienteId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onHorizontalDragStart: (_) {
                  Navigator.pop(context);
                  SlideRightRouteR(builder: (_) => Passo01());
                },
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/passo03.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Cabecalho(
                          state: DialogState.DISMISSED,
                          textoMensagem: 'Serviços Disponíveis.',
                        ),
                      ]),
                      Row(children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _dialogState == DialogState.ERROR
                                    ? SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: MensagemDialog(
                                          state: _dialogState,
                                          paciente: "",
                                          pacienteId: "",
                                          textoTitle: "Desculpe!",
                                          textoMensagem: _msgErro,
                                          textoBtnOK: "",
                                          textoBtnCancel: "Voltar",
                                          textoState: "",
                                          slideRightRouteBtnCancel:
                                              SlideRightRoute(
                                                  builder: (_) => Principal(
                                                      paciente: this.paciente,
                                                      pacienteId:
                                                          this.pacienteId)),
                                          color: Color.fromRGBO(
                                              63, 157, 184, 0.75),
                                        ))
                                    : SizedBox(
                                        child: Theme(
                                        data: Theme.of(context).copyWith(
                                            accentColor: Color.fromRGBO(
                                                63, 157, 184, 0.75),
                                            canvasColor: Color.fromRGBO(
                                                63, 157, 184, 0.75)),
                                        child: Container(
                                            margin: EdgeInsets.all(40),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  _dialogState ==
                                                          DialogState.LOADING
                                                      ? CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white))
                                                      :  Expanded(
      child: ListView.builder(
                                                                      itemCount:planets.length,
                                                                      itemExtent: 152.0,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return InkWell(
                                                                          splashColor: Color.fromRGBO(
                                                                              189,
                                                                              112,
                                                                              162,
                                                                              0.75),
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              _selConsulta = dadosConsulta[index].numero;
                                                                              dadosConsulta.forEach((element) => element.isSelected = false);
                                                                              dadosConsulta[index].isSelected = true;
                                                                            });
                                                                          },
                                                                          child:
                                                                              RadioItem(dadosConsulta[index]),
                                                                        );
                                                                      },
                                                                    )
                                        )])),
                                      ))
                              ],
                            )),
                      ])
                    ])))));
  }
}
