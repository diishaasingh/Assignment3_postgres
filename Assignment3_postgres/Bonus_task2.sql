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