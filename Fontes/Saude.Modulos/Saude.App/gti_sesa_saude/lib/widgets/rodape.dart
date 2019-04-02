import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class Rodape extends StatelessWidget {
  final String textoRodape;
  final DialogState state;
  Rodape({
    this.state,
    this.textoRodape,
  });
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        //color: Colors.blue,
        height: MediaQuery.of(context).size.height * 0.10,
        width: MediaQuery.of(context).size.width,
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
