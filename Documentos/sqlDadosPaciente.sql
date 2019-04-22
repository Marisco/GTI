select 'Consulta' as descricao, p.numero, u.nome as unidade, e.nome as especialidade, 0 as posicao, 0 as nfila 
  from paciente p
  join consulta c on(p.numero = c.paciente AND c.estado = 'A' AND ativo = 'S') 
  join especialidade_medico em on (em.numero = c.especialidade_medico)
  join especialidade e on (e.numero = em.especialidade)  
  JOIN consultorio co on ( co.numero = c.consultorio) 
  JOIN unidade u on ( u.numero = co.unidade)
  where p.numero = 201559  
  union 
select 'Fila Virtual' as descricao,  p.numero, u.nome as unidade, e.nome as especialidade,  v.posicao, f.numero as nfila 
  from paciente p
  join vw_fila_virtual v on(v.paciente = p.numero)
  join item_fila_virtual i on(p.numero = i.paciente)
  join fila_virtual f on(f.numero = i.fila_virtual)
  join especialidade e on (e.numero = f.especialidade)
  JOIN unidade u on ( u.numero = f.unidade)
  where p.numero = 201559;
  

SELECT numero  , nome           , cpf , telefone, celular, cartao_sus,   
            bairro  , data_nascimento, sexo, rg      , rg_uf  , estado_civil, 
            endereco, observacao     , anonimo                                    
      FROM paciente                                                           