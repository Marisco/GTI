const objModels = require("../Saude.Mod/Models");
//const objValidacao = require('./validacao')

var obterPaciente = function (req, res) {

    var validarCampos = "";//objValidacao.validarCampos(req.body);

    if (validarCampos == "") {
        var models = objModels.ObjPaciente;
        models.obterPaciente(objModels.dbMysql, req.body, (e, data) => {
            if (e) {
                res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] })
            } else {
                res.json({ paciente: data })
            }
        })
    } else {
        res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: validarCampos }] })
    }
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
        if (e) {
            res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível localizar o registro:" + e }] })
        } else {
            res.json({ mensagens: [{ tipoMensagem: "Sucesso", mensagem: "Operação realizada com sucesso." }] })
        }
    })
};

var inserirPaciente = function (req, res) {
    var validarCampos = "";//objValidacao.validarCampos(req.body);

    if (validarCampos == "") {
        var models = objModels.ObjPaciente;
        models.inserirPaciente(objModels.dbMysql, req.body, (e, data) => {
            if (e) {                
                res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: "Não foi possível inserir o registro:" + e }] })
            } else {
                res.json({ inserts: data })
            }
        })
    }else {
        res.status(400).send({ mensagens: [{ tipoMensagem: "Erro", mensagem: validarCampos }] })
    }
};




module.exports = {
    obterPaciente,
    obterUnidades,
    obterEspecialidades,
    obterConsultas,
    agendarConsulta,
    inserirPaciente,
    obterBairros
}




