class FilaVirtualModel {
  List<_FilaVirtual> _results = [];

  FilaVirtualModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['filasVirtuais'].length);

    List<_FilaVirtual> temp = [];
    for (int i = 0; i < parsedJson['filasVirtuais'].length; i++) {
      _FilaVirtual result = _FilaVirtual(parsedJson['filasVirtuais'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_FilaVirtual> getFilasVirtuais() {
    return this._results.isEmpty ? [] : this._results;
  }
}

class _FilaVirtual {    
  String _numero;
  String _unidade;  
  String _especialidade;  
  String _dataInicio;
  String _dataFim;

  _FilaVirtual(result) {
    _numero = result['numero'].toString();
    _unidade = result['unidade_nome'];    
    _especialidade = result['especialidade_nome'];    
    _dataInicio = result['data_inicio'];
    _dataFim = result['data_fim'];
  }

  String get numero => _numero;
  String get unidade => _unidade;  
  String get especialidade => _especialidade;  
  String get dataInicio => _dataInicio;
  String get dataFim => _dataFim;

}
