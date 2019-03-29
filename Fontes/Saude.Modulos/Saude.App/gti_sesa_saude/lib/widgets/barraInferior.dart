import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';

class BarraInferior extends StatelessWidget {
  final String textoBarraInferior;
  final DialogState state;
  BarraInferior({
    this.state,
    this.textoBarraInferior,
  });
  @override
  Widget build(BuildContext context) {    
    return Row(
      children: [
      Container(
        color: Colors.orange,
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.only(
        //     top: margemTop,
        //     left: margemLeft,
        //     right: margemRight,
        //     bottom: margemBottom),
        child: Text(
          this.textoBarraInferior,
          style: TextStyle(
            fontFamily: 'Humanist',
            color: Colors.white,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ]);
  }
}
