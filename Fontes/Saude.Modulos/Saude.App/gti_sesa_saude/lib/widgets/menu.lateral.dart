// import 'package:flutter/material.dart';
// import '../src/app.dart';
// import '../ui/identificacao.dart';
// import '../ui/unidade.dart';
// import '../ui/especialidade.dart';
// import '../ui/consulta.dart';
// import '../ui/confirmacao.dart';

// class MenuLateral extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Botoes();
//   }
// }

// class Botoes extends StatefulWidget {
//   Botoes({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _BotoesState createState() => _BotoesState();
// }

// class _BotoesState extends State<Botoes> {
//   final _documento = TextEditingController();
//   bool _active = false;
//   bool _btn1 = false;
//   bool _btn2 = false;
//   bool _btn3 = false;
//   bool _btn4 = false;
//   bool _btn5 = false;
//   @override
//   void dispose() {
//     _documento.dispose();
//     super.dispose();
//   }

//   void _changeButton(int nrButton) {    

//     switch (nrButton) {
//       case 1:
//         {
//           _btn1 = true;          
//           _btn2 = false;
//           _btn3 = false;
//           _btn4 = false;
//           _btn5 = false;
//         }
//     }

//     setState(() {
//       _btn1 = _btn1;
//       _btn2 = _btn2;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 2, // 10%
//       child: Container(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
//             Widget>[
//           OutlineButton(
//               child:
//                   new Image.asset("img/ic_passo01.png", width: _btn1 ? 64 : 56),
//               borderSide: BorderSide(color: Colors.transparent),
//               padding: new EdgeInsets.all(!_active ? 10 : 5),
//               shape: new RoundedRectangleBorder(
//                   borderRadius: new BorderRadius.circular(60)),
//               onPressed: () {
//                 Navigator.push(
//                     context, new TransicaoTela(builder: (_) => Identificacao()));
//                 _changeButton(1);
//               }),
//           OutlineButton(
//               child:
//                   new Image.asset("img/ic_passo02.png", width: _btn2 ? 64 : 56),
//               borderSide: BorderSide(color: Colors.transparent),
//               padding: new EdgeInsets.all(10),
//               shape: new RoundedRectangleBorder(
//                   borderRadius: new BorderRadius.circular(360)),
//               onPressed: () {
//                 Navigator.push(
//                     context, new TransicaoTela(builder: (_) => Unidade(paciente:"", pacienteId: "",moduloId: "")));
//                 _changeButton(2);
//               }),
//           OutlineButton(
//               child:
//                   new Image.asset("img/ic_passo03.png", width: _btn3 ? 64 : 56),
//               borderSide: BorderSide(color: Colors.transparent),
//               padding: new EdgeInsets.all(10),
//               shape: new RoundedRectangleBorder(
//                   borderRadius: new BorderRadius.circular(360)),
//               onPressed: () {
//                 Navigator.push(
//                     context, new TransicaoTela(builder: (_) => Especialidade(paciente:"", pacienteId: "",unidadeId: "", moduloId: "" )));
//                 _changeButton(3);
//               }),
//           OutlineButton(
//               child:
//                   new Image.asset("img/ic_passo04.png", width: _btn4 ? 64 : 56),
//               borderSide: BorderSide(color: Colors.transparent),
//               padding: new EdgeInsets.all(10),
//               shape: new RoundedRectangleBorder(
//                   borderRadius: new BorderRadius.circular(360)),
//               onPressed: () {
//                 Navigator.push(
//                     context, new TransicaoTela(builder: (_) => Consulta(paciente:"", pacienteId: "",unidadeId: "",especialidadeId: "", moduloId: "")));
//                 _changeButton(4);
//               }),
//           OutlineButton(
//               child:
//                   new Image.asset("img/ic_passo05.png", width: _btn5 ? 64 : 56),
//               borderSide: BorderSide(color: Colors.transparent),
//               padding: new EdgeInsets.all(10),
//               disabledBorderColor: Colors.transparent,
//               shape: new RoundedRectangleBorder(
//                   borderRadius: new BorderRadius.circular(360)),
//               onPressed: () {
//                 Navigator.push(
//                     context, new TransicaoTela(builder: (_) => Confirmacao(paciente:"", pacienteId: "",unidadeId: "",especialidadeId: "",consultaId: "", moduloId: "", filaVirtualId: "")));
//                 _changeButton(5);
//               }),
//         ]),
//       ),
//     );
//   }
// }
