import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class BarraAcao extends StatelessWidget {
  final String textoBarraAcao;
  final Widget widgetBarrraAcao;
  BarraAcao({this.textoBarraAcao, this.widgetBarrraAcao});
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height * 0.07;
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white.withOpacity(0.55),
        height: height,
        width: width,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(this.textoBarraAcao,
              textAlign: TextAlign.center,
              style: AppTextStyle().getEstiloTexto(TipoTexto.TITULO)),
          Expanded(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                  width: width * .30,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.home, color: Colors.black, size: height * 0.6),
                      Text(
                        "Home",
                        style: AppTextStyle().getEstiloTexto(TipoTexto.ACAO),
                      )
                    ],
                  )),
              Container(
                  width: width * .30,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.black, size: height * 0.6),
                      Text(
                        "Localização",
                        style: AppTextStyle().getEstiloTexto(TipoTexto.ACAO),
                      )
                    ],
                  )),
              Container(
                  width: width * .30,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.phone_in_talk, color: Colors.black, size: height * 0.6),
                      Text(
                        "Ouvidoria",
                        style: AppTextStyle().getEstiloTexto(TipoTexto.ACAO),
                      )
                    ],
                  )),
              Container(
                  width: width * .30,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.notifications, color: Colors.black, size: height * 0.6),
                      Text(
                        "Notificação",
                        style: AppTextStyle().getEstiloTexto(TipoTexto.ACAO),
                      )
                    ],
                  )),
              Container(
                  width: width * .30,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.web, color: Colors.black, size: height * 0.6),
                      Text(
                        "Site",
                        style: AppTextStyle().getEstiloTexto(TipoTexto.ACAO),
                      )
                    ],
                  )),
            ],
          ))
        ]));
  }
}
