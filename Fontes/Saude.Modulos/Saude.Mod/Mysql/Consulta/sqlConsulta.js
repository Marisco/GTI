const sqlListar =
    " SELECT c.numero, u.nome unidade_nome, co.nome consultorio_nome, e.nome especialidade_nome, " +
    "        m.nome medico_nome, c.data_inicio, c.data_fim                                       " +
    "   FROM consulta c                                                                          " +
    "   JOIN consultorio co ON (c.consultorio = co.numero)                                       " +
    "   JOIN especialidade_medico em ON (c.especialidade_medico = em.numero)                     " +
    "   JOIN medico m ON (em.medico = m.numero)                                                  " +
    "   JOIN especialidade e ON (em.especialidade = e.numero)                                    " +
    "   JOIN unidade u ON (co.unidade = u.numero)                                                " +
    "  WHERE c.ativo = 'S'                                                                       " +
    "    AND c.estado = 'D'                                                                      "

// const sqlAgendar =
//     " UPDATE consulta                           " +
//     "    SET estado = 'A',                      " +
//     "        paciente = ?                       " +
//     "        usuario = ( SELECT numero          " +
//     "                      FROM usuario         " +
//     "                     WHERE sistema = 'S'   " +
//     "                     LIMIT 1)              " +
//     "  WHERE numero = ?                         " +
//     "    AND estado = 'D'                       " +
//     "    AND paciente IS NULL                   " +
//     "    AND ativo = 'S'                        "

module.exports = {
    sqlListar,
    //sqlAgendar
};
