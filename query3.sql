--OK 3. Elencare il nome dei paesi che hanno città con un nome che comprende la lettera "y".
--tabella country, city
--country.name chiave primaria, country.code chiave primaria
--sottoproblemi
select * from city where city.name like '%y%'
--si suppone city.name not null
--query di verifica
select distinct * from mondial.country
left join mondial.city
on mondial.country.code=mondial.city.country
where mondial.city.name like '%y%'
--verificata su http://www.semwebtech.org/sqlfrontend/
select distinct country.name from country
left join city
on country.code=city.country
where city.name like '%y%'
--verificata su ORALAB
select distinct mondial.country.name from mondial.country
left join mondial.city
on mondial.country.code=mondial.city.country
where mondial.city.name like '%y%'
