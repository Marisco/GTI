import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';

class Corpo extends StatelessWidget {
  final String textoCorpo;
  final DialogState state;
  Corpo({
    this.state,
    this.textoCorpo,
  });
  @override
  Widget build(BuildContext context) {
    var margemTop = MediaQuery.of(context).size.height * 0.05;
    var margemLeft = MediaQuery.of(context).size.width * 0.05;
    var margemRight = MediaQuery.of(context).size.width * 0.05;
    var margemBottom = MediaQuery.of(context).size.height * 0.05;
    return Row(children: [
      Container(
          //color: Colors.yellow,
          height: MediaQuery.of(context).size.height * 0.60,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
              top: margemTop,
              left: margemLeft,
              right: margemRight,
              bottom: margemBottom),
          child: Center(
            child: Text(
              this.textoCorpo,
              style: TextStyle(
                fontFamily: 'Humanist',
                color: Colors.red,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          )),
    ]);
  }
}
