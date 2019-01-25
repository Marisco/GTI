import 'package:gti_sesa_saude/resources/repository.dart';
import 'package:gti_sesa_saude/models/paciente.model.dart';
import 'package:rxdart/rxdart.dart';

class PacienteBloc {
  final _repository = Repository();
  final _pacienteFetcher = PublishSubject<PacienteModel>();
  Observable<PacienteModel> get paciente => _pacienteFetcher.stream;

  Future<PacienteModel> fetchPaciente(
      String documento, String dataNascimento) async {
    PacienteModel paciente =
        await _repository.fetchPaciente(documento, dataNascimento);
    _pacienteFetcher.sink.add(paciente);
    return paciente;
  }

  Future<PacienteModel> pushPaciente(
      String nome,
      String cpf,
      String cartaoSus,
      String dataNascimento,
      String sexo,
      String telefone,
      String bairro) async {
    PacienteModel paciente =
        await _repository.pushPaciente(nome, cpf, cartaoSus, dataNascimento, sexo, telefone, bairro);
    _pacienteFetcher.sink.add(paciente);
    return paciente;
  }

  dispose() {
    _pacienteFetcher.close();
  }
}

final pacienteBloc = PacienteBloc();
