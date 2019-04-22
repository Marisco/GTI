const DbMysql = require('./Mysql/dbContext');
const dbMysql = new DbMysql.dbContext();
const ObjPaciente = require('./Mysql/Paciente/cPaciente');
const ObjUnidade = require('./Mysql/Unidade/cUnidade');
const ObjEspecialidade = require('./Mysql/Especialidade/cEspecialidade');
const ObjConsulta = require('./Mysql/Consulta/cConsulta');
const ObjBairro = require('./Mysql/Bairro/cBairro');
const ObjModulo = require('./Mysql/Modulo/cModulo');
const ObjAvaliacao = require('./Mysql/Avaliacao/cAvaliacao');
const ObjFilaVirtual = require('./Mysql/FilaVirtual/cFilaVirtual');
const objDisponibilidade = require('./Mysql/Disponibilidade/cDisponibilidade');


module.exports = {
     dbMysql: dbMysql,
     ObjPaciente: ObjPaciente,
     ObjUnidade: ObjUnidade,
     ObjEspecialidade: ObjEspecialidade,
     ObjConsulta: ObjConsulta,
     ObjBairro: ObjBairro,
     ObjModulo: ObjModulo,
     ObjAvaliacao: ObjAvaliacao,
     ObjFilaVirtual: ObjFilaVirtual,
     objDisponibilidade: objDisponibilidade
};