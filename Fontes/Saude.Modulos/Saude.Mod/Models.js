const DbMysql = require('./Mysql/dbContext')
const dbMysql = new DbMysql.dbContext();
const ObjPaciente = require('./Mysql/Paciente/cPaciente')
const ObjUnidade = require('./Mysql/Unidade/cUnidade')
const ObjEspecialidade = require('./Mysql/Especialidade/cEspecialidade')
const ObjConsulta = require('./Mysql/Consulta/cConsulta')
const ObjBairro = require('./Mysql/Bairro/cBairro')
const ObjModulo = require('./Mysql/Modulo/cModulo')
const ObjAvaliacao = require('./Mysql/Avaliacao/cAvaliacao')
const ObjFilaVirtual = require('./Mysql/FilaVirtual/cFilaVirtual')


module.exports = {
     dbMysql,
     ObjPaciente,
     ObjUnidade,
     ObjEspecialidade,
     ObjConsulta,
     ObjBairro,
     ObjModulo,
     ObjAvaliacao,
     ObjFilaVirtual
};