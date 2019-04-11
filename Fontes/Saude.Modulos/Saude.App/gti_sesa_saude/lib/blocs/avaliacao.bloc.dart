import 'package:gti_sesa_saude/resources/repository.dart';
import 'package:gti_sesa_saude/models/avaliacao.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';
import 'package:rxdart/rxdart.dart';

class AvaliacaoBloc {
  final _repository = Repository();
  final _avaliacaoFetcher = PublishSubject<AvaliacaoModel>();
  Observable<AvaliacaoModel> get avaliacao => _avaliacaoFetcher.stream;

  Future<AvaliacaoModel> fetchAvaliacoes(String pacienteId) async {
    AvaliacaoModel avaliacao = await _repository.fetchAvaliacoes(pacienteId);
    _avaliacaoFetcher.sink.add(avaliacao);
    return avaliacao;
  }

  Future<MensagemModel> pushAvaliacao(
      String pacienteId,
          tipoAvaliacao,
          dataAtendimento,
          nota,
          texto,          
          celular,
          numeroAtendimento) async {
    MensagemModel mensagem =
        await _repository.pushAvaliacao(pacienteId, tipoAvaliacao, dataAtendimento, nota, texto, celular, numeroAtendimento);
    return mensagem;
  }

  dispose() {
    _avaliacaoFetcher.close();
  }
}

final avaliacaoBloc = AvaliacaoBloc();
