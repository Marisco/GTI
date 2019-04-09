import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class Rodape extends StatelessWidget {
  final String txtRodape;
  final Color rodapeColor;
  final Widget widgetRodape;
  Rodape({this.txtRodape, this.widgetRodape, this.rodapeColor});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        color: this.rodapeColor,
        height: MediaQuery.of(context).size.height * 0.10,
        width: MediaQuery.of(context).size.width,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          this.txtRodape != null
              ? Text(this.txtRodape,
                  textAlign: TextAlign.center,
                  style: AppTextStyle().getEstiloTexto(TipoTexto.TITULO))
              : Container(),
           this.widgetRodape != null?   
          widgetRodape
          : Container()
        ]));
  }
}
