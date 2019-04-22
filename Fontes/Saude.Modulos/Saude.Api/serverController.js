const objModels = require("../Saude.Mod/Models");
const objValidacao = require('./validacao')

var obterPaciente = function (req, res) {

    var validarCampos = objValidacao.validarCampos(req.body);
    var models = objModels.ObjPaciente;

    if (validarCampos == "") {
        models.obterPaciente(objModels.dbMysql, req.body, (e, data) => {
            if (e) {
                res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] });
            } else {
                res.json({ paciente: data });
            };
        });
    } else {
        res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: validarCampos }] });
    };
};

var obterDadosPaciente = function (req, res) {
    var models = objModels.ObjPaciente;
    models.obterDadosPaciente(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] });
        } else {
            res.json({ dadosPaciente: data })
        };
    })

};

var obterUnidades = function (req, res) {
    var models = objModels.ObjUnidade;
    models.obterUnidades(objModels.dbMysql, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] });
        } else {
            res.json({ unidades: data });
        };
    });
};


var obterBairros = function (req, res) {
    var models = objModels.ObjBairro;
    models.obterBairros(objModels.dbMysql, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] });
        } else {
            res.json({ bairros: data });
        };
    });
};

var obterEspecialidades = function (req, res) {
    var models = objModels.ObjEspecialidade;
    models.obterEspecialidades(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send("Não foi possível localizar o registro:" + e);
        } else {
            res.json({ especialidades: data });
        };
    });
};

var obterConsultas = function (req, res) {
    var models = objModels.ObjConsulta;
    models.obterConsultas(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] });
        } else {
            res.json({ consultas: data });
        };
    });
};
var agendarConsulta = function (req, res) {
    var models = objModels.ObjConsulta;
    models.agendarConsulta(objModels.dbMysql, req.body, (e, data) => {
        if (e || (data.affectedRows == 0)) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível realizar o agendamento.\nTente novamente." + e }] });
        } else {
            res.json({ mensagens: [{ tipoMensagem: "Sucesso", mensagem: "Agendamento realizado com sucesso." }] });
        };
    });
};

var inserirPaciente = function (req, res) {
    var validarCampos = objValidacao.validarCampos(req.body);

    if (validarCampos == "") {
        var models = objModels.ObjPaciente;
        models.inserirPaciente(objModels.dbMysql, req.body, (e, data) => {
            if (e) {
                res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível inserir o registro:" + e }] });
            } else {
                res.json({ inserts: data });
            };
        });
    } else {
        res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: validarCampos }] });
    };
};

var obterModulos = function (req, res) {
    var models = objModels.ObjModulo;
    models.obterModulos(objModels.dbMysql, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] });
        } else {
            res.json({ modulos: data });
        };
    });
};

var obterDisponibilidades = function (req, res) {
    var models = objModels.objDisponibilidade;
    models.obterDisponibilidades(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] });
        } else {
            res.json({ disponibilidades: data });
        };
    });
};


var obterAvaliacoes = function (req, res) {
    var models = objModels.ObjAvaliacao;
    models.obterAvaliacoes(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] });
        } else {
            res.json({ avaliacoes: data });
        };
    });
};

var inserirAvaliacao = function (req, res) {
    var validarCampos = objValidacao.validarCampos(req.body);

    if (validarCampos == "") {
        var models = objModels.ObjAvaliacao;
        models.inserirAvaliacao(objModels.dbMysql, req.body, (e, data) => {
            if (e) {
                res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível inserir o registro:" + e }] });
            } else {
                res.json({ mensagens: [{ tipoMensagem: "Sucesso", mensagem: "Avaliação realizada com sucesso." }] });
            }
        });
    } else {
        res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: validarCampos }] });
    };
};



var obterFilasVirtuais = function (req, res) {
    var models = objModels.ObjFilaVirtual;
    models.obterFilasVirtuais(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] });
        } else {
            res.json({ filasVirtuais: data });
        };
    });
};
var inserirFilaVirtual = function (req, res) {
    var models = objModels.ObjFilaVirtual;
    var pacienteId = req.body.pacienteId
    var filaVirtualId = req.body.filaVirtualId
    models.inserirFilaVirtual(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível inserir o registro:" + e }] });
        } else {
            models.obterItemFilaVirtual(objModels.dbMysql, filaVirtualId, (e, data) => {
                if (e) {
                    res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] });
                } else {
                    var cont = 0;
                    for (cont == 0; cont <= data.length; cont++) {
                        if (data[cont].paciente == pacienteId) {
                            cont++
                            break;
                        };

                    };
                    res.json({ mensagens: [{ tipoMensagem: "Sucesso", mensagem: "Operação realizada com sucesso.\nVocê foi registrado na " + cont + "ª possição da fila" }] });
                };
            });

        }
    });
};

module.exports = {
    obterPaciente: obterPaciente,
    obterUnidades: obterUnidades,
    obterEspecialidades: obterEspecialidades,
    obterConsultas: obterConsultas,
    agendarConsulta: agendarConsulta,
    inserirPaciente: inserirPaciente,
    obterBairros: obterBairros,
    obterModulos: obterModulos,
    obterAvaliacoes: obterAvaliacoes,
    obterFilasVirtuais: obterFilasVirtuais,
    inserirAvaliacao: inserirAvaliacao,
    inserirFilaVirtual: inserirFilaVirtual,
    obterDadosPaciente: obterDadosPaciente,
    obterDisponibilidades: obterDisponibilidades
}