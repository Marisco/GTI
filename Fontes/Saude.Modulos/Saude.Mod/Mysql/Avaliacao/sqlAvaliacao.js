const sqlListar =
    " SELECT ma.numero, ap.descricao as nome_aplicativo, ma.descricao as nome_avaliacao, ma.icone, ma.data_inicio, ma.data_fim  " +
    "   FROM aplicativo ap                                                                  " +
    "   JOIN avaliacao_aplicativo ma on(ap.numero = ma.aplicativo)                             " +
    "  WHERE ap.numero =1                                                                  " +
    "    AND ma.data_inicio <= NOW()                                                        " +
    "    AND (ma.data_fim IS NULL OR data_fim < NOW() )                                      "
    

module.exports = {
    sqlListar
};
