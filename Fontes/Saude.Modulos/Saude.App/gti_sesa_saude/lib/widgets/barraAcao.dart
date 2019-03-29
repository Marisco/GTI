import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';

class BarraAcao extends StatelessWidget {
  final String textoBarraAcao;
  final DialogState state;
  BarraAcao({
    this.state,
    this.textoBarraAcao,
  });
  @override
  Widget build(BuildContext context) {    
    return Row(
      children: [
      Container(
        //color: Colors.green,
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.only(
        //     top: margemTop,
        //     left: margemLeft,
        //     right: margemRight,
        //     bottom: margemBottom),
        child: Center(
            child:Text(
          this.textoBarraAcao,
          style: TextStyle(
            fontFamily: 'Humanist',
            color: Colors.red,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        )),
      ),
    ]);
  }
}
