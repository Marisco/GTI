import 'package:gti_sesa_saude/resources/saude.api.dart';
import 'package:gti_sesa_saude/models/paciente.model.dart';
import 'package:gti_sesa_saude/models/unidade.model.dart';
import 'package:gti_sesa_saude/models/especialidade.model.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';

class Repository {
  final saudeApi = SaudeApi();
  Future<PacienteModel> fetchPaciente(String documento, String dataNascimento) =>
      saudeApi.fetchPaciente(documento, dataNascimento);
  
  Future<UnidadeModel> fetchUnidades() => saudeApi.fetchUnidades();
  
  Future<EspecialidadeModel> fetchEspecialidades(
          String unidadeId, String dataInicio, String dataFim) =>
      saudeApi.fetchEspecialidades(unidadeId, dataInicio, dataFim);

  Future<ConsultaModel> fetchConsultas(String consultaId, String unidadeId, String especialidadeId,
          String dataInicio, String dataFim) =>
      saudeApi.fetchConsultas( consultaId, unidadeId, especialidadeId, dataInicio, dataFim);
  
  Future<ConsultaModel> fetchConsulta(String paciente, String especialidade) =>
      saudeApi.fetchConsulta(paciente, especialidade);

Future<MensagemModel> pushConsulta(String pacienteId, String consultaId) =>
      saudeApi.pushConsulta(pacienteId, consultaId);      
}
