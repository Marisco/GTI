import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';

class Cabecalho extends StatelessWidget {
  final String textoCabecalho;
  final DialogState state;
  Cabecalho({
    this.state,
    this.textoCabecalho,
  });
  @override
  Widget build(BuildContext context) {
    var margemTop = MediaQuery.of(context).size.height * 0.05;
    var margemLeft = MediaQuery.of(context).size.width * 0.05;
    var margemRight = MediaQuery.of(context).size.width * 0.05;
    var margemBottom = MediaQuery.of(context).size.height * 0.05;
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
          child: Container(
              //color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  top: margemTop,
                  left: margemLeft,
                  right: margemRight,
                  bottom: margemBottom),
              child: Center(
                child: Text(
                  this.textoCabecalho,
                  style: TextStyle(
                    fontFamily: 'Humanist',
                    color: Colors.red,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ))),
      
    ]);
  }
}
