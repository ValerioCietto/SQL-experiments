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

--OK 3. Elencare il nome dei paesi che hanno città con un nome che comprende la lettera "y".
--tabella country, city
--country.name chiave primaria, country.code chiave primaria
--sottoproblemi
select * from city where city.name like '%y%' or city.name like '%Y%'
--si suppone city.name not null
--query di verifica
select distinct * from mondial.country
left join mondial.city
on mondial.country.code=mondial.city.country
where mondial.city.name like '%y%'  or city.name like '%Y%'
--verificata su http://www.semwebtech.org/sqlfrontend/
select distinct country.name from country
left join city
on country.code=city.country
where city.name like '%y%' or city.name like '%Y%'

--verificata su ORALAB
select distinct mondial.country.name from mondial.country
left join mondial.city
on mondial.country.code=mondial.city.country
where mondial.city.name like '%y%' or city.name like '%Y%'
order by city.name asc

--OK 4.	Elencare le città a meno di 66 gradi di latitudine dai poli
--city.name, city.latitude
--city.name chiave primaria, latitude valore nullo possibile
--sottoproblemi
select * from mondial.city 
where latitude < -90+66 or latitude>90-66
order by latitude
---query di verifica
select * from mondial.city order by latitude asc
--verificata su http://www.semwebtech.org/sqlfrontend/
select name, latitude from city where latitude < -90+66 or latitude>90-66
order by latitude

--verificata su ORALAB
select name, latitude from mondial.city where latitude < -90+66 or latitude>90-66
order by latitude


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


--OK 6. Elencare le nazioni che confinano con l'Italia (il risultato deve comprendere soltanto il nome delle nazioni).
--tabelle borders e country
--country1, country2 chiavi non nulle, country.code chiave primaria
--sottoproblemi
--trovare i confini italiani
select * from borders
where country1='I' or country2='I'

--seleziona tutti i paesi confinanti
select country1 from borders
where country2='I'
union all
select country2 from borders
where country1='I'

--query di verifica
select * from
(select country1 from mondial.borders
where country2='I'
union all
select country2 from mondial.borders
where country1='I')
left join mondial.country on country1=country.code


--mostra i nomi delle nazioni confinanti
select name from
(select country1 from borders
where country2='I'
union all
select country2 from borders
where country1='I')
left join country on country1=country.code

--verificata su ORALAB
select name from
(select country1 from mondial.borders
where country2='I'
union all
select country2 from mondial.borders
where country1='I')
left join mondial.country on country1=country.code



--OK 7. Elencare le città che hanno più abitanti della capitale della loro nazione (il risultato deve contenere il nome della nazione, il nome delle città e della capitale e il numero dei loro abitanti).
--tabelle city, country
--city.name, country.code chiave primaria, city.population può essere null
--query di controllo popolazione tabella
select * from mondial.country
select * from mondial.city
--sottoproblemi
--seleziona le capitali con popolazione non nulla
select country.name as country_name, country.code as countrycode,capital, city.population as capital_pop from country
join city on capital=city.name
where city.population>0

--query di verifica
select * from mondial.city
left join (select country.name as country_name, country.code as countrycode,capital, city.population as capital_pop from mondial.country
join mondial.city on capital=city.name
where city.population>0) on city.country=countrycode
where population>capital_pop
--verificata su http://www.semwebtech.org/sqlfrontend/
select country_name,name, population, capital, capital_pop from city
left join (select country.name as country_name, country.code as countrycode,capital, city.population as capital_pop from country
join city on capital=city.name
where city.population>0) on city.country=countrycode
where population>capital_pop
--verificata su ORALAB
select country_name,name, population, capital, capital_pop from mondial.city
left join (select country.name as country_name, country.code as countrycode,capital, city.population as capital_pop from mondial.country
join mondial.city on capital=city.name
where city.population>0) on city.country=countrycode
where population>capital_pop

--OK 8.Calcolare (approssimativamente) il numero di abitanti per ogni continente (il risultato deve contenere il nome del continente e il numero dei suoi abitanti espresso in milioni).
--tabelle country, encompasses, continent
--chiavi country.code
--query controllo
select * from continent
select * from country
select * from encompasses
--verificata su http://www.semwebtech.org/sqlfrontend/
--popolazione di tutti i paesi
select continent, (country.population * encompasses.percentage/100)
as population from country join encompasses on encompasses.country = country.code

select continent, round((sum(population)/1000000)) as population_millions from
(select continent, (country.population * encompasses.percentage/100)
as population from country join encompasses on encompasses.country = country.code) 
group by continent
--verificata su ORALAB
select continent, round((sum(population)/1000000)) as population_millions from
(select continent, (country.population * encompasses.percentage/100)
as population from mondial.country join mondial.encompasses on encompasses.country = country.code) 
group by continent


--OK 9.Elencare le nazioni composte per almeno il 99% da isole (il risultato deve comprendere soltanto il nome della nazione).
--land+island area
select code, name as country_name, area as land_area from country
--islands area
select country_code, sum(island_area) from
(select island as island_name, country as country_code, area as island_area from geo_island
join island on geo_island.island=island.name)
group by country_code
--completa
select name from country
left join 
(select country_code, sum(island_area) as island_total_area from
(select island as island_name, country as country_code, area as island_area from geo_island
join island on geo_island.island=island.name)
group by country_code)
on code=country_code
where (area-island_total_area)*100 < area

