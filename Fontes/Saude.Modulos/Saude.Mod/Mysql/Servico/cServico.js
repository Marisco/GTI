const objServico = require("./modServico");
const sqlServico = require("./sqlServico");

class cServico {
    constructor(Data) {
        this.modServico = new objServico.modServico(Data);
    }
}
function obterServico(db, callback) {

    var qry = sqlServico.sqlListar;        
    return db.client.query(qry, callback)
}


module.exports = {
    cServico,
    obterServicos, 
};