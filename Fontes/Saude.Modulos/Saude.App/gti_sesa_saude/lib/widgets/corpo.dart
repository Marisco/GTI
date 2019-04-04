import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/src/app.dart';

class Corpo extends StatelessWidget {
  final String textoCorpo;
  final Widget widgetCorpo;
  Corpo({
    this.textoCorpo,
    this.widgetCorpo,
  });
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          //color: Colors.yellow,
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,            
            children: <Widget>[
              this.textoCorpo != ""
                  ? Text(
                      this.textoCorpo,
                      style: AppTextStyle().getEstiloTexto(TipoTexto.CORPO),
                      textAlign: TextAlign.center,
                    )
                  : Container(),
              Flexible(child: widgetCorpo)
            ],
          )),
    ]);
  }
}
