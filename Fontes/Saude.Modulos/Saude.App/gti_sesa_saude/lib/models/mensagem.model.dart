class MensagemModel {  
  
  List<_Mensagem> _results = [];  

  MensagemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['mensagens'].length);

    List<_Mensagem> temp = [];
    for (int i = 0; i < parsedJson['mensagens'].length; i++) {
      _Mensagem result = _Mensagem(parsedJson['mensagens'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_Mensagem> getMensagem() {
    return this._results.isEmpty ? null : this._results;
  } 
  
}

class _Mensagem {      
  String _mensagem;
  String _tipoMensagem;

  _Mensagem(result) {
    _tipoMensagem  = result['tipoMensagem'];    
    _mensagem = result['mensagem'];    
  } 
  String get tipoMensagem => _tipoMensagem;  
  String get mensagem => _mensagem;  
}
