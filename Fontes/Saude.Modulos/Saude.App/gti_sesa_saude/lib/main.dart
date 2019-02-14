import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gti_sesa_saude/ui/app.dart';
import 'package:gti_sesa_saude/ui/passo01.dart';
import 'package:intl/date_symbol_data_local.dart';
final Locale myLocale = new Locale("pt", "PT");

void main() => runApp(GtiSesaSaude());

class GtiSesaSaude extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromRGBO(41, 84, 142, 1),
    ));

    return MaterialApp(
      title: 'APP.Saúde.SESA',
      supportedLocales:[myLocale],    
      onGenerateRoute: (RouteSettings settings) {
        new TransicaoTela(builder: (_) => GtiSesaSaude());
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color.fromRGBO(41, 84, 142, 1)          
          ),
      home: new Passo01(),
    );
  }
}
