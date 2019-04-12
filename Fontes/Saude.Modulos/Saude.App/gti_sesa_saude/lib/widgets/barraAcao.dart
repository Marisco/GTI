import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/ui/principal.dart';
import 'package:gti_sesa_saude/ui/identificacao.dart';
import 'package:gti_sesa_saude/ui/localizacao.dart';

class BarraAcao extends StatelessWidget {
  final String txtBarraAcao;
  final Widget widgetBarrraAcao;
  BarraAcao({this.txtBarraAcao, this.widgetBarrraAcao});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.07;
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white.withOpacity(0.55),
        height: height,
        width: width,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          this.txtBarraAcao != null
              ? Text(this.txtBarraAcao,
                  textAlign: TextAlign.center,
                  style: AppTextStyle().getEstiloTexto(TipoTexto.TITULO))
              : Container(),
          Expanded(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                  width: width * .30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: FlatButton(
                              onPressed: () => {
                                    Navigator.push(
                                        context,
                                        SlideRightRoute(
                                            builder: (_) => Principal(
                                                child: Identificacao())))
                                  },
                              child: Icon(Icons.home,
                                  color: Colors.black, size: height * 0.6))),
                      Text(
                        "Home",
                        style: AppTextStyle().getEstiloTexto(TipoTexto.ACAO),
                      )
                    ],
                  )),
              Container(
                  width: width * .30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: FlatButton(
                              onPressed: () => {
                                    Navigator.push(
                                        context,
                                        SlideRightRoute(
                                            builder: (_) => Principal(
                                                child: Localizacao())))
                                  },
                              child:
                      Icon(Icons.location_on,
                          color: Colors.black, size: height * 0.6))),
                      Text(
                        "Localização",
                        style: AppTextStyle().getEstiloTexto(TipoTexto.ACAO),
                      )
                    ],
                  )),
              Container(
                  width: width * .30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.phone_in_talk,
                          color: Colors.black, size: height * 0.6),
                      Text(
                        "Ouvidoria",
                        style: AppTextStyle().getEstiloTexto(TipoTexto.ACAO),
                      )
                    ],
                  )),
              Container(
                  width: width * .30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.notifications,
                          color: Colors.black, size: height * 0.6),
                      Text(
                        "Notificação",
                        style: AppTextStyle().getEstiloTexto(TipoTexto.ACAO),
                      )
                    ],
                  )),
              Container(
                  width: width * .30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
