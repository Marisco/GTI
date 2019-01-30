class InsertModel {
  List<_Insert> _results = [];

  InsertModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['inserts'].length);

    List<_Insert> temp = [];
    //for (int i = 0; i < parsedJson['inserts'].length; i++) {
      _Insert result = _Insert(parsedJson['inserts']);
      temp.add(result);
    //}
    this._results = temp;
  }
  List<_Insert> getInsertId() {
    return this._results.isEmpty ? null : this._results;
  }
}

class _Insert {
  String _numero;  

  _Insert(result) {
    _numero = result['insertId'].toString();   
  }

  String get numero => _numero;
  
}
