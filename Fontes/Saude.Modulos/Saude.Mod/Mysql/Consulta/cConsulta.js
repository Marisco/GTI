const objConsulta = require("./modConsulta");
const sqlConsulta = require("./sqlConsulta");

class cConsulta {
    constructor(Data) {
        this.modConsulta = new objConsulta.modConsulta(Data);
    }
}

var obterConsultas = function(db, body, callback) {
    var qry = sqlConsulta.sqlListar;
    if (body.consultaId == "0") {
        qry = qry +
            " AND e.numero =   " + body.especialidadeId+
            " AND co.unidade = " + body.unidadeId+
            " AND c.data_inicio BETWEEN  DATE('" + body.dataInicio + "') AND DATE('" + body.dataFim + "')";

    } else {
        qry = qry +
            " AND c.numero =   " + body.consultaId;
    }

    return db.client.query(qry, callback);
};

var agendarConsulta = function(db, body  , callback) {
    var qry = 
    " UPDATE consulta                           " +
    "    SET estado = 'A',                      " +
    "        paciente = "+body.pacienteId+",     " +
    "        usuario = ( SELECT numero          " +
    "                      FROM usuario         " +
    "                     WHERE sistema = 'S'   " +
    "                     LIMIT 1)              " +
    "  WHERE numero = "+body.consultaId+"       " +
    "    AND estado = 'D'                       " +
    "    AND paciente IS NULL                   " +
    "    AND ativo = 'S'                        ";
    
    return db.client.query(qry, callback);
}

module.exports = {
    cConsulta: cConsulta,
    obterConsultas: obterConsultas,    
    agendarConsulta: agendarConsulta
};