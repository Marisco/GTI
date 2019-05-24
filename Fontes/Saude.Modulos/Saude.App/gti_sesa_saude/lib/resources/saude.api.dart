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
import 'package:gti_sesa_saude/models/disponibilidade.model.dart';

class SaudeApi {
  Client client = new Client();
  String ipApi = "gti.serra.es.gov.br:8084"; // api
  //String ipApi = "10.0.13.133:3010"; // local

  Future<PacienteModel> fetchPaciente(String documento, dataNascimento) async {
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
        .post("http://"+ipApi+"/saude/getPaciente",
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
        .get("http://"+ipApi+"/saude/getUnidades", headers: {
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
      String moduloId, unidadeId, dataInicio, dataFim) async {
    Map data = {
      "moduloId": moduloId,
      "unidadeId": unidadeId,
      "dataInicio": dataInicio,
      "dataFim": dataFim
    };

    final response = await client
        .post("http://"+ipApi+"/saude/getEspecialidades",
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

  Future<ConsultaModel> fetchConsultas(String consultaId, unidadeId,
      especialidadeId, dataInicio, dataFim) async {
    Map data = {
      "consultaId": consultaId,
      "unidadeId": unidadeId,
      "especialidadeId": especialidadeId,
      "dataInicio": dataInicio,
      "dataFim": dataFim
    };

    final response = await client
        .post("http://"+ipApi+"/saude/getConsultas",
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
      String pacienteId, especialidadeId) async {
    Map data = {"pacienteId": pacienteId, "especialidadeId": especialidadeId};

    final response = await client
        .post("http://"+ipApi+"/saude/getConsultas",
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

  Future<MensagemModel> pushConsulta(String pacienteId, consultaId) async {
    Map data = {"pacienteId": pacienteId, "consultaId": consultaId};

    final response = await client.post(
        "http://"+ipApi+"/saude/postConsulta",
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

  Future<InsertModel> pushPaciente(String nome, cpf, cartaoSus, dataNascimento,
      sexo, telefone, bairro) async {
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
        .post("http://"+ipApi+"/saude/postPaciente",
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
        .get("http://"+ipApi+"/saude/getBairros", headers: {
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
        .get("http://"+ipApi+"/saude/getModulos", headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    }).timeout(Duration(seconds: 15));
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

  Future<AvaliacaoModel> fetchAvaliacoes(String pacienteId) async {
    Map data = {"pacienteId": pacienteId};
    final response = await client
        .post("http://"+ipApi+"/saude/getAvaliacoes",
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: json.encode(data),
            encoding: Encoding.getByName("utf-8"))
        .timeout(Duration(seconds: 40));

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

  Future<MensagemModel> pushAvaliacao(String pacienteId, tipoAvaliacao,
      dataAtendimento, nota, texto, celular, atendimento) async {
    dataAtendimento = dataAtendimento = dataAtendimento.substring(6, 10) +
        "-" +
        dataAtendimento.substring(3, 5) +
        "-" +
        dataAtendimento.substring(0, 2);

    Map data = {
      "pacienteId": pacienteId,
      "tipoAvaliacao": tipoAvaliacao,
      "dataAtendimento": dataAtendimento,
      "nota": nota,
      "texto": texto,
      "celular": celular,
      "atendimento": atendimento
    };

    final response = await client.post(
        "http://"+ipApi+"/saude/postAvaliacao",
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

  Future<FilaVirtualModel> fetchFilasVirtuais(
      String filaVirtualId, unidadeId) async {
    Map data = {"filaVirtualId": filaVirtualId, "unidadeId": unidadeId};

    final response = await client
        .post("http://"+ipApi+"/saude/getFilasVirtuais",
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
      String pacienteId, especialidadeId) async {
    Map data = {"pacienteId": pacienteId, "especialidadeId": especialidadeId};

    final response = await client
        .post("http://"+ipApi+"/saude/getFilaVirtual",
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
      String pacienteId, filaVirtualId) async {
    Map data = {"pacienteId": pacienteId, "filaVirtualId": filaVirtualId};

    final response = await client.post(
        "http://"+ipApi+"/saude/postFilaVirtual",
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
Future<DisponibilidadeModel> fetchDisponibilidades(String nomeMedicao) async {
    Map data = {'nomeMedicao': nomeMedicao};
    final response = await client
        .post("http://"+ipApi+"/saude/getDisponibilidades",
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: json.encode(data),
            encoding: Encoding.getByName("utf-8"))
        .timeout(Duration(seconds: 30)); 
    print(response.body.toString());    
    if (response.statusCode == 200) {
      return DisponibilidadeModel.fromJson(json.decode(response.body));
    } else {
      MensagemModel mensagem =
          MensagemModel.fromJson(json.decode(response.body));
      throw Exception(mensagem.getMensagem()[0].mensagem.toString());
    }
  }




}
