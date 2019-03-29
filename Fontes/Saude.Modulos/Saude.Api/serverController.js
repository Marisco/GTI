const objModels = require("../Saude.Mod/Models");
const objValidacao = require('./validacao')

var obterPaciente = function (req, res) {

    var validarCampos = objValidacao.validarCampos(req.body);    
    var models = objModels.ObjPaciente;
    
    // models.validarPaciente(objModels.dbMysql, req.body, (e, data) => {
    //     if (e) {
    //         res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível validar o usuário:" + e }] })
    //     }        
    //     var consultasPaciente = data[0].qtd;
    //     if (validarCampos == "" && consultasPaciente == 0) {

            models.obterPaciente(objModels.dbMysql, req.body, (e, data) => {
                if (e) {
                    res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] })
                } else {
                    res.json({ paciente: data })
                }
            })
        // } else {
        //     res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: validarCampos !== "" ? validarCampos : "Você já possui "+ consultasPaciente +" consulta(s) agendada(s)."}] })
        // }
    //})

    
};

var obterUnidades = function (req, res) {
    var models = objModels.ObjUnidade;
    models.obterUnidades(objModels.dbMysql, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] })
        } else {
            res.json({ unidades: data })
        }
    })
};


var obterBairros = function (req, res) {
    var models = objModels.ObjBairro;
    models.obterBairros(objModels.dbMysql, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] })
        } else {
            res.json({ bairros: data })
        }
    })
};

var obterEspecialidades = function (req, res) {
    var models = objModels.ObjEspecialidade;
    models.obterEspecialidades(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send("Não foi possível localizar o registro:" + e);
        } else {
            res.json({ especialidades: data })
        }
    })
};

var obterConsultas = function (req, res) {  
    var models = objModels.ObjConsulta;
    models.obterConsultas(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] })
        } else {
            res.json({ consultas: data })
        }
    })
};
var agendarConsulta = function (req, res) {
    var models = objModels.ObjConsulta;
    models.agendarConsulta(objModels.dbMysql, req.body, (e, data) => {
        if (e || (data.affectedRows == 0)) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível realizar o agendamento.\nTente novamente." + e }] })
        } else {
            res.json({ mensagens: [{ tipoMensagem: "Sucesso", mensagem: "Agendamento realizado com sucesso." }] })
        }
    })
};

var inserirPaciente = function (req, res) {
    var validarCampos = objValidacao.validarCampos(req.body);

    if (validarCampos == "") {
        var models = objModels.ObjPaciente;
        models.inserirPaciente(objModels.dbMysql, req.body, (e, data) => {
            if (e) {
                res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível inserir o registro:" + e }] })
            } else {
                res.json({ inserts: data })
            }
        })
    } else {
        res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: validarCampos }] })
    }
};

var obterModulos = function (req, res) {
    var models = objModels.ObjModulo;
    models.obterModulos(objModels.dbMysql, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] })
        } else {
            res.json({ modulos: data })
        }
    })
};

var obterAvaliacoes = function (req, res) {
    var models = objModels.ObjAvaliacao;
    models.obterAvaliacaos(objModels.dbMysql, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] })
        } else {
            res.json({ modulos: data })
        }
    })
};


var obterFilasVirtuais = function (req, res) {
    var models = objModels.ObjFilaVirtual;
    models.obterFilaVirtuais(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] })
        } else {
            res.json({ consultas: data })
        }
    })
};
var agendarFilaVirtual = function (req, res) {
    var models = objModels.ObjFilaVirtual;
    models.agendarFilaVirtual(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] })
        } else {
            res.json({ mensagens: [{ tipoMensagem: "Sucesso", mensagem: "Operação realizada com sucesso." }] })
        }
    })
};

module.exports = {
    obterPaciente,
    obterUnidades,
    obterEspecialidades,
    obterConsultas,
    agendarConsulta,
    inserirPaciente,
    obterBairros,
    obterModulos,
    obterAvaliacoes,
    obterFilasVirtuais
}




