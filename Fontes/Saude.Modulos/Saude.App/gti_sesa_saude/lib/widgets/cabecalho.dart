import 'package:flutter/material.dart';

class Cabecalho extends StatelessWidget {
  final String txtCabecalho;  
  Cabecalho({
    this.txtCabecalho,
  });
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height * 0.20;
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85),
        height: height,
        width: width,
        child: Stack(          
          children: [
            Positioned(
              top: height * 0.3,              
              left: width * 0.02,
              child: 
            Image.asset('img/pms.png', height: height * 0.55, )),             
            Positioned(
              top: height * 0.24,              
              left: width * 0.7,
              child: Image.asset('img/coracao.png', height: height * 0.75))

          
        ]));
  }
}
