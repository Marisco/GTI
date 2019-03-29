class ModuloModel {
  List<_Modulo> _results = [];

  ModuloModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['modulos'].length);

    List<_Modulo> temp = [];
    for (int i = 0; i < parsedJson['modulos'].length; i++) {
      _Modulo result = _Modulo(parsedJson['modulos'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_Modulo> getModulos() {
    return this._results.isEmpty ? null : this._results;
  }
}

class _Modulo {
  String _numero;
  String _nomeAplicativo;
  String _nomeModulo;
  String _icone;
  String _dataInicio;
  String _dataFim;
  
  _Modulo(result) {
    _numero = result['numero'].toString();    
    _nomeAplicativo =result['nome_aplicativo'];
    _nomeModulo =result['nome_modulo'];
    _icone =result['icone'];
    _dataInicio =result['data_inicio'];
    _dataFim =result['data_fim'];

  }

  String get numero => _numero;
  String get nomeAplicativo => _nomeAplicativo;
  String get nomeModulo => _nomeModulo;
  String get icone => _icone;
  String get dataInicio => _dataInicio;
  String get data => _dataFim;

}
