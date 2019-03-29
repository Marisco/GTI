        import 'package:gti_sesa_saude/resources/repository.dart';
        import 'package:gti_sesa_saude/models/avaliacao.model.dart';
        import 'package:rxdart/rxdart.dart';


        class AvaliacaoBloc {  
          final _repository = Repository();
          final _avaliacaoFetcher = PublishSubject<AvaliacaoModel>();
          Observable<AvaliacaoModel> get avaliacao => _avaliacaoFetcher.stream;

          
          Future<AvaliacaoModel> fetchAvaliacaos( String unidade, String dataInicio, String dataFim) async {
            AvaliacaoModel avaliacao = await _repository.fetchAvaliacoes();
            _avaliacaoFetcher.sink.add(avaliacao);
            return avaliacao;
          }  

          dispose() {
            _avaliacaoFetcher.close();
          }
        }

        final avaliacaoBloc = AvaliacaoBloc();
