/*Ordens de serviços que o mecânico não está disponível*/
select os.idOrdemServico as 'Ordem de Serviço', m.disponibilidade as Disponibilidade from OrdemServico os
inner join Servico s on s.OrdemServico_idOrdemServico = os.idOrdemServico
inner join ServicoMecanicos sm on s.IdServico = sm.Servico_idServico 
inner join Mecanicos m on sm.Mecanicos_idMecanicos = m.idMecanicos
where disponibilidade like 'nao'
order by idOrdemServico

/*Ordens de serviços autorizadas e organizadas pelo preço do serviço */
select os.idOrdemServico, os.autorizacao, s.valorServico from OrdemServico os
inner join Servico s on s.OrdemServico_idOrdemServico = os.idOrdemServico
inner join ServicoMecanicos sm on s.IdServico = sm.Servico_idServico 
where autorizacao like 'sim'
order by s.valorServico DESC

/*Oficina com mais ordem de serviço*/
select idOficina as Oficina, count(os.idOrdemServico) as 'Quantidade de Ordem' from Oficina o  
inner join OrdemServico os on os.Oficina_idOficina = o.idOficina
group by idOficina

/*Quantas ordens de serviço serão finalizadas em em Julho*/
select idOrdemServico as 'ordem Serviço', dataEntrega as 'Data Finalização do Serviço' from OrdemServico
where dataEntrega BETWEEN  ('2023-07-01') and ('2023-07-31')
and autorizacao like 'sim'
 
/*Quantidade de problemas por ordem*/
select problema as problemas, count(idOrdemServico) as 'Quantidades de Ordens' from OrdemServico os
inner join Servico s on s.OrdemServico_idOrdemServico = os.idOrdemServico 
where os.problema like s.descricaoServico 
group by problema 

/*Ordem de Serviço por modelo de carro*/
select p.modelo as Modelo, count(idOrdemServico) as 'QUantidade de Ordens' from Pecas p
inner join PecasOrdemServico pos on pos.Pecas_idPecas = p.idPecas
inner join OrdemServico os on os.idOrdemServico = pos.OrdemServico_idOrdemServico
group by modelo

/*Quantidade de carros por cliente*/
select c.nomeCliente as Nome, count(idCliente) as 'Quantidade de Veiculos' from Cliente c 
left join OficinaCliente oc on oc.Cliente_idCliente = c.idCliente
right join Oficina o on o.idOficina = oc.Oficina_idOficina
group by nomeCliente

/*Nome do mecanico especialista2*/
select nomeMecanico from Mecanicos where especialidade like 'especialista2'

/*Ver todos os seviços*/
select * from Servico

/*Ver peças*/
select * from Pecas