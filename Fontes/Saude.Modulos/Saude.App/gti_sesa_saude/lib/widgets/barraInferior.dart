import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class BarraInferior extends StatelessWidget {
  final String textoBarraInferior;
  final DialogState state;
  BarraInferior({
    this.state,
    this.textoBarraInferior,
  });
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        //color: Colors.orange,
        height: MediaQuery.of(context).size.height * 0.03,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text(
          this.textoBarraInferior,
          style: TextStyle(
            fontFamily: 'Humanist',
            color: Colors.red,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        )),
      ),
    ]);
  }
}
