import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';

class Rodape extends StatelessWidget {
  final String textoRodape;
  final DialogState state;
  Rodape({
    this.state,
    this.textoRodape,
  });
  @override
  Widget build(BuildContext context) {
    var margemTop = MediaQuery.of(context).size.height * 0.20;
    var margemLeft = MediaQuery.of(context).size.width * 0.05;
    var margemRight = MediaQuery.of(context).size.width * 0.05;
    var margemBottom = 0.0;
    return Row(children: [
      Container(
        //color: Colors.blue,
        height: MediaQuery.of(context).size.height * 0.10,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.only(
        //     top: margemTop,
        //     left: margemLeft,
        //     right: margemRight,
        //     bottom: margemBottom),
        child: Center(
            child: Text(
          this.textoRodape,
          style: TextStyle(
            fontFamily: 'Humanist',
            color: Colors.red,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        )),
      ),
    ]);
  }
}
