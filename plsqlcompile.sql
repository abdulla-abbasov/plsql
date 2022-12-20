--
select name,value from v$parameter where name='plsql_code_type'; 

create or replace procedure p1
is

begin
dbms_output.put_line('p1');
end;

select * from user_plsql_object_settings where name='P1';