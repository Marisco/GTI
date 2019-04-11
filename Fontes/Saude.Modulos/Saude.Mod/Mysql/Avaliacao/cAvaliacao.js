const objAvaliacao = require("./modAvaliacao");
const sqlAvaliacao = require("./sqlAvaliacao");

class cAvaliacao {
    constructor(Data) {
        this.modAvaliacao = new objAvaliacao.modAvaliacao(Data);
    }
}
function obterAvaliacoes(db, body, callback) {
    
    var qry = sqlAvaliacao.sqlListar;            
    return db.client.query(qry, [body.pacienteId, body.pacienteId, body.pacienteId, body.pacienteId], callback);
}

function inserirAvaliacao(db, body, callback) {
    var qry = sqlAvaliacao.sqlInserir
    return db.client.query(qry, [body.pacienteId, body.tipoAvaliacao, body.dataAtendimento, body.nota, body.texto, body.celular, body.numeroAtendimento ], callback);    
}

module.exports = {
    cAvaliacao,
    obterAvaliacoes, 
    inserirAvaliacao
};