import 'package:gti_sesa_saude/resources/repository.dart';
import 'package:gti_sesa_saude/models/disponibilidade.model.dart';
import 'package:rxdart/rxdart.dart';

class DisponibilidadeBloc {
  final _repository = Repository();
  final _disponibilidadeFetcher = PublishSubject<DisponibilidadeModel>();
  Observable<DisponibilidadeModel> get disponibilidade => _disponibilidadeFetcher.stream;

  Future<DisponibilidadeModel> fetchDisponibilidade(
      String nomeMedicao) async {
    DisponibilidadeModel disponibilidade =
        await _repository.fetchDisponibilidades(nomeMedicao);
    _disponibilidadeFetcher.sink.add(disponibilidade);
    return disponibilidade;
  }  

  dispose() {
    _disponibilidadeFetcher.close();
  }
}

final disponibilidadeBloc = DisponibilidadeBloc();
