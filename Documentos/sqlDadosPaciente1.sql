(SELECT c.numero AS numero,  u.numero AS unidade, u.nome AS nome_unidade, p.numero AS paciente,  p.nome AS nome_paciente, c.data_inicio AS data_atendimento, e.nome AS especialidade, 2 AS tipo_avaliacao, 
 (SELECT descricao FROM tipo_avaliacao WHERE numero = 2) as descricao
   FROM paciente p                                                                                                                                                        
   JOIN consulta c ON( c.paciente = p.numero AND c.ativo = 'S' AND c.estado = 'R')                                                                                        
   JOIN especialidade_medico em ON( em.numero = c.especialidade_medico )                                                                                                  
   JOIN especialidade e ON(e.numero = em.especialidade)
   JOIN consultorio co on ( co.numero = c.consultorio)
   JOIN unidade u on ( u.numero = co.unidade)
    AND c.numero > (SELECT IFNULL(MAX(numero_atendimento),0) AS numero FROM avaliacao WHERE tipo_avaliacao = 2)       
  WHERE p.numero = 120472                                                                                                                                                 
  ORDER BY data_inicio DESC                                                                                                                                               
  LIMIT 1                                                                                                                                                                 
   )                                                                                                                                                                      
UNION                                                                                                                                                                     
(SELECT  pm.numero AS numero, u.numero AS unidade, u.nome AS nome_unidade, p.numero AS paciente,  p.nome AS nome_paciente,  pm.data_pedido AS data_atendimento, '' AS especialidade, 3 AS tipo_avaliacao ,
(SELECT descricao FROM tipo_avaliacao WHERE numero = 3) as descricao
   FROM paciente p                                                                                                                                                        
   JOIN pedido_medicacao pm ON( pm.paciente = pm.numero)     
   JOIN unidade u on ( u.numero = pm.unidade)
  WHERE p.numero = 120472   
    AND pm.numero > (SELECT IFNULL(MAX(numero_atendimento),0) AS numero FROM avaliacao WHERE tipo_avaliacao = 3)         
  ORDER BY data_pedido DESC                                                                                                                                               
  LIMIT 1)                                                                                                                                                                
UNION                                                                                                                                                                     
(SELECT r.numero AS numero, u.numero AS unidade, u.nome AS nome_unidade, p.numero AS paciente,  p.nome AS nome_paciente,  r.data_requisicao AS data_atendimento, '' AS especialidade, 4 AS tipo_avaliacao,
(SELECT descricao FROM tipo_avaliacao WHERE numero = 4) as descricao
   FROM paciente p                                                                                                                                                        
   JOIN requisicao r ON( r.paciente = p.numero AND  r.estado = 'AG')  
   JOIN unidade u on ( u.numero = r.unidade)
  WHERE p.numero = 120472 
    AND r.numero > (SELECT IFNULL(MAX(numero_atendimento),0) AS numero FROM avaliacao WHERE tipo_avaliacao = 4)         
  ORDER BY data_requisicao DESC                                                                                                                                           
  LIMIT 1)                                                                                                                                                                
UNION                                                                                                                                                                     
(SELECT r.numero AS numero, u.numero AS unidade, u.nome AS nome_unidade, p.numero AS paciente,  p.nome AS nome_paciente, r.data_coleta AS data_atendimento, '' AS especialidade, 5 AS tipo_avaliacao,
(SELECT descricao FROM tipo_avaliacao WHERE numero = 5) as descricao
   FROM paciente p                                                                                                                                                        
   JOIN requisicao r ON( r.paciente = p.numero AND  r.estado = 'CO')  
   JOIN unidade u on ( u.numero = r.unidade)
  WHERE p.numero = 120472   
    AND r.numero > (SELECT IFNULL(MAX(numero_atendimento),0) AS numero FROM avaliacao WHERE tipo_avaliacao = 5)         
  ORDER BY data_requisicao DESC                                                                                                                                           
  LIMIT 1);

alter table avaliacao add numero_atendimento int;

SELECT p.numero, p.nome
, (SELECT IFNULL(COUNT(*),0) FROM consulta c WHERE c.paciente = p.numero AND DATE(data_inicio) = '2019-03-20' AND ativo = 'S' AND estado = 'R') qtd_consultas_realizadas
, (SELECT IFNULL(COUNT(*),0) FROM pedido_medicacao pm WHERE pm.paciente = p.numero AND DATE(data_pedido) = '2019-03-20') qtd_pedidos_medicacao 
, (SELECT IFNULL(COUNT(*),0) FROM requisicao r WHERE r.paciente = p.numero AND DATE(r.data_requisicao) = '2019-03-20' AND r.estado = 'AG') qtd_requisicoes_agendadas
, (SELECT IFNULL(COUNT(*),0) FROM requisicao r WHERE r.paciente = p.numero AND DATE(r.data_coleta) = '2019-03-20' AND r.estado = 'CO') qtd_coletas_exames 
FROM paciente p 
WHERE p.numero = 249153;
