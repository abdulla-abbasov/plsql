 
 
 select name,value from v$parameter  where name='remote_dependencies_mode';
 select * from students@READ_REMOTE;
 
create or replace procedure read_from_remote
is
begin
dbms_output.put_line('executng remote dependencies');
 print_all_students@read_remote;

end;

select * from user_objects where lower(object_name)='read_from_remote';


