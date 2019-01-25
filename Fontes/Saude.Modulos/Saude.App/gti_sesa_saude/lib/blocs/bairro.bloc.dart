        import 'package:gti_sesa_saude/resources/repository.dart';
        import 'package:gti_sesa_saude/models/bairro.model.dart';
        import 'package:rxdart/rxdart.dart';


        class BairroBloc {  
          final _repository = Repository();
          final _bairroFetcher = PublishSubject<BairroModel>();
          Observable<BairroModel> get bairro => _bairroFetcher.stream;

          
          Future<BairroModel> fetchBairros() async {
            BairroModel bairro = await _repository.fetchBairros();
            _bairroFetcher.sink.add(bairro);
            return bairro;
          }  

          dispose() {
            _bairroFetcher.close();
          }
        }

        final bairroBloc = BairroBloc();
