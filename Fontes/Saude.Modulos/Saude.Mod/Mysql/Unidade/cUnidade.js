const objUnidade = require("./modUnidade");
const sqlUnidade = require("./sqlUnidade");

class cUnidade {
    constructor(Data) {
        this.modUnidade = new objUnidade.modUnidade(Data);
    }
}
var obterUnidades = function(db, callback) {

    var qry = sqlUnidade.sqlListar;        
    return db.client.query(qry, callback)
}


module.exports = {
    cUnidade: cUnidade,
    obterUnidades: obterUnidades, 
};