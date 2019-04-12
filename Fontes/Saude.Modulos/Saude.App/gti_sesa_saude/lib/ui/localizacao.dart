import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gti_sesa_saude/src/app.dart';
import 'package:gti_sesa_saude/src/enun.dart';
import 'package:gti_sesa_saude/ui/principal.dart';
import 'package:gti_sesa_saude/ui/identificacao.dart';

class Localizacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Localizacao();
  }
}

class _Localizacao extends StatefulWidget {
  @override
  State<_Localizacao> createState() => _LocalizacaoState();
}

class _LocalizacaoState extends State<_Localizacao> {  
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-20.218265, -40.249677),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-20.218265, -40.249677),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414
      );
  DialogState _dialogState = DialogState.DISMISSED;      

  Future<void> _getLocalizacao() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  void initState() {
    _getLocalizacao();
    super.initState();
  }

  
  Widget _getCorpoLocalizacao() {
    return GoogleMap(
        mapType: MapType.normal,        
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        }      
    );
  }  

  
@override
  Widget build(BuildContext context) {
    var principal = Principal.of(context);
    principal.imagemFundo = AssetImage("img/background.png");
    principal.txtCabecalho = "";
    principal.txtCorpo = _dialogState == DialogState.DISMISSED
        ? ""
        : "";
    principal.txtRodape = "";
    principal.txtBarraAcao = "";
    principal.txtBarraInferior = "Desenvolvido por GTI-SESA";
    principal.dialogState = this._dialogState;
    principal.widgetCorpo = _getCorpoLocalizacao();
    principal.alturaVariada = 0.7;
    principal.widgetRodape = null;
    principal.dialogState = this._dialogState;
    principal.dialogColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.45);
    principal.rodapeColor = Color.fromRGBO(41, 84, 142, 1).withOpacity(0.85);
    principal.dialogTxtBtnCancel =
        _dialogState == DialogState.ERROR ? "" : "Não";
    principal.dialogSlideRightBtnCancel =
        SlideRightRoute(builder: (_) => Principal(child: Identificacao()));
    principal.dialogTxtBtnOK = _dialogState == DialogState.ERROR ? "" : "Sim";
    principal.dialogSlideRightBtnOK = SlideRightRoute(builder: (_) => Principal(child: Identificacao()));
    principal.dialogTxtLoading = "Localizando ";
    principal.dialogTxtMensagem = "";
    principal.dialogTxtTitulo = "";

    return principal.setPrincipal();
  }


}