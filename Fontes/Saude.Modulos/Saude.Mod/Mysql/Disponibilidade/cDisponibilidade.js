const objDisponibilidade = require("./modDisponibilidade");
const sqlDisponibilidade = require("./sqlDisponibilidade");

class cDisponibilidade {
    constructor(Data) {
        this.modDisponibilidade = new objDisponibilidade.modDisponibilidade(Data);
    }
}

var obterDisponibilidades = function(db, body, callback) {
    var qry = sqlDisponibilidade.sqlListar;
    return db.client.query(qry, [ "%" + body.nomeMedicao+ "%" , "%" + body.nomeMedicao + "%" ], callback);    
};
module.exports = {
    cDisponibilidade: cDisponibilidade,
    obterDisponibilidades: obterDisponibilidades  
};