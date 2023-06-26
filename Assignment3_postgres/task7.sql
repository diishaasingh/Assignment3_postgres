--task7(Write a function to return the year-wise tournament participants count.)
create or replace function count_of_participants(in tour_year int,out count_p int)
language plpgsql
as
$$
declare 
begin
  select count(*) into count_p 
  from tournament_entry where tournament_entry.year=tour_year
  --group by tournament_entry.year
  ;
end;
$$;
select * from count_of_participants(2023);

select * from tournament_entry
select * from tournament