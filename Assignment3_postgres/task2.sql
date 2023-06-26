--task2(Write a function which returns number of tournaments happened in a year, year should be
--taken as an input parameter and output should be returned using OUT parameter. )
CREATE OR REPLACE FUNCTION number_of_tournaments(in tour_year int, out count_tours int)   
LANGUAGE plpgsql  
AS  
$$  
DECLARE  
begin  
   select count(*)into count_tours
   from tournament_entry 
   where tournament_entry.year=tour_year
   group by tournament_entry.year;
   
   --return count_tours
end;  
$$; 
DROP FUNCTION IF EXISTS number_of_tournaments

select * from number_of_tournaments(2021);
select * from tournament_entry
