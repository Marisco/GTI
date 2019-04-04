import 'package:http/http.dart' show Client;
import 'dart:convert';
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

class SaudeApi {
  Client client = new Client();

  Future<PacienteModel> fetchPaciente(
      String documento, String dataNascimento) async {
    documento = documento.replaceAll('.', '').replaceAll('-', '');
    dataNascimento = dataNascimento != ""
        ? dataNascimento = dataNascimento.substring(6, 10) +
            "-" +
            dataNascimento.substring(3, 5) +
            "-" +
            dataNascimento.substring(0, 2)
        : "";

    String tipoDocumento = documento.length == 11 ? "cpf" : "cartaoSus";

    Map data = {tipoDocumento: documento, "dataNascimento": dataNascimento};

    final response = await client
        .post("http://10.0.13.133:3010/saude/getPaciente",
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: json.encode(data),
            encoding: Encoding.getByName("utf-8"))
        .timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return PacienteModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }

  Future<UnidadeModel> fetchUnidades() async {
    final response = await client
        .get("http://10.0.13.133:3010/saude/getUnidades", headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    }).timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return UnidadeModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }

  Future<EspecialidadeModel> fetchEspecialidades(
      String unidadeId, String dataInicio, String dataFim) async {
    Map data = {
      "unidadeId": unidadeId,
      "dataInicio": dataInicio,
      "dataFim": dataFim
    };

    final response = await client
        .post("http://10.0.13.133:3010/saude/getEspecialidades",
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: json.encode(data),
            encoding: Encoding.getByName("utf-8"))
        .timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return EspecialidadeModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
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

    final response = await client
        .post("http://10.0.13.133:3010/saude/getConsultas",
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: json.encode(data),
            encoding: Encoding.getByName("utf-8"))
        .timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return ConsultaModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }

  Future<ConsultaModel> fetchConsulta(
      String pacienteId, String especialidadeId) async {
    Map data = {"pacienteId": pacienteId, "especialidadeId": especialidadeId};

    final response = await client
        .post("http://10.0.13.133:3010/saude/getConsultas",
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: json.encode(data),
            encoding: Encoding.getByName("utf-8"))
        .timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return ConsultaModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }

  Future<MensagemModel> pushConsulta(
      String pacienteId, String consultaId) async {
    Map data = {"pacienteId": pacienteId, "consultaId": consultaId};

    final response = await client.post(
        "http://10.0.13.133:3010/saude/postConsulta",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return MensagemModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
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

    final response = await client
        .post("http://10.0.13.133:3010/saude/postPaciente",
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: json.encode(data),
            encoding: Encoding.getByName("utf-8"))
        .timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return InsertModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }

  Future<BairroModel> fetchBairros() async {
    final response = await client
        .get("http://10.0.13.133:3010/saude/getBairros", headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    }).timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return BairroModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }

  Future<ModuloModel> fetchModulos() async {
    final response = await client
        .get("http://10.0.13.133:3010/saude/getModulos", headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    }).timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return ModuloModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }

  Future<AvaliacaoModel> fetchAvaliacoes() async {
    final response = await client
        .get("http://10.0.13.133:3010/saude/getAvaliacoes", headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    }).timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return AvaliacaoModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }

  Future<FilaVirtualModel> fetchFilasVirtuais(
      String filaVirtualId,
      String unidadeId,
      String especialidadeId,
      String dataInicio,
      String dataFim) async {
    Map data = {
      "filaVirtualId": filaVirtualId,
      "unidadeId": unidadeId,
      "especialidadeId": especialidadeId,
      "dataInicio": dataInicio,
      "dataFim": dataFim
    };

    final response = await client
        .post("http://10.0.13.133:3010/saude/getFilasVirtuais",
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: json.encode(data),
            encoding: Encoding.getByName("utf-8"))
        .timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return FilaVirtualModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }

  Future<FilaVirtualModel> fetchFilaVirtual(
      String pacienteId, String filaVirtualId) async {
    Map data = {"pacienteId": pacienteId, "especialidadeId": filaVirtualId};

    final response = await client
        .post("http://10.0.13.133:3010/saude/getFilaVirtual",
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: json.encode(data),
            encoding: Encoding.getByName("utf-8"))
        .timeout(Duration(seconds: 5));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return FilaVirtualModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }

  Future<MensagemModel> pushFilaVirtual(
      String pacienteId, String filaVirtualId) async {
    Map data = {"pacienteId": pacienteId, "filaVirtualId": filaVirtualId};

    final response = await client.post(
        "http://10.0.13.133:3010/saude/postFilaVirtual",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));
    print(response.body.toString());
    //client.close();
    if (response.statusCode == 200) {
      return MensagemModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }
}
