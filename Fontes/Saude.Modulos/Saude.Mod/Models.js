const DbMysql = require('./Mysql/dbContext')
const dbMysql = new DbMysql.dbContext();
const ObjPaciente = require('./Mysql/Paciente/cPaciente')
const ObjUnidade = require('./Mysql/Unidade/cUnidade')
const ObjEspecialidade = require('./Mysql/Especialidade/cEspecialidade')
const ObjConsulta = require('./Mysql/Consulta/cConsulta')
const ObjBairro = require('./Mysql/Bairro/cBairro')


module.exports = {
     dbMysql,
     ObjPaciente,
     ObjUnidade,
     ObjEspecialidade,
     ObjConsulta,
     ObjBairro
};