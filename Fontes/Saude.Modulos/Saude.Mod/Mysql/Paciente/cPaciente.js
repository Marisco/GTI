const objPaciente = require("./modPaciente");
const sqlPaciente = require("./sqlPaciente");

class cPaciente {
    constructor(Data) {
        this.modPaciente = new objPaciente.modPaciente(Data);
    }
}

function obterPaciente(db, body, callback) {

    var qry = sqlPaciente.sqlListar +
        " WHERE " +(body.cpf !== "" ? "cpf " : "cartao_sus ") + " = " + "'" + (body.cpf !== "" ? body.cpf : body.cartaoSus) + "'" +
        "    AND data_nascimento  = " + "DATE('" + body.dataNascimento + "')";
    return db.client.query(qry, callback)
}

function inserirPaciente(db, values, callback) {
    var qry = sqlPaciente.sqlInserir
    db.client.query(qry, function (err, statement) {
        if (err) {
            return console.error('Prepare error:', err);
        }
        statement.exec(values, function (err, affectedRows) {
            if (err) {
                return console.error('Exec error:', err);
            }
            console.log('Linhas Inseridas:', affectedRows);
        });
    }, callback);
}

module.exports = {
    cPaciente,
    obterPaciente,
    inserirPaciente
};