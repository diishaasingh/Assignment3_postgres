--1.Write a stored procedure which allows a golf member to participate into a tournament. 
--Stored procedure should accept the member_name and tournament_name as an input. 
create or replace procedure allow_participation(in member_name varchar,in tournament_name varchar, tour_year int)
language plpgsql
as $$
declare
member_id int;
tour_id int;
begin
select memberid into member_id from member where firstname=member_name;
select tourid into tour_id from tournament where name = tournament_name;
insert into tournament_entry (memberid, tourid, year)
values (member_id, tour_id, tour_year);
end;
$$;

call allow_participation('Disha','TourF',2023);
select * from tournament_entry;

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

--task4(Write a stored procedure to update the team manager of a team, manager name and team 
--name should be provided as an input.)
create or replace procedure update_manager(in manager_name varchar, in team_name varchar)
language plpgsql
as $$
begin
    update member
	set firstname = manager_name
	where teamid = (select teamid from team where team.teamname = team_name and member.memberid = manager);
end; $$

call update_manager('Disha','A')
call update_manager('Sam','B')

select * from member

--task5(Write a function to return all the members in a team, team name should be passed as an input 
--parameter to the function. It should return the result in tabular format with columns like member_first_name,
--member_last_name, membership_type, joindate, gender)

create or replace function member_details(in team_name varchar) 
returns table (member_firstname varchar,member_lastname varchar,membership_type varchar,joindate date,gender varchar)  
language plpgsql  
as  
$$  
begin 
return query
    select
	member.firstname,member.lastname,membertype.type,member.joindate,member.gender
	from member 
	join membertype on member.membertypeid = membertype.id
	join team on team.teamid=member.teamid
	where team.teamname = team_name;
End;  
$$;
select * from member_details('A');
select * from member;

--task6(Write a stored procedure to update the coach of a member, coach_name and member_name should be taken
--as an input. Function should raise an error if the coach is not found.)
create or replace procedure update_coach(in coach_name varchar,in  member_name varchar)
language plpgsql
as $$
begin
if not exists(select * from member where firstname=member_name)
then raise 'member not found';
else update member set firstname = coach_name 
where memberid= (select coachid from member where firstname = member_name );
end if;
end; $$

call update_coach('Sachin','Virat');
call update_coach('Disha','Swati');

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


--Bonus problem statements –  

--1.Write a function to swap two values.
create or replace function swap(inout x int,inout y int)
language plpgsql
as
$$
begin
   select x,y into y,x;
end;
$$;
select * from swap(50,100)
--2.Write a function to return current date in below format 
create or replace function return_date()
returns table(day text,month text,year text)--varchar doesn't work here
language plpgsql
as
$$
begin
   return query
select
   to_char(current_date,'DD') as day,
   to_char(current_date,'MM') as month,
   to_char(current_date,'YYYY') as year;
end;
$$ 
select * from return_date();
drop function return_date()