class AvaliacaoModel {
  List<_Avaliacao> _results = [];

  AvaliacaoModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['avaliacoes'].length);

    List<_Avaliacao> temp = [];
    for (int i = 0; i < parsedJson['avaliacoes'].length; i++) {
      _Avaliacao result = _Avaliacao(parsedJson['avaliacoes'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_Avaliacao> getAvaliacoes() {
    return this._results.isEmpty ? [] : this._results;
  }
}

class _Avaliacao {
  String _numero;
  String _unidade;
  String _nomeUnidade;  
  String _dataAtendimento;
  String _especialidade;
  String _tipoAvaliacao;
  String _descricao;

  _Avaliacao(result) {
    _numero = result['numero'].toString();
    _unidade = result['unidade'].toString();
    _nomeUnidade = result['nome_unidade'].toString();    
    _dataAtendimento = result['data_atendimento'].toString();
    _especialidade = result['especialidade'].toString();
    _tipoAvaliacao = result['tipo_avaliacao'].toString();
    _descricao  = result['descricao'].toString();
  }

  String get numero => _numero;
  String get unidade => _unidade;
  String get nomeUnidade => _nomeUnidade;  
  String get dataAtendimento => _dataAtendimento;
  String get especialidade => _especialidade;
  String get tipoAvaliacao => _tipoAvaliacao;
  String get descricao => _descricao;
}
