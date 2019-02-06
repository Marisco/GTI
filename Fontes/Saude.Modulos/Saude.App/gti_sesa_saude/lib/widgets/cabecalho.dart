import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';

class Cabecalho extends StatelessWidget {
  final String textoMensagem;
  final DialogState state;
  Cabecalho({
    this.state,
    this.textoMensagem,
  });
  @override
  Widget build(BuildContext context) {
    var margemTop = MediaQuery.of(context).size.height * (state == DialogState.DISMISSED ? 0.25: 0.20);
    var margemLeft = MediaQuery.of(context).size.width *  0.05;
    var margemRight = MediaQuery.of(context).size.width * 0.05;
    var margemBottom = 0.0;
    return Row(children: [
      Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: margemTop, left: margemLeft, right: margemRight, bottom: margemBottom),
          child: Visibility(
            visible: state == DialogState.DISMISSED,
            child: Text(this.textoMensagem,
              style: TextStyle(
                fontFamily: 'Humanist',
                color: Colors.white,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          )),
    ]);
  }
}
