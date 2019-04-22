import 'package:gti_sesa_saude/resources/saude.api.dart';
import 'package:gti_sesa_saude/models/paciente.model.dart';
import 'package:gti_sesa_saude/models/unidade.model.dart';
import 'package:gti_sesa_saude/models/especialidade.model.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';
import 'package:gti_sesa_saude/models/bairro.model.dart';
import 'package:gti_sesa_saude/models/insert.model.dart';
import 'package:gti_sesa_saude/models/modulo.model.dart';
import 'package:gti_sesa_saude/models/avaliacao.model.dart';
import 'package:gti_sesa_saude/models/filaVirtual.model.dart';
import 'package:gti_sesa_saude/models/disponibilidade.model.dart';

class Repository {
  final saudeApi = SaudeApi();

  Future<PacienteModel> fetchPaciente(String documento, dataNascimento) =>
      saudeApi.fetchPaciente(documento, dataNascimento);

  Future<UnidadeModel> fetchUnidades() => saudeApi.fetchUnidades();

  Future<EspecialidadeModel> fetchEspecialidades(
          String moduloId, unidadeId, dataInicio, dataFim) =>
      saudeApi.fetchEspecialidades(moduloId, unidadeId, dataInicio, dataFim);

  Future<ConsultaModel> fetchConsultas(
          String consultaId, unidadeId, especialidadeId, dataInicio, dataFim) =>
      saudeApi.fetchConsultas(
          consultaId, unidadeId, especialidadeId, dataInicio, dataFim);

  Future<ConsultaModel> fetchConsulta(String paciente, especialidade) =>
      saudeApi.fetchConsulta(paciente, especialidade);

  Future<MensagemModel> pushConsulta(String pacienteId, consultaId) =>
      saudeApi.pushConsulta(pacienteId, consultaId);

  Future<InsertModel> pushPaciente(String nome, cpf, cartaoSus, dataNascimento,
          sexo, telefone, bairro) =>
      saudeApi.pushPaciente(
          nome, cpf, cartaoSus, dataNascimento, sexo, telefone, bairro);

  Future<BairroModel> fetchBairros() => saudeApi.fetchBairros();

  Future<ModuloModel> fetchModulos() => saudeApi.fetchModulos();

  Future<AvaliacaoModel> fetchAvaliacoes(String pacienteId) =>
      saudeApi.fetchAvaliacoes(pacienteId);

  Future<MensagemModel> pushAvaliacao(String pacienteId, tipoAvaliacao,
          dataAtendimento, nota, texto, celular, numeroAtendimento) =>
      saudeApi.pushAvaliacao(pacienteId, tipoAvaliacao, dataAtendimento, nota,
          texto, celular, numeroAtendimento);

  Future<MensagemModel> pushFilaVirtual(String pacienteId, filaVirtualId) =>
      saudeApi.pushFilaVirtual(pacienteId, filaVirtualId);

  Future<FilaVirtualModel> fetchFilasVirtuais(
          String filaVirtualId, unidadeId) =>
      saudeApi.fetchFilasVirtuais(filaVirtualId, unidadeId);

  Future<DisponibilidadeModel> fetchDisponibilidades(String nomeMedicao) =>
      saudeApi.fetchDisponibilidades(nomeMedicao);
}
