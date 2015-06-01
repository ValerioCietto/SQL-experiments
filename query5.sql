--OK 5. Elencare per ogni lingua il numero di persone che la parlano
--verificata su http://www.semwebtech.org/sqlfrontend/
--country.code, language.name, country.population, language.percentage
--country.code, language.name chiave primaria
-- country.population, language.percentage valori nulli possibili
--sottoproblemi
--trovare percentuale di tutti i linguaggi per nazione
select country as countrycode, percentage, name as languagename from language
--le ipotesi sono che language.percentage, country.population non siano nulle
--query di controllo
select languagename, sum(population*percentage/100) as speakers from country
right join (select country as countrycode, percentage, name as languagename from language)
on country.code=countrycode group by languagename
--verificata su ORALAB
select languagename, sum(population*percentage/100) as speakers from country
right join (select country as countrycode, percentage, name as languagename from language)
on country.code=countrycode group by languagename
