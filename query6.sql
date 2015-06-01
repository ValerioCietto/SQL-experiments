--OK 6. Elencare le nazioni che confinano con l'Italia (il risultato deve comprendere soltanto il nome delle nazioni).
select * from borders
where country1='I' or country2='I'

--seleziona tutti i paesi confinanti
select country1 from borders
where country2='I'
union all
select country2 from borders
where country1='I'

--mostra i nomi delle nazioni confinanti
select name from
(select country1 from borders
where country2='I'
union all
select country2 from borders
where country1='I')
left join country on country1=country.code
