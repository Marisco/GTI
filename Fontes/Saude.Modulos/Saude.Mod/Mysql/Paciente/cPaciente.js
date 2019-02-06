const objPaciente = require("./modPaciente");
const sqlPaciente = require("./sqlPaciente");

class cPaciente {
    constructor(Data) {
        this.modPaciente = new objPaciente.modPaciente(Data);
    }
}

function obterPaciente(db, body, callback) {

    var qry = sqlPaciente.sqlListar +
        " WHERE " + (body.cpf !== "" ? "cpf " : "cartao_sus ") + " = " + "'" + (body.cpf !== "" ? body.cpf : body.cartaoSus) + "'" +
        "    AND data_nascimento  = " + "DATE('" + body.dataNascimento + "')";
    return db.client.query(qry, callback)
}

function inserirPaciente(db, body, callback) {
    var qry = sqlPaciente.sqlInserir
    return db.client.query(qry, [body.nome, body.cpf, body.telefone, body.cartaoSus, body.bairro, body.dataNascimento, body.sexo], callback);
}

module.exports = {
    cPaciente,
    obterPaciente,
    inserirPaciente
};