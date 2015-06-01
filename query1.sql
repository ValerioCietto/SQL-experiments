--OK 1.	Elencare il paese di ogni città
--tabelle country e city
--city name e country code sono chiavi primarie, tutti i valori accettati
--sottoproblemi: unire la tabella city a country
--query di verifica
 select * from mondial.country
 select * from mondial.city
--verificata su http://www.semwebtech.org/sqlfrontend/
select city.name cityname, country.name countryname from city join country on city.country = country.code order by cityname asc
--verificata su ORALAB
select mondial.city.name cityname, mondial.country.name countryname from mondial.city join mondial.country on mondial.city.country = mondial.country.code order by cityname asc
