const objModels = require("../Saude.Mod/Models");

var obterPaciente = function (req, res) {
    var models = objModels.ObjPaciente;
    models.obterPaciente(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send("Não foi possível localizar o registro:" + e);
        }
        res.send({ paciente: data })
    })
};

var obterUnidades = function (req, res) {
    var models = objModels.ObjUnidade;
    models.obterUnidades(objModels.dbMysql, (e, data) => {
        if (e) {
            res.status(400).send("Não foi possível localizar o registro:" + e);
        }
        res.send({ unidades: data })
    })
};


var obterBairros = function (req, res) {
    var models = objModels.ObjBairro;
    models.obterBairros(objModels.dbMysql, (e, data) => {
        if (e) {
            res.status(400).send("Não foi possível localizar o registro:" + e);
        }
        res.send({ bairros: data })
    })
};

var obterEspecialidades = function (req, res) {
    var models = objModels.ObjEspecialidade;
    models.obterEspecialidades(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send("Não foi possível localizar o registro:" + e);
        }
        res.send({ especialidades: data })
    })
};

var obterConsultas = function (req, res) {
    var models = objModels.ObjConsulta;
    models.obterConsultas(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send("Não foi possível localizar o registro:" + e);
        }
        res.json({ consultas: data })
    })
};
var agendarConsulta = function (req, res) {
    var models = objModels.ObjConsulta;
    models.agendarConsulta(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send("Não foi agendar a consulta:" + e);
        }
        res.json({ mensagens: [{tipoMensagem: "Sucesso", mensagem:  "Operação realizada com sucesso."}]})
    })
};

var inserirPaciente = function (req, res) {
    var models = objModels.ObjPaciente;
    models.inserirPaciente(objModels.dbMysql, req.body, (e, data) => {
        if (e) {
            res.status(400).send("Não foi agendar a consulta:" + e);
        }
        res.json({ mensagens: [{tipoMensagem: "Sucesso", mensagem:  "Operação realizada com sucesso."}]})
    })
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




