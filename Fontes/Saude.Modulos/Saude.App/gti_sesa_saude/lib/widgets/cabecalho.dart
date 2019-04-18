import 'package:flutter/material.dart';

class Cabecalho extends StatelessWidget {
  final String txtCabecalho;
  final bool setaLVisible;

  Cabecalho({this.txtCabecalho, this.setaLVisible = false});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.20;
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85),
        height: height,
        width: width,
        child: Stack(children: [
          Visibility(
              visible: setaLVisible,
              child: Positioned(
                  bottom: height * 0.02,
                  left: width * 0.02,
                  child: Icon(Icons.arrow_back, color: Colors.white70))),
          Positioned(
              top: height * 0.2,
              left: width * 0.02,
              child: Image.asset(
                'img/pms.png',
                height: height * 0.55,
              )),
          Positioned(
              top: height * 0.2,
              right: width * 0.02,
              child: Image.asset('img/coracao.png', height: height * 0.75))
        ]));
  }
}
