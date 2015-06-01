--OK 4.	Elencare le città a meno di 66 gradi di latitudine dai poli
--city.name, city.latitude
--city.name chiave primaria, latitude valore nullo possibile
--sottoproblemi
select * from mondial.city where latitude<66
---query di verifica
select * from mondial.city order by latitude asc
--verificata su http://www.semwebtech.org/sqlfrontend/
select name, latitude from city where latitude <66
--verificata su ORALAB
select name, latitude from mondial.city where latitude <66
