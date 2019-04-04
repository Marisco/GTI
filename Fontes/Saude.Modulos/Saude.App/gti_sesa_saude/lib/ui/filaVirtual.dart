// import 'package:flutter/material.dart';
// import 'package:gti_sesa_saude/src/app.dart';
// import 'package:gti_sesa_saude/src/enun.dart';
// import 'package:gti_sesa_saude/blocs/filaVirtual.bloc.dart';
// import 'package:gti_sesa_saude/models/filaVirtual.model.dart';
// import 'package:gti_sesa_saude/ui/unidade.dart';
// import 'package:gti_sesa_saude/ui/confirmacao.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';
// import 'package:gti_sesa_saude/widgets/cabecalho.dart';

// class FilaVirtual extends StatelessWidget {
//   final String paciente;
//   final String pacienteId;
//   final String moduloId;
//   final String unidadeId;
//   final String especialidadeId;
//   FilaVirtual(
//       {@required this.paciente,
//       @required this.pacienteId,
//       @required this.moduloId,
//       @required this.unidadeId,
//       @required this.especialidadeId});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FilaVirtual(
//             paciente: this.paciente,
//             pacienteId: this.pacienteId,
//             moduloId: this.moduloId,
//             unidadeId: this.unidadeId,
//             especialidadeId: this.especialidadeId));
//   }
// }

// class _FilaVirtual extends StatefulWidget {
//   final String paciente;
//   final String pacienteId;
//   final String moduloId;
//   final String unidadeId;
//   final String especialidadeId;
//   _FilaVirtual(
//       {@required this.paciente,
//       @required this.pacienteId,
//       @required this.moduloId,
//       @required this.unidadeId,
//       @required this.especialidadeId});
//   @override
//   _FilaVirtualState createState() => _FilaVirtualState(
//       paciente: this.paciente,
//       pacienteId: this.pacienteId,
//       moduloId: this.moduloId,
//       unidadeId: this.unidadeId,
//       especialidadeId: this.especialidadeId);
// }

// class _FilaVirtualState extends State<_FilaVirtual> {
//   final String paciente;
//   final String pacienteId;
//   final String moduloId;
//   final String unidadeId;
//   final String especialidadeId;
//   var _filaVirtuals = [];
//   var _selFilaVirtual;
//   DialogState _dialogState;
//   String _msgErro;
//   _FilaVirtualState(
//       {@required this.paciente,
//       @required this.pacienteId,
//       @required this.moduloId,
//       @required this.unidadeId,
//       @required this.especialidadeId});
//   List<RadioModel> dadosFilaVirtual = List<RadioModel>();

//   @override
//   void initState() {
//     initializeDateFormatting("pt_BR", null);
//     this._msgErro = "";
//     _dialogState = DialogState.DISMISSED;
//     this._getFilaVirtuals();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _dialogState = DialogState.DISMISSED;
//     super.dispose();
//   }

//   void _getFilaVirtuals() async {
//     setState(() => _dialogState = DialogState.LOADING);
//     FilaVirtualModel filaVirtualModel = await filaVirtualBloc
//         .fetchFilasVirtuais(
//             "0",
//             this.unidadeId,
//             this.especialidadeId,
//             DateTime.now().add(Duration(days: 1)).toString(),
//             DateTime.now().add(Duration(days: 3)).toString())
//         .catchError((e) {
//       _dialogState = DialogState.ERROR;
//       _msgErro = e.message.toString().toLowerCase().contains("future")
//           ? "Serviço insiponível!"
//           : e.message;
//     });
//     _filaVirtuals = filaVirtualModel.getFilasVirtuais().toList();
//     Future.delayed(Duration(milliseconds: 500), () {
//       setState(() {
//         if (_filaVirtuals.isNotEmpty && _filaVirtuals[0] != null) {
//           _dialogState = DialogState.COMPLETED;
//           _filaVirtuals.forEach((filaVirtual) => dadosFilaVirtual.add(RadioModel(
//               false,
//               filaVirtual.numero,
//               filaVirtual.consultorio,
//               filaVirtual.especialidade,
//               filaVirtual.medico,
//               filaVirtual.dataInicio,
//               filaVirtual.dataFim)));
//         } else {
//           _dialogState = DialogState.ERROR;
//           _msgErro = "Fila Virtual indisponível";
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         body: SingleChildScrollView(
//             child: GestureDetector(
//                 onTap: () {
//                   FocusScope.of(context).requestFocus(FocusNode());
//                 },
//                 onHorizontalDragStart: (_) {
//                   Navigator.pop(context);
//                   SlideRightRouteR(
//                       builder: (_) => Unidade(
//                           pacienteId: this.pacienteId,
//                           paciente: this.paciente,
//                           moduloId: this.moduloId,
//                           ));
//                 },
//                 child: Container(
//                     height: MediaQuery.of(context).size.height,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage("img/passo04.jpg"),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: Column(children: <Widget>[
//                       Row(children: <Widget>[
//                         Cabecalho(
//                           state: DialogState.DISMISSED,
//                           textoCabecalho:
//                               'Escolha um horário.',
//                         ),
//                       ]),
//                       Row(children: <Widget>[
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 _dialogState == DialogState.ERROR
//                                     ? SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.55,
//                                         child: MensagemDialog(
//                                           state: _dialogState,
//                                           paciente: "",
//                                           pacienteId: "",
//                                           textoTitle: "Desculpe!",
//                                           textoMensagem: _msgErro,
//                                           textoBtnOK: "",
//                                           textoBtnCancel: "Voltar",
//                                           textoState: "",
//                                           slideRightRouteBtnCancel:
//                                               SlideRightRoute(
//                                                   builder: (_) => Unidade(
//                                                       pacienteId:
//                                                           this.pacienteId,
//                                                       paciente: this.paciente,
//                                                       moduloId: this.moduloId,
                                                      
//                                                       )),
//                                           color: Color.fromRGBO(
//                                               125, 108, 187, 0.75),
//                                         ))
//                                     : SizedBox(
//                                         child: Theme(
//                                         data: Theme.of(context).copyWith(
//                                             accentColor: Color.fromRGBO(
//                                                 189, 112, 162, 0.75),
//                                             canvasColor: Color.fromRGBO(
//                                                 189, 112, 162, 0.75)),
//                                         child: Container(
//                                             margin: EdgeInsets.all(20),
//                                             child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: <Widget>[
//                                                   SizedBox(
//                                                       height:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .height *
//                                                               (_dialogState ==
//                                                                       DialogState
//                                                                           .LOADING
//                                                                   ? 0.06
//                                                                   : 0.5),
//                                                       child: Theme(
//                                                           data: Theme.of(context).copyWith(
//                                                               accentColor:
//                                                                   Color.fromRGBO(
//                                                                       189,
//                                                                       112,
//                                                                       162,
//                                                                       0.75),
//                                                               canvasColor:
//                                                                   Colors.black),
//                                                           child:
//                                                               _dialogState !=
//                                                                       DialogState
//                                                                           .LOADING
//                                                                   ? ListView
//                                                                       .builder(
//                                                                       itemCount:
//                                                                           dadosFilaVirtual
//                                                                               .length,
//                                                                       itemBuilder:
//                                                                           (BuildContext context,
//                                                                               int index) {
//                                                                         return InkWell(
//                                                                           splashColor: Color.fromRGBO(
//                                                                               189,
//                                                                               112,
//                                                                               162,
//                                                                               0.75),
//                                                                           onTap:
//                                                                               () {
//                                                                             setState(() {
//                                                                               _selFilaVirtual = dadosFilaVirtual[index].numero;
//                                                                               dadosFilaVirtual.forEach((element) => element.isSelected = false);
//                                                                               dadosFilaVirtual[index].isSelected = true;
//                                                                             });
//                                                                           },
//                                                                           child:
//                                                                               RadioItem(dadosFilaVirtual[index]),
//                                                                         );
//                                                                       },
//                                                                     )
//                                                                   : CircularProgressIndicator(
//                                                                       valueColor:
//                                                                           AlwaysStoppedAnimation<Color>(
//                                                                               Colors.white)))),
//                                                   Padding(
//                                                       padding:
//                                                           EdgeInsets.all(20),
//                                                       child: RaisedButton.icon(
//                                                         onPressed:
//                                                             _dialogState ==
//                                                                     DialogState
//                                                                         .LOADING
//                                                                 ? null
//                                                                 : () {
//                                                                     Navigator.push(
//                                                                         context,
//                                                                         SlideRightRoute(
//                                                                             builder: (_) => Confirmacao(
//                                                                                 paciente: this.paciente,
//                                                                                 pacienteId: this.pacienteId,
//                                                                                 moduloId: this.moduloId,
//                                                                                 unidadeId: this.unidadeId,
//                                                                                 especialidadeId: this.especialidadeId,
//                                                                                 consultaId: "",
//                                                                                 filaVirtualId: this._selFilaVirtual)));
//                                                                   },
//                                                         elevation: 5.0,
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       30.0),
//                                                         ),
//                                                         color: _dialogState ==
//                                                                 DialogState
//                                                                     .LOADING
//                                                             ? Colors.grey
//                                                                 .withOpacity(
//                                                                     0.75)
//                                                             : Color.fromRGBO(
//                                                                 189,
//                                                                 112,
//                                                                 162,
//                                                                 0.75), //Color.fromRGBO(41, 84, 142, 1),
//                                                         icon: Icon(
//                                                             Icons.play_arrow,
//                                                             color:
//                                                                 Colors.white70),
//                                                         label: Text(
//                                                           "",
//                                                           style: TextStyle(
//                                                               fontFamily:
//                                                                   'Humanist',
//                                                               fontSize: 30,
//                                                               color:
//                                                                   Colors.white),
//                                                         ),
//                                                       )),
//                                                 ])),
//                                       ))
//                               ],
//                             )),
//                       ])
//                     ])))));
//   }
// }

