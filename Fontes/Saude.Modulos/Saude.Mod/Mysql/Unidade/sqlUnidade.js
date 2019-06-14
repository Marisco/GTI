const sqlListar =
    " SELECT DISTINCT u.numero, u.nome                      " +
    "   FROM consulta c                                     " +
    "   JOIN consultorio co ON (c.consultorio = co.numero)  " +
    "   JOIN unidade u ON (co.unidade = u.numero)           " +
    "  WHERE c.ativo = 'S'                                  " +
    "    AND c.estado = 'D'                                 " +
    "    AND u.atendimento = 'S'                            " +    
    "  ORDER BY u.nome                                      "; 
    

module.exports = {
    sqlListar: sqlListar
};
