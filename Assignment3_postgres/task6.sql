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