import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/src/app.dart';

class BarraInferior extends StatelessWidget {
  final String txtBarraInferior;
  BarraInferior({this.txtBarraInferior});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        color: Color.fromRGBO(41, 84, 142, 1),
        height: MediaQuery.of(context).size.height * 0.03,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: this.txtBarraInferior != null
                ? Text(
                    this.txtBarraInferior,
                    style: AppTextStyle().getEstiloTexto(TipoTexto.RODAPE),
                    textAlign: TextAlign.center,
                  )
                : Container()),
      ),
    ]);
  }
}
