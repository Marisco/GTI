const objPaciente = require("./modPaciente");
const sqlPaciente = require("./sqlPaciente");

class cPaciente {
    constructor(Data) {
        this.modPaciente = new objPaciente.modPaciente(Data);
    };
};

var obterPaciente = function(db, body, callback) {

    var qry = sqlPaciente.sqlListar +
        " WHERE " + (body.cpf !== "" ? "cpf " : "cartao_sus ") + " = " + "'" + (body.cpf !== "" ? body.cpf : body.cartaoSus) + "'" +
        "    AND data_nascimento  = " + "DATE('" + body.dataNascimento + "')";
    return db.client.query(qry, callback);;
}

var inserirPaciente = function(db, body, callback) {
    var qry = sqlPaciente.sqlInserir;
    return db.client.query(qry, [body.nome, body.cpf, body.telefone, body.cartaoSus, body.bairro, body.dataNascimento, body.sexo], callback);
}


var obterDadosPaciente = function (db, body, callback) {
    var qry = sqlPaciente.sqlDados
    return db.client.query(qry, [body.pacienteId], callback);
};

var validarPaciente = function (db, body, callback) {
    var qry = sqlPaciente.sqlValidar +
    " AND " + ( body.pacienteId && body.pacienteId != "" ? "numero " : body.cpf !== "" ? "cpf " : "cartao_sus ") + " = " + "'" + (body.pacienteId && body.pacienteId != "" ? body.pacienteId : body.cpf !== "" ? body.cpf : body.cartaoSus) + "'";
    return db.client.query(qry, callback) > 0;
};

module.exports = {
    cPaciente: cPaciente,
    obterPaciente : obterPaciente,
    inserirPaciente : inserirPaciente,
    validarPaciente: validarPaciente,
    obterDadosPaciente: obterDadosPaciente
};