const sqlListar =
    " SELECT numero  , nome           , cpf , telefone, celular, cartao_sus,   " +
    "        bairro  , data_nascimento, sexo, rg      , rg_uf  , estado_civil, " +
    "        endereco, observacao     , anonimo                                " +    
    "  FROM paciente                                                           " 

 const sqlInserir = 
" INSERT INTO paciente (nome, cpf, telefone, cartao_sus, bairro , data_nascimento, sexo)    " +    
"               VALUES (? , ? , ? , ? , ? , ? , ?)                                          " 

module.exports = {
    sqlListar,
    sqlInserir    
};
