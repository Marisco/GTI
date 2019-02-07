import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:gti_sesa_saude/models/paciente.model.dart';
import 'package:gti_sesa_saude/models/unidade.model.dart';
import 'package:gti_sesa_saude/models/especialidade.model.dart';
import 'package:gti_sesa_saude/models/consulta.model.dart';
import 'package:gti_sesa_saude/models/mensagem.model.dart';
import 'package:gti_sesa_saude/models/bairro.model.dart';
import 'package:gti_sesa_saude/models/insert.model.dart';

class SaudeApi {
  Client client = Client();

  Future<PacienteModel> fetchPaciente(
      String documento, String dataNascimento) async {
    documento = documento.replaceAll('.', '').replaceAll('-', '');
    dataNascimento = dataNascimento != "" ?
    dataNascimento = dataNascimento.substring(6, 10) +
        "-" +
        dataNascimento.substring(3, 5) +
        "-" +
        dataNascimento.substring(0, 2) : "";

    String tipoDocumento = documento.length == 11 ? "cpf" : "cartaoSus";

    Map data = {tipoDocumento: documento, "dataNascimento": dataNascimento};

    print("entered");
    final response = await client.post(
        "http://172.16.64.12:3010/saude/getPaciente",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return PacienteModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel teste = MensagemModel.fromJson(json.decode(response.body));
      throw Exception(teste.getMensagem()[0].mensagem.toString());        
    }
  }

  Future<UnidadeModel> fetchUnidades() async {
    final response = await client
        .get("http://172.16.64.12:3010/saude/getUnidades", headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    print(response.body.toString());
    if (response.statusCode == 200) {
      return UnidadeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro');
    }
  }

  Future<EspecialidadeModel> fetchEspecialidades(
      String unidadeId, String dataInicio, String dataFim) async {
    Map data = {
      "unidadeId": unidadeId,
      "dataInicio": dataInicio,
      "dataFim": dataFim
    };

    final response = await client.post(
        "http://172.16.64.12:3010/saude/getEspecialidades",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return EspecialidadeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro');
    }
  }

  Future<ConsultaModel> fetchConsultas(String consultaId, String unidadeId,
      String especialidadeId, String dataInicio, String dataFim) async {
    Map data = {
      "consultaId": consultaId,
      "unidadeId": unidadeId,
      "especialidadeId": especialidadeId,
      "dataInicio": dataInicio,
      "dataFim": dataFim
    };

    final response = await client.post(
        "http://172.16.64.12:3010/saude/getConsultas",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ConsultaModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro');
    }
  }

  Future<ConsultaModel> fetchConsulta(
      String pacienteId, String especialidadeId) async {
    Map data = {"pacienteId": pacienteId, "especialidadeId": especialidadeId};

    final response = await client.post(
        "http://172.16.64.12:3010/saude/getConsultas",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ConsultaModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro');
    }
  }

  Future<MensagemModel> pushConsulta(
      String pacienteId, String consultaId) async {
    Map data = {"pacienteId": pacienteId, "consultaId": consultaId};

    final response = await client.post(
        "http://172.16.64.12:3010/saude/postConsulta",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MensagemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro');
    }
  }

  Future<InsertModel> pushPaciente(
      String nome,
      String cpf,
      String cartaoSus,
      String dataNascimento,
      String sexo,
      String telefone,
      String bairro) async {
    dataNascimento = dataNascimento.substring(6, 10) +
        "-" +
        dataNascimento.substring(3, 5) +
        "-" +
        dataNascimento.substring(0, 2);
    Map data = {
      "nome": nome,
      "cpf": cpf.replaceAll(".", "").replaceAll("-", ""),
      "cartaoSus": cartaoSus,
      "dataNascimento": dataNascimento,
      "sexo": sexo,
      "telefone": telefone,
      "bairro": bairro
    };

    final response = await client.post(
        "http://172.16.64.12:3010/saude/postPaciente",         
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return InsertModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro');
    }
  }

  Future<BairroModel> fetchBairros() async {
    final response = await client
        .get("http://172.16.64.12:3010/saude/getBairros", headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    print(response.body.toString());
    if (response.statusCode == 200) {
      return BairroModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro');
    }
  }
}
