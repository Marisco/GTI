const sqlListar =
    " SELECT numero, nome     " +
    "  FROM unidade           " +
    " WHERE atendimento = 'S' " +
    " ORDER BY nome           "; 
    

module.exports = {
    sqlListar: sqlListar
};
