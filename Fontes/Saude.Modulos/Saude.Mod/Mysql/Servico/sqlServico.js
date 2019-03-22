const sqlListar =
    " SELECT numero, nome                                      " +
    "  FROM aplicativo ap                                      " +
    "  JOIN servico    se                                      " +
    "    ON (se.aplicativo = ap.numero and data_fim =< now())  " +
    " WHERE numero = '1'                                       " 
    

module.exports = {
    sqlListar
};