// class RadioItem extends StatelessWidget {
//   final RadioModel _item;
//   final diaMesAno = DateFormat("d 'de' MMMM 'de' yyyy", "pt_BR");
//   final diaSemana = DateFormat("EEEE","pt_BR");
//   final hora = DateFormat("Hm", "pt_BR");
//   RadioItem(this._item);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       margin: EdgeInsets.all(5.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Container(
//             height: 100.0,
//             width: 100.0,
//             margin: EdgeInsets.only(left: 0.0),
//             child: Center(
//               child: Text(hora.format(DateTime.parse(_item.dataInicio)),
//                   style: TextStyle(
//                       fontFamily: 'Humanist',
//                       color: _item.isSelected ? Colors.white : Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18.0)),
//             ),
//             decoration: BoxDecoration(
//               color: _item.isSelected
//                   ? Color.fromRGBO(189, 112, 162, 0.75)
//                   : Colors.transparent,
//               border: Border.all(
//                   width: 2.0,
//                   color: _item.isSelected
//                       ? Color.fromRGBO(189, 112, 162, 0.75)
//                       : Color.fromRGBO(189, 112, 162, 0.75)),
//               borderRadius: BorderRadius.all(Radius.circular(2.0)),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Text(
//                   diaSemana
//                           .format(DateTime.parse(_item.dataInicio))
//                           .toString()
//                           .toUpperCase() +
//                       "\n" +
//                       diaMesAno.format(DateTime.parse(_item.dataInicio)) +
//                       "." +
//                       "\nSala: " +
//                       _item.consultorio +
//                       "." +
//                       "\nDr(a): " +
//                       _item.medico +
//                       "." +
//                       "\nEsp.: " +
//                       _item.especialidade +
//                       ".",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'Humanist',
//                     fontSize: 16,
//                     shadows: _item.isSelected
//                         ? <Shadow>[
//                             Shadow(
//                                 offset: Offset(1.0, 1.0),
//                                 blurRadius: 3.0,
//                                 color: Colors.white.withOpacity(0.7)),
//                             Shadow(
//                                 offset: Offset(1.0, 1.0),
//                                 blurRadius: 8.0,
//                                 color: Colors.white.withOpacity(0.7)),
//                           ]
//                         : [],
//                   ),
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }

// class RadioModel {
//   bool isSelected;
//   final String numero;
//   final String consultorio;
//   final String especialidade;
//   final String medico;
//   final String dataInicio;
//   final String dataFim;

//   RadioModel(this.isSelected, this.numero, this.consultorio, this.especialidade,
//       this.medico, this.dataInicio, this.dataFim);
// }
