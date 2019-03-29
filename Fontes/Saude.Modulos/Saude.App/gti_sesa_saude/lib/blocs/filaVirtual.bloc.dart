import 'package:gti_sesa_saude/resources/repository.dart';
import 'package:gti_sesa_saude/models/filaVirtual.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';
import 'package:rxdart/rxdart.dart';

class FilaVirtualBloc {
  final _repository = Repository();
  final _filaVirtualFetcher = PublishSubject<FilaVirtualModel>();
  Observable<FilaVirtualModel> get filaVirtual => _filaVirtualFetcher.stream;

  Future<FilaVirtualModel> fetchFilasVirtuais(String filaVirtual, String unidade,
      String especialidade, String dataInicio, String dataFim) async {
    FilaVirtualModel filaVirtualModel = await _repository.fetchFilasVirtuais(
        filaVirtual, unidade, especialidade, dataInicio, dataFim);
    _filaVirtualFetcher.sink.add(filaVirtualModel);
    return filaVirtualModel;
  }

  Future<FilaVirtualModel> fetchFilaVirtual(
      String paciente, String especialidade) async {
    FilaVirtualModel filaVirtualModel =
        await _repository.fetchFilaVirtual(paciente, especialidade);
    _filaVirtualFetcher.sink.add(filaVirtualModel);
    return filaVirtualModel;
  }

  Future<MensagemModel> pushFilaVirtual(
      String pacienteId, String filaVirtualId) async {
    MensagemModel mensagem =
        await _repository.pushFilaVirtual(pacienteId, filaVirtualId);
    return mensagem;
  }

  dispose() {
    _filaVirtualFetcher.close();
  }
}

final filaVirtualBloc = FilaVirtualBloc();
