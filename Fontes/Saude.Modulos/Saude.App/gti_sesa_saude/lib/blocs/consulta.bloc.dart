import 'package:gti_sesa_saude/resources/repository.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';
import 'package:rxdart/rxdart.dart';

class ConsultaBloc {
  final _repository = Repository();
  final _consultaFetcher = PublishSubject<ConsultaModel>();
  Observable<ConsultaModel> get consulta => _consultaFetcher.stream;

  Future<ConsultaModel> fetchConsultas(String consulta, String unidade,
      String especialidade, String dataInicio, String dataFim) async {
    ConsultaModel consultaModel = await _repository.fetchConsultas(
        consulta, unidade, especialidade, dataInicio, dataFim);
    _consultaFetcher.sink.add(consultaModel);
    return consultaModel;
  }

  Future<ConsultaModel> fetchConsulta(
      String paciente, String especialidade) async {
    ConsultaModel consultaModel =
        await _repository.fetchConsulta(paciente, especialidade);
    _consultaFetcher.sink.add(consultaModel);
    return consultaModel;
  }

  Future<MensagemModel> pushConsulta(
      String pacienteId, String especialidadeId) async {
    MensagemModel mensagem =
        await _repository.pushConsulta(pacienteId, especialidadeId);
    return mensagem;
  }

  dispose() {
    _consultaFetcher.close();
  }
}

final consultaBloc = ConsultaBloc();
