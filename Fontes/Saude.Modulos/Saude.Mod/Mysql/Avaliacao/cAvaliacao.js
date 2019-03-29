const objAvaliacao = require("./modAvaliacao");
const sqlAvaliacao = require("./sqlAvaliacao");

class cAvaliacao {
    constructor(Data) {
        this.modAvaliacao = new objAvaliacao.modAvaliacao(Data);
    }
}
function obterAvaliacaos(db, callback) {
    
    var qry = sqlAvaliacao.sqlListar;        
    return db.client.query(qry, callback)
}


module.exports = {
    cAvaliacao,
    obterAvaliacaos, 
};