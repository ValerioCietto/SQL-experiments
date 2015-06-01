--OK 2.   Elencare le città toccate dal lago Lac Leman
--tabella located
--city.located chiave primaria
--sottoproblemi 
select city from mondial.located where lake not null
--query di verifica
select * from mondial.located where lake not null
--verificata su http://www.semwebtech.org/sqlfrontend/
select city from located where lake = 'Lac Leman'
--verificata su ORALAB
select city from mondial.located where lake = 'Lac Leman'
