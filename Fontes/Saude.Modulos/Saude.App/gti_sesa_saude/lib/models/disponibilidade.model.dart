class DisponibilidadeModel {
 List<_Disponibilidade> _results = [];    
  
  DisponibilidadeModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['disponibilidades'].length);

    List<_Disponibilidade> temp = [];
    for (int i = 0; i < parsedJson['disponibilidades'].length; i++) {
      _Disponibilidade result = _Disponibilidade(parsedJson['disponibilidades'][i]);
      temp.add(result);
    }
    this._results = temp;    
  }  

  List<_Disponibilidade> getDisponibilidade(){
    return this._results.isEmpty ? [] : this._results;
  }
}

class _Disponibilidade {  
  String _unidade;
  String _medicacao;
  
  _Disponibilidade(result) {
    _unidade = result['unidade'];
    _medicacao = result['medicacao'];
    
  }
  
  String get unidade => _unidade;
  String get medicacao => _medicacao;
  
}
