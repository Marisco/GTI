const sqlListar =
    " SELECT DISTINCT e.numero, e.nome                                       " +
    "   FROM consulta c                                                      " +
    "   JOIN especialidade_medico em ON (em.numero = c.especialidade_medico) " +
    "   JOIN especialidade e ON (e.numero = em.especialidade)                " +
    "   JOIN consultorio co ON (co.numero = c.consultorio)                   " +
    "  WHERE c.estado = 'D'                                                  " +
    "    AND c.ativo='S'                                                     "

module.exports = {
    sqlListar
};
