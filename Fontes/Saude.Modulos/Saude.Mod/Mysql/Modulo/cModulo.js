const objModulo = require("./modModulo");
const sqlModulo = require("./sqlModulo");

class cModulo {
    constructor(Data) {
        this.modModulo = new objModulo.modModulo(Data);
    }
}
function obterModulos(db, callback) {
    
    var qry = sqlModulo.sqlListar;        
    return db.client.query(qry, callback)
}


module.exports = {
    cModulo,
    obterModulos, 
};