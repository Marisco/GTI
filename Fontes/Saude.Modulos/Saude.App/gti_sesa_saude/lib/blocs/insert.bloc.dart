import 'package:gti_sesa_saude/resources/repository.dart';
import 'package:gti_sesa_saude/models/insert.model.dart';
import 'package:rxdart/rxdart.dart';

class InsertBloc {
  final _repository = Repository();
  final _insertFetcher = PublishSubject<InsertModel>();
  Observable<InsertModel> get insert => _insertFetcher.stream;

  Future<InsertModel> pushPaciente(
      String nome,
      String cpf,
      String cartaoSus,
      String dataNascimento,
      String sexo,
      String telefone,
      String bairro) async {
    InsertModel paciente = await _repository.pushPaciente(
        nome, cpf, cartaoSus, dataNascimento, sexo, telefone, bairro);
    _insertFetcher.sink.add(paciente);
    return paciente;
  }

  dispose() {
    _insertFetcher.close();
  }
}

final insertBloc = InsertBloc();
