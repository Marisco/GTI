import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class Cabecalho extends StatelessWidget {
  final String textoCabecalho;
  final DialogState state;
  Cabecalho({
    this.state,
    this.textoCabecalho,
  });
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
          child: Container(
              //color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width,
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
