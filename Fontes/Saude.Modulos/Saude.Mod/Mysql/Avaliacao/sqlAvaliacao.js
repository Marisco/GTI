const sqlListar =
" (SELECT c.numero AS numero,  u.numero AS unidade, u.nome AS nome_unidade, c.data_inicio AS data_atendimento, e.nome AS especialidade, 2 AS tipo_avaliacao, "+
"  (SELECT descricao FROM tipo_avaliacao WHERE numero = 2) AS descricao                                                                                      "+
"    FROM paciente p                                                                                                                                                                                                    "+
"    JOIN consulta c ON( c.paciente = p.numero AND c.ativo = 'S' AND c.estado = 'R')                                                                                                                                    "+
"    JOIN especialidade_medico em ON( em.numero = c.especialidade_medico )                                                                                                                                              "+
"    JOIN especialidade e ON(e.numero = em.especialidade)                                                                                                                                                               "+
"    JOIN consultorio co on ( co.numero = c.consultorio)                                                                                                                                                                "+
"    JOIN unidade u on ( u.numero = co.unidade)                                                                                                                                                                         "+
"     AND c.numero > (SELECT IFNULL(MAX(numero_atendimento),0) AS numero FROM avaliacao WHERE tipo_avaliacao = 2)                                                                                                       "+
"   WHERE p.numero = ?                                                                                                                                                                                                  "+
"   ORDER BY data_inicio DESC                                                                                                                                                                                           "+
"   LIMIT 1                                                                                                                                                                                                             "+
"    )                                                                                                                                                                                                                  "+
" UNION                                                                                                                                                                                                                 "+
" (SELECT  pm.numero AS numero, u.numero AS unidade, u.nome AS nome_unidade, pm.data_pedido AS data_atendimento, '' AS especialidade, 3 AS tipo_avaliacao,  "+
"  (SELECT descricao FROM tipo_avaliacao WHERE numero = 3) AS descricao                                                                                      "+
"    FROM paciente p                                                                                                                                                                                                    "+
"    JOIN pedido_medicacao pm ON( pm.paciente = pm.numero)                                                                                                                                                              "+
"    JOIN unidade u on ( u.numero = pm.unidade)                                                                                                                                                                         "+
"   WHERE p.numero = ?                                                                                                                                                                                                  "+
"     AND pm.numero > (SELECT IFNULL(MAX(numero_atendimento),0) AS numero FROM avaliacao WHERE tipo_avaliacao = 3)                                                                                                      "+
"   ORDER BY data_pedido DESC                                                                                                                                                                                           "+
"   LIMIT 1)                                                                                                                                                                                                            "+
" UNION                                                                                                                                                                                                                 "+
" (SELECT r.numero AS numero, u.numero AS unidade, u.nome AS nome_unidade, r.data_requisicao AS data_atendimento, '' AS especialidade, 4 AS tipo_avaliacao, "+
"  (SELECT descricao FROM tipo_avaliacao WHERE numero = 4) AS descricao                                                                                      "+
"    FROM paciente p                                                                                                                                                                                                    "+
"    JOIN requisicao r ON( r.paciente = p.numero AND  r.estado = 'AG')                                                                                                                                                  "+
"    JOIN unidade u on ( u.numero = r.unidade)                                                                                                                                                                          "+
"   WHERE p.numero = ?                                                                                                                                                                                                  "+
"     AND r.numero > (SELECT IFNULL(MAX(numero_atendimento),0) AS numero FROM avaliacao WHERE tipo_avaliacao = 4)                                                                                                       "+
"   ORDER BY data_requisicao DESC                                                                                                                                                                                       "+
"   LIMIT 1)                                                                                                                                                                                                            "+
" UNION                                                                                                                                                                                                                 "+
" (SELECT r.numero AS numero_atendimento, u.numero AS unidade, u.nome AS nome_unidade, r.data_coleta AS data_atendimento, '' AS especialidade, 5 AS tipo_avaliacao,      "+
"  (SELECT descricao FROM tipo_avaliacao WHERE numero = 5) AS descricao                                                                                      "+
"    FROM paciente p                                                                                                                                                                                                    "+
"    JOIN requisicao r ON( r.paciente = p.numero AND  r.estado = 'CO')                                                                                                                                                  "+
"    JOIN unidade u on ( u.numero = r.unidade)                                                                                                                                                                          "+
"   WHERE p.numero = ?                                                                                                                                                                                                  "+
"     AND r.numero > (SELECT IFNULL(MAX(numero_atendimento),0) AS numero FROM avaliacao WHERE tipo_avaliacao = 5)                                                                                                       "+
"   ORDER BY data_requisicao DESC                                                                                                                                                                                       "+
"   LIMIT 1); ";

const sqlInserir = 
" INSERT INTO avaliacao (paciente, tipo_avaliacao, data_atendimento, nota, texto, celular ,numero_atendimento) " +    
" VALUES (?, ?, ?, ?, ?, ?, ?); ";

module.exports = {
    sqlListar: sqlListar,
    sqlInserir: sqlInserir
};
