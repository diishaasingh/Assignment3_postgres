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