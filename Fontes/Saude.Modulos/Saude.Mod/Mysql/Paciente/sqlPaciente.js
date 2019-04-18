const sqlListar =
    " SELECT numero  , nome           , cpf , telefone, celular, cartao_sus,   " +
    "        bairro  , data_nascimento, sexo, rg      , rg_uf  , estado_civil, " +
    "        endereco, observacao     , anonimo                                " +    
    "  FROM paciente                                                           " 

 const sqlInserir = 
" INSERT INTO paciente (nome, cpf, telefone, cartao_sus, bairro , data_nascimento, sexo)    " +    
"               VALUES (? , ? , ? , ? , ? , ? , ?)                                          " 

const sqlValidar =
    " SELECT IFNULL(COUNT(*),0) AS qtd " +    
    "   FROM paciente pa, consulta co  " +
    "  WHERE pa.numero = co.paciente   " +
    "    AND estado = 'A'              " +    
    "    AND ativo = 'S'               ";

const sqlDados = 
" SELECT 'Consultas' AS descricao, e.nome AS especialidade,  count(*) AS quantidade     "+
"   FROM paciente p                                                                     "+
"   JOIN consulta c ON(p.numero = c.paciente AND c.estado = 'A' AND ativo = 'S')        "+
"   JOIN especialidade_medico em ON (em.numero = c.especialidade_medico)                "+
"   JOIN especialidade e ON (e.numero = em.especialidade)                               "+
"    AND p.numero = ?																	"+
"  GROUP BY e.numero                                                                    "+
" UNION                                                                                 "+
" SELECT 'Filas Virtuais' AS descricao, e.nome AS especialidade, count(*) AS quantidade "+
"   FROM paciente p                                                                     "+
"   JOIN item_fila_virtual i on(p.numero = i.paciente)                                  "+
"   JOIN fila_virtual f ON(f.numero = i.fila_virtual)                                   "+
"   JOIN especialidade e ON (e.numero = f.especialidade)                                "+
"    AND p.numero = ?																	"+
"  GROUP BY fila_virtual;                                                               ";


module.exports = {
    sqlListar: sqlListar,
    sqlInserir: sqlInserir,
    sqlValidar: sqlValidar,
    sqlDados: sqlDados    
};
