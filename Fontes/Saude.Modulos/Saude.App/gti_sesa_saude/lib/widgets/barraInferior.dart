import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/src/app.dart';

class BarraInferior extends StatelessWidget {
  final String txtBarraInferior;
  BarraInferior({this.txtBarraInferior});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.03;
    double width = MediaQuery.of(context).size.width;
    return Row(children: [
      Container(
        color: Color.fromRGBO(41, 84, 142, 1),
        height: height,
        width: width,
        child: this.txtBarraInferior != null
            ? Stack(children: [
                Positioned(
                    top: height * 0,
                    right: width * 0.1,
                    child: Image.asset(
                      'img/gti.png',
                      height: height * 0.9,
                    )),
                Center(
                    child: Text(
                  this.txtBarraInferior,
                  style: AppTextStyle().getEstiloTexto(TipoTexto.RODAPE),
                  textAlign: TextAlign.center,
                ))
              ])
            : Container(),
      )
    ]);
  }
}
