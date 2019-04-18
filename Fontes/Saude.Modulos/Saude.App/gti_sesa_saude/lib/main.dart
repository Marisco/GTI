import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/ui/identificacao.dart';
import 'package:gti_sesa_saude/ui/principal.dart';
//import 'package:intl/date_symbol_data_local.dart';

void main() => runApp(GtiSesaSaude());

class GtiSesaSaude extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor:
            Colors.blue[900] //Color.fromRGBO(41, 84, 142, 1),
        ));

    return MaterialApp(
      title: 'Serra-Saúde',
      //supportedLocales:[const Locale('pt', 'BR')],
      onGenerateRoute: (RouteSettings settings) {
        TransicaoTela(builder: (_) => GtiSesaSaude());
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color.fromRGBO(41, 84, 142, 1),
          disabledColor: Colors.white,
          unselectedWidgetColor: Colors.white.withOpacity(0.75)),
      home: Principal(child: Identificacao())      
    );
  }
}
