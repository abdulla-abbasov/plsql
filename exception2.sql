declare
v_name varchar2(100);

begin
select first_name into v_name  from employees;
dbms_output.put_line(v_name);

exception when too_many_rows then

dbms_output.put_line('too many rows');


end; 

declare
v_name varchar2(100);

begin
select first_name into v_name from employees where employee_id=&id;
dbms_output.put_line(v_name);
exception  when no_data_found then
dbms_output.put_line('data yoxdur');
when too_many_rows then
dbms_output.put_line('to many data');
 when others then
 dbms_output.put_line('other error');


end;




declare
v_name employees.first_name%type;



begin
for i in 99..102
loop
begin

select first_name into v_name from employees where employee_id=i;
dbms_output.put_line(v_name);
exception
when no_data_found then
dbms_output.put_line('data yoxdur');


end;
end loop;

end;



----

























