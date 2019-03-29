        import 'package:gti_sesa_saude/resources/repository.dart';
        import 'package:gti_sesa_saude/models/modulo.model.dart';
        import 'package:rxdart/rxdart.dart';


        class ModuloBloc {  
          final _repository = Repository();
          final _moduloFetcher = PublishSubject<ModuloModel>();
          Observable<ModuloModel> get modulo => _moduloFetcher.stream;

          
          Future<ModuloModel> fetchModulos() async {
            ModuloModel modulo = await _repository.fetchModulos();
            _moduloFetcher.sink.add(modulo);
            return modulo;
          }  

          dispose() {
            _moduloFetcher.close();
          }
        }

        final moduloBloc = ModuloBloc();
