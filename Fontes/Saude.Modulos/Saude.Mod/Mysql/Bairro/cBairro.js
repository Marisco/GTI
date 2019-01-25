const objBairro = require("./modBairro");
const sqlBairro = require("./sqlBairro");

class cBairro {
    constructor(Data) {
        this.modBairro = new objBairro.modBairro(Data);
    }
}
function obterBairros(db, callback) {

    var qry = sqlBairro.sqlListar;        
    return db.client.query(qry, callback)
}


module.exports = {
    cBairro,
    obterBairros, 
};