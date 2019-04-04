import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class Rodape extends StatelessWidget {
  final String textoRodape;
  final Widget widgetRodape;
  Rodape({this.textoRodape, this.widgetRodape});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        color: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85),
        height: MediaQuery.of(context).size.height * 0.10,
        width: MediaQuery.of(context).size.width,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          this.textoRodape != ""
              ? Text(this.textoRodape,
                  textAlign: TextAlign.center,
                  style: AppTextStyle().getEstiloTexto(TipoTexto.TITULO))
              : Container(),
          widgetRodape
        ]));
  }
}
