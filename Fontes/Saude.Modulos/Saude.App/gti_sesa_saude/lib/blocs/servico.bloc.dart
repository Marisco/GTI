        import 'package:gti_sesa_saude/resources/repository.dart';
        import 'package:gti_sesa_saude/models/servico.model.dart';
        import 'package:rxdart/rxdart.dart';


        class ServicoBloc {  
          final _repository = Repository();
          final _servicoFetcher = PublishSubject<ServicoModel>();
          Observable<ServicoModel> get unidade => _servicoFetcher.stream;

          
          Future<ServicoModel> fetchUnidades() async {
            ServicoModel servico = await _repository.fetchUnidades();
            _servicoFetcher.sink.add(servico);
            return servico;
          }  

          dispose() {
            _servicoFetcher.close();
          }
        }

        final servicoBloc = ServicoBloc();
