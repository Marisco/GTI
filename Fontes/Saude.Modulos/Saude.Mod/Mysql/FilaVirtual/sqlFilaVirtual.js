const sqlListar =
    " SELECT  fi.numero, u.nome unidade_nome, e.nome especialidade_nome, fi.data_inicio, fi.data_fim " +
    "   FROM fila_virtual fi                                                                         " +
    "   JOIN especialidade e ON (fi.especialidade = e.numero)                                        " +
    "   JOIN unidade u ON (fi.unidade = u.numero)                                                    "
    "    WHERE ma.data_inicio <= NOW()                                                               " +
    "    AND (ma.data_fim IS NULL OR data_fim < NOW() )                                              "


module.exports = {
    sqlListar
};
