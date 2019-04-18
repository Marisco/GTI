const sqlListar =
    " SELECT  f.numero, u.nome unidade_nome, e.nome especialidade_nome, f.data_inicio, f.data_fim   " +
    "   FROM fila_virtual f                                                                         " +
    "   JOIN especialidade e ON (f.especialidade = e.numero)                                        " +
    "   JOIN unidade u ON (f.unidade = u.numero)                                                    " +
    "  WHERE f.data_inicio <= NOW()                                                                 " +
    "    AND (f.data_fim IS NULL OR data_fim > NOW() )                                              ";

const sqlInserir = 
    " INSERT INTO item_fila_virtual (paciente, fila_virtual )                                       "+
    " VALUES(?, ?)                                                                                  ";    

const slqItemFilaVirtual     =
    " SELECT  * FROM item_fila_virtual WHERE  fila_virtual = ? ORDER BY numero";


module.exports = {
    sqlListar: sqlListar,
    sqlInserir: sqlInserir,
    slqItemFilaVirtual: slqItemFilaVirtual
};
