import 'package:gti_sesa_saude/resources/repository.dart';
import 'package:gti_sesa_saude/models/filaVirtual.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';
import 'package:rxdart/rxdart.dart';

class FilaVirtualBloc {
  final _repository = Repository();
  final _filaVirtualFetcher = PublishSubject<FilaVirtualModel>();
  Observable<FilaVirtualModel> get filaVirtual => _filaVirtualFetcher.stream;

  Future<FilaVirtualModel> fetchFilasVirtuais(String filaVirtual, unidade) async {
    FilaVirtualModel filaVirtualModel = await _repository.fetchFilasVirtuais(
        filaVirtual, unidade);
    _filaVirtualFetcher.sink.add(filaVirtualModel);
    return filaVirtualModel;
  }

  // Future<FilaVirtualModel> fetchFilaVirtual(String consulta, unidade,
  //     dataInicio, dataFim) async {
  //   FilaVirtualModel filaVirtualModel =
  //       await _repository.fetchFilaVirtual(consulta, unidade, dataInicio, dataFim);
  //   _filaVirtualFetcher.sink.add(filaVirtualModel);
  //   return filaVirtualModel;
  // }

  Future<MensagemModel> pushFilaVirtual(
      String pacienteId, filaVirtualId) async {
    MensagemModel mensagem =
        await _repository.pushFilaVirtual(pacienteId, filaVirtualId);
    return mensagem;
  }

  dispose() {
    _filaVirtualFetcher.close();
  }
}

final filaVirtualBloc = FilaVirtualBloc();
