import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/enun.dart';

class Corpo extends StatelessWidget {
  final String textoCorpo;
  final DialogState state;
  Corpo({
    this.state,
    this.textoCorpo,
  });
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          //color: Colors.yellow,
          height: MediaQuery.of(context).size.height * 0.60,
          width: MediaQuery.of(context).size.width,
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
