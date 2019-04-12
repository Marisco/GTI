import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/src/app.dart';

class Corpo extends StatelessWidget {
  final String txtCorpo;
  final Widget widgetCorpo;
  final double alturaVariada;
  Corpo({
    this.txtCorpo,
    this.widgetCorpo,
    this.alturaVariada = 1
  });
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(          
          height: MediaQuery.of(context).size.height * alturaVariada,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,            
            children: <Widget>[
              this.txtCorpo != ""
                  ? Container( 
                    child: Text(
                      this.txtCorpo,
                      style: AppTextStyle().getEstiloTexto(TipoTexto.CORPO),
                      textAlign: TextAlign.center,
                    ))
                  : Container(),
              Flexible(child: widgetCorpo)
            ],
          )),
    ]);
  }
}
