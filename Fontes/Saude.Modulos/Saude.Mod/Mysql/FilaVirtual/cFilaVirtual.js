const objFilavirtual = require("./modFilavirtual");
const sqlFilavirtual = require("./sqlFilavirtual");

class cFilavirtual {
    constructor(Data) {
        this.modFilavirtual = new objFilavirtual.modFilavirtual(Data);
    }
}
function obterFilasVirtuais(db, callback) {
    
    var qry = sqlFilavirtual.sqlListar;
    if (body.filaVirtualId == "0") {
        qry = qry +
            " AND e.numero =   " + body.especialidadeId +
            " AND co.unidade = " + body.unidadeId
            

    } else {
        qry = qry +
            " AND c.numero =   " + body.filaVirtualId;
    }

    return db.client.query(qry, callback)
}

function agendarFilaVirtual(db, body  , callback) {
    var qry = 
    " UPDATE consulta                           " +
    "    SET estado = 'A',                      " +
    "        paciente = "+body.pacienteId+",     " +
    "        usuario = ( SELECT numero          " +
    "                      FROM usuario         " +
    "                     WHERE sistema = 'S'   " +
    "                     LIMIT 1)              " +
    "  WHERE numero = "+body.filaVirtualId+"    " +
    "    AND estado = 'D'                       " +
    "    AND paciente IS NULL                   " +
    "    AND ativo = 'S'                        "
    
    return db.client.query(qry, callback)
}


module.exports = {
    cFilavirtual,
    obterFilasVirtuais, 
    agendarFilaVirtual
};