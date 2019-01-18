        import 'package:gti_sesa_saude/resources/repository.dart';
        import 'package:gti_sesa_saude/models/unidade.model.dart';
        import 'package:rxdart/rxdart.dart';


        class UnidadeBloc {  
          final _repository = Repository();
          final _unidadeFetcher = PublishSubject<UnidadeModel>();
          Observable<UnidadeModel> get unidade => _unidadeFetcher.stream;

          
          Future<UnidadeModel> fetchUnidades() async {
            UnidadeModel unidade = await _repository.fetchUnidades();
            _unidadeFetcher.sink.add(unidade);
            return unidade;
          }  

          dispose() {
            _unidadeFetcher.close();
          }
        }

        final unidadeBloc = UnidadeBloc();
