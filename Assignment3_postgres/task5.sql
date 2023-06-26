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
