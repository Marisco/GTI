import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RadioModel {
  bool isSelected;
  final String numero;
  final String nomeModulo;

  RadioModel(this.isSelected, this.numero, this.nomeModulo);
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  final diaMesAno = DateFormat("d 'de' MMMM 'de' yyyy", "pt_BR");
  final diaSemana = DateFormat("EEEE", "pt_BR");
  final hora = DateFormat("Hm", "pt_BR");
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 100.0,
            margin: EdgeInsets.only(left: 0.0),
            child: Center(
              child: Text(_item.numero,
                  style: TextStyle(
                      fontFamily: 'Humanist',
                      color: _item.isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: BoxDecoration(
              color: _item.isSelected
                  ? Color.fromRGBO(189, 112, 162, 0.75)
                  : Colors.transparent,
              border: Border.all(
                  width: 2.0,
                  color: _item.isSelected
                      ? Color.fromRGBO(189, 112, 162, 0.75)
                      : Color.fromRGBO(189, 112, 162, 0.75)),
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  _item.nomeModulo + ".",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Humanist',
                    fontSize: 16,
                    shadows: _item.isSelected
                        ? <Shadow>[
                            Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: Colors.white.withOpacity(0.7)),
                            Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 8.0,
                                color: Colors.white.withOpacity(0.7)),
                          ]
                        : [],
                  ),
                )),
          )
        ],
      ),
    );
  }
}

