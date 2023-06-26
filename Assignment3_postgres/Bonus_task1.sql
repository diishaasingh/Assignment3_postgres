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