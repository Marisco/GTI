const sqlListar =
" SELECT t1.medicacao_descricao medicacao, t1.unidade_nome unidade                                                                            "+
"   FROM (SELECT m1.numero medicacao_numero, m1.descricao medicacao_descricao, un1.numero unidade_numero, un1.nome unidade_nome,    "+
"                SUM(em.quantidade) quantidade_estoque, 0 media_atendida                                                            "+
" 		  FROM estoque_medicacao em                                                                                                 "+
" 		 INNER JOIN unidade un1                                                                                                     "+
"             ON (em.unidade = un1.numero AND                                                                                       "+
"                 un1.farmacia = 'S' AND                                                                                            "+
"                 un1.almoxarifado <> 'S' AND                                                                                       "+
"                 un1.estoque_restrito = 'N' AND                                                                                    "+
"                 un1.urgencia_emergencia = 'N' AND                                                                                 "+
"                 un1.unidade_pai IS NULL)                                                                                          "+
" 		 INNER JOIN lote_medicacao lm1 ON (em.lote_medicacao = lm1.numero)                                                          "+
"          INNER JOIN medicacao m1 ON (lm1.medicacao = m1.numero)                                                                   "+
"          WHERE m1.descricao like N?                                                                                                "+
"          GROUP BY m1.numero, un1.numero                                                                                           "+
"          UNION                                                                                                                    "+
"          SELECT t.medicacao_numero, t.medicacao_descricao, t.unidade_numero, t.unidade_nome,                                      "+
"                 0 quantidade_estoque, AVG(t.quantidade_diaria) media_atendida                                                     "+
" 		   FROM (SELECT m.numero medicacao_numero, m.descricao medicacao_descricao, un.numero unidade_numero, un.nome unidade_nome, "+
"                         DATE(pm.data_pedido) dia_pedido, SUM(pm.quantidade_atendida) quantidade_diaria                            "+
" 				   FROM pedido_medicacao pm                                                                                         "+
" 				  INNER JOIN unidade un                                                                                             "+
" 					 ON (pm.unidade = un.numero AND                                                                                 "+
"                          un.farmacia = 'S' AND                                                                                    "+
"                          un.almoxarifado <> 'S' AND                                                                               "+
"                          un.estoque_restrito = 'N' AND                                                                            "+
"                          un.urgencia_emergencia = 'N' AND                                                                         "+
"                          un.unidade_pai IS NULL)                                                                                  "+
" 				  INNER JOIN lote_medicacao lm ON (pm.lote_medicacao = lm.numero)                                                   "+
"                   INNER JOIN medicacao m ON (lm.medicacao = m.numero)                                                             "+
"                   WHERE pm.data_pedido BETWEEN ADDDATE(NOW(), INTERVAL -1 MONTH) and NOW()                                        "+
"                     AND m.descricao like N?                                                                                        "+
" 				  GROUP BY m.numero, un.numero, DATE(pm.data_pedido)                                                                "+
"                   ORDER BY medicacao_descricao ASC, unidade_nome ASC, dia_pedido DESC) t                                          "+
" 		  GROUP BY t.medicacao_numero, t.unidade_numero) t1                                                                         "+
"  WHERE quantidade_estoque > media_atendida                                                                                        "+
"  GROUP BY t1.medicacao_numero, t1.unidade_numero                                                                                  "+
"  ORDER BY medicacao_descricao ASC, unidade_nome ASC                                                                               ";                                                                   


module.exports = {
    sqlListar: sqlListar
};
