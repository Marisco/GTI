const sqlEspecialidadeConsulta =
    " SELECT DISTINCT e.numero, e.nome                                       " +
    "   FROM consulta c                                                      " +
    "   JOIN especialidade_medico em ON (em.numero = c.especialidade_medico) " +
    "   JOIN especialidade e ON (e.numero = em.especialidade)                " +
    "   JOIN consultorio co ON (co.numero = c.consultorio)                   " +
    "  WHERE c.estado IN('D')                                               " +
    "    AND c.ativo ='S'                                                     "

    const sqlEspecialidadeFilaVirtual =
    " SELECT DISTINCT e.numero, e.nome                                       " +
    "   FROM fila_virtual f                                                  " +
    "   JOIN especialidade e ON (e.numero = f.especialidade)                 " +
    "   WHERE data_inicio < now()                                            " +
    "   AND (data_fim is null or data_fim > now())                           " 
    


module.exports = {
    sqlEspecialidadeConsulta: sqlEspecialidadeConsulta,
    sqlEspecialidadeFilaVirtual: sqlEspecialidadeFilaVirtual
};
