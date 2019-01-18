class PacienteModel {
 List<_Paciente> _results = [];    
  
  PacienteModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['paciente'].length);

    List<_Paciente> temp = [];
    for (int i = 0; i < parsedJson['paciente'].length; i++) {
      _Paciente result = _Paciente(parsedJson['paciente'][i]);
      temp.add(result);
    }
    this._results = temp;    
  }  

  _Paciente getPaciente(){
    return  this._results.isEmpty ? null:this._results[0] ;
  }
}

class _Paciente {
  String _numero;
  String _nome;
  String _cpf;
  String _telefone;
  String _celular;
  String _cartaoSus;
  String _dataNascimento;
  String _sexo;
  String _rg;
  String _rgUf;
  String _estadoCivil;
  String _endereco;
  String _observacao;
  String _anonimo;

  _Paciente(result) {
    _numero = result['numero'].toString();
    _nome = result['nome'];
    _cpf = result['cpf'];
    _telefone = result['telefone'];
    _celular = result['celular'];
    _cartaoSus = result['cartao_us'];
    _dataNascimento = result['data_nascimento'];
    _sexo = result['sexo'];
    _rg = result['rg'];
    _rgUf = result['rg_uf'];
    _estadoCivil = result['estado_civil'];
    _endereco = result['endereco'];
    _observacao = result['observacao'];
    _anonimo = result['anonimo'];
  }
  
  String get numero => _numero;
  String get nome => _nome;
  String get telefone => _telefone;
  String get cartaoSus => _cartaoSus;
  String get celular => _celular;
  String get cpf => _cpf;
  String get dataNascimento => _dataNascimento;
  String get sexo => _sexo;
  String get rg => _rg;
  String get rgUf => _rgUf;
  String get estadoCivil => _estadoCivil;
  String get endereco => _endereco;
  String get observacao => _observacao;
  String get anonimo => _anonimo;

}
