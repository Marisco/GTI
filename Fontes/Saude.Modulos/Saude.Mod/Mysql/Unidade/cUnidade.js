const objUnidade = require("./modUnidade");
const sqlUnidade = require("./sqlUnidade");

class cUnidade {
    constructor(Data) {
        this.modUnidade = new objUnidade.modUnidade(Data);
    }
}
function obterUnidades(db, callback) {

    var qry = sqlUnidade.sqlListar;        
    return db.client.query(qry, callback)
}


module.exports = {
    cUnidade,
    obterUnidades, 
};