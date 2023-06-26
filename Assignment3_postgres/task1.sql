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