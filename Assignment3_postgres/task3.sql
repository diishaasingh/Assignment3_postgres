--task3(Write a function to return all the tournaments happened in a year – this function should
--return a table which has columns like tournament_name, tour_type, is_open and country. Year 
--filter value should be taken as a parameter. )
create or replace function all_tournaments(tour_year int) 
returns table(tournament_name varchar, tour_type varchar, is_open boolean,country varchar)
language plpgsql
as
$$
declare
begin
return query
select t.name,t.tour_type,t.is_open,t.country
from tournament t 
join tournament_entry te 
on t.tourid=te.tourid
where te.year=tour_year;

end;
$$
select * from all_tournaments(2022)