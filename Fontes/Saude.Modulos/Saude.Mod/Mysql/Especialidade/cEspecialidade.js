const objEspespecialidade = require("./modEspecialidade");
const sqlEspecialidade = require("./sqlEspecialidade");

class cEspecialidade {
    constructor(Data) {
        this.modEspecialidade = new objEspespecialidade.modEspespecialidade(Data);
    }
}

function obterEspecialidades(db, body, callback) {
    var qry;
    if (body.moduloId == "1"){
        qry = sqlEspecialidade.sqlEspecialidadeConsulta;
        qry = qry +
        " AND co.unidade =   " + body.unidadeId +
        " AND c.data_inicio BETWEEN  DATE('" + body.dataInicio + "') AND DATE('" + body.dataFim + "')";
    }else{
        qry = sqlEspecialidade.sqlEspecialidadeFilaVirtual;
        qry = qry +" AND f.unidade =   " + body.unidadeId
    }

    return db.client.query(qry, callback)
}

module.exports = {
    cEspecialidade,
    obterEspecialidades    
};