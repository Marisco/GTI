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
    "    AND ativo = 'S'               "

module.exports = {
    sqlListar,
    sqlInserir,
    sqlValidar    
};