--ORALAB
select name from mondial.country
left join 
(select country_code, sum(island_area) as island_total_area from
(select island as island_name, country as country_code, area as island_area from mondial.geo_island
join mondial.island on geo_island.island=island.name)
group by country_code)
on code=country_code
where (area-island_total_area)*100 < area

--OK partial 10.Trovare la capitale con più abitanti di tutte (con e senza operatore aggregato MAX)(il risultato deve contenere soltanto l’ identificatore della capitale).
--verificata su http://www.semwebtech.org/sqlfrontend/
select capital,city_pop from country
left join (select name as city_name, population as city_pop from city)
on capital = city_name
where city_pop>0
order by city_pop desc


--ORALAB
(select capital,city_pop from mondial.country 
left join (select name as city_name, population as city_pop from mondial.city)
on capital = city_name
where city_pop>0)
order by city_pop desc
where ROWNUM < 2



--OK 11.Ricavare la seconda isola per estensione nel mondo (il risultato deve comprendere il nome dell'isola e la sua area).

select name, area from island
where area>0
order by area desc
where rownum=2;

--OK 12.Per ogni nazione trovare la montagna più alta (con e senza operatore aggregato MAX) (il risultato deve contenere il nome della nazione e il nome della montagna (o null se la nazione non ha montagne)).
--mountains, country
select * from mountain  --251
select * from geo_mountain --322
select * from country	--244
--join geoMountain mountain
select name, elevation, country from mountain
join geo_mountain
on mountain.name = geo_mountain.mountain
--join geomountain, country, mountain
select name, cname, elevation from (
select name, elevation, country as countryname from mountain
join geo_mountain
on mountain.name = geo_mountain.mountain)
join (select name as cname, code as ccode from country) on
ccode = countryname
--verificata su http://www.semwebtech.org/sqlfrontend/
select cname as stato,max( elevation) as massima_altezza from (
   select name, elevation, country as countryname from mountain
     join geo_mountain
     on mountain.name = geo_mountain.mountain)
        join (select name as cname, code as ccode from country) on
        ccode = countryname
group by cname

--ORALAB
select cname as stato,max( elevation) as massima_altezza from (
   select name, elevation, country as countryname from mondial.mountain
     join mondial.geo_mountain
     on mountain.name = geo_mountain.mountain)
        join (select name as cname, code as ccode from mondial.country) on
        ccode = countryname
group by cname

--OK 13.Estrarre il paese se con più fiumi del mondo e il numero di tali fiumi (il risultato deve comprendere la nazione e il numero dei suoi fiumi).

select name, count(river) as river_number from geo_river
join country 
on country.code=country
group by name
order by river_number desc

-- 14.Estrarre le città cinesi che hanno più abitanti di ogni città italiana (con e senza operatore aggregato MAX) (il risultato deve comprendere la città e la sua popolazione).
select name, population from city
where country = 'CN'
 and population > 2617175
order by population desc

--OK 15.Per ogni città statunitense estrarre la sua popolazione e la superficie dei laghi su cui eventualmente si affaccia (il risultato deve comprendere la città, la popolazione e l'area complessiva dei suoi laghi oppure 0 se la città non è su un lago).
--seleziona i laghi statunitensi
select * from mondial.located
where located.lake is not null and located.country= 'USA'
--selezione città statunitensi e popolazione
select * from mondial.city
where city.population is not null and city.country= 'USA'
--con proiezione su nome, popolazione
select name,population from mondial.city
where city.population is not null and city.country= 'USA'
--join con geo-lake
select * from mondial.located
where located.lake is not null and located.country= 'USA'
left join geo_lake
on geo_lake.name=located.lake

--verificata su http://www.semwebtech.org/sqlfrontend/
select city, population from located
join (select name as cityname,population from city
where city.population is not null and city.country= 'USA')
on located.city=cityname
where located.lake is not null and located.country= 'USA'

--altro modo
select city, population from city
join (select city from located
 where located.lake is not null and located.country= 'USA')
on city.name=city
where population is not null

--ORALAB
select city, population from mondial.located
join (select name as cityname,population from mondial.city
where city.population is not null and city.country= 'USA')
on located.city=cityname
where located.lake is not null and located.country= 'USA'

--altro modo
select city, population from mondial.city
join (select city from mondial.located
 where located.lake is not null and located.country= 'USA')
on city.name=city
where population is not null

--verifica
select * from mondial.city
join (select * from mondial.located
 where located.lake is not null and located.country= 'USA')
on city.name=city
where population is not null



--FAIL 16.Elencare le nazioni che non sono direttamente confinanti ma sono separate da un’unica nazione (il risultato deve comprendere i nomi delle coppie di nazioni).


--FAIL 17.Elencare le coppie di fiumi che nascono in nazioni confinanti e che sfociano in mari non adiacenti ma separati da un unico mare (il risultato deve comprendere i nomi delle coppie di fiumi).
