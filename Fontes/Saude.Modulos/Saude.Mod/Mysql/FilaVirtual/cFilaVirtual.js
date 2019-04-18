const objFilavirtual = require("./modFilavirtual");
const sqlFilavirtual = require("./sqlFilavirtual");

class cFilavirtual {
    constructor(Data) {
        this.modFilavirtual = new objFilavirtual.modFilavirtual(Data);
    }
};

var obterFilasVirtuais = function (db, body, callback) {

    var numero = body.filaVirtualId == "0" ? " AND u.numero = " + body.unidadeId : " AND f.numero =   " + body.filaVirtualId;

    var qry = sqlFilavirtual.sqlListar + numero;

    return db.client.query(qry, callback)
};

var inserirFilaVirtual = function (db, body, callback) {
    var qry = sqlFilavirtual.sqlInserir
    return db.client.query(qry, [body.pacienteId, body.filaVirtualId], callback);
};

var obterItemFilaVirtual = function(db, filaVirtualId, callback) {
    var qry = sqlFilavirtual.slqItemFilaVirtual
    return db.client.query(qry, [filaVirtualId], callback);
};


module.exports = {
    cFilavirtual,
    obterFilasVirtuais,
    inserirFilaVirtual,
    obterItemFilaVirtual
};