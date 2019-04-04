import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/src/app.dart';

class BarraInferior extends StatelessWidget {
  final String textoBarraInferior;
  BarraInferior({this.textoBarraInferior});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        color: Color.fromRGBO(41, 84, 142, 1),
        height: MediaQuery.of(context).size.height * 0.03,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text(
          this.textoBarraInferior,
          style: AppTextStyle().getEstiloTexto(TipoTexto.RODAPE),
          textAlign: TextAlign.center,
        )),
      ),
    ]);
  }
}
