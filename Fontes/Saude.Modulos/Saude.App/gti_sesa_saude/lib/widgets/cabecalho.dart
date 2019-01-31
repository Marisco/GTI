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
    return Row(children: [
      Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 130, left: 10, right: 10, bottom: 15),
          child: Visibility(
            visible: state == DialogState.DISMISSED,
            child: Text(this.textoMensagem,
              style: TextStyle(
                fontFamily: 'Humanist',
                color: Colors.white,
                fontSize: 30,
              ),
              textAlign: TextAlign.justify,
            ),
          )),
    ]);
  }
}
