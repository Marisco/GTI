import 'package:flutter/material.dart';

import 'servicos.model.dart';

class ServicosCard extends StatefulWidget {
  final Servico servico;

  ServicosCard(this.servico);

  @override
  _ServicosCardState createState() => _ServicosCardState(servico);
}

class _ServicosCardState extends State<DogCard> {
   Servico servico;

   _ServicosCardState(this.servico);

  @override
  Widget build(BuildContext context) {
    return Text(widget.servico.name);
  }
}