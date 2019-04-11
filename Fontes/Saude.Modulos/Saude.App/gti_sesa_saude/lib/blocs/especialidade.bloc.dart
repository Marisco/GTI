        import 'package:gti_sesa_saude/resources/repository.dart';
        import 'package:gti_sesa_saude/models/especialidade.model.dart';
        import 'package:rxdart/rxdart.dart';


        class EspecialidadeBloc {  
          final _repository = Repository();
          final _especialidadeFetcher = PublishSubject<EspecialidadeModel>();
          Observable<EspecialidadeModel> get especialidade => _especialidadeFetcher.stream;

          
          Future<EspecialidadeModel> fetchEspecialidades( String moduloId, unidade,  dataInicio, dataFim) async {
            EspecialidadeModel especialidade = await _repository.fetchEspecialidades(moduloId, unidade, dataInicio, dataFim);
            _especialidadeFetcher.sink.add(especialidade);
            return especialidade;
          }  

          dispose() {
            _especialidadeFetcher.close();
          }
        }

        final especialidadeBloc = EspecialidadeBloc();
