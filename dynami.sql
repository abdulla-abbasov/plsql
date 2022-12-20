----multirow dynamic sql

create or replace procedure emp_list(p_id number default null)
is 
type cur_emp is ref cursor;
cur_emp_man cur_emp;
v_name employees.first_name%type;
v_sal employees.salary%type;
v_sql varchar2(100):='select first_name,salary from employees';

begin
if p_id is null then
open cur_emp_man for v_sql;
else 
v_sql:=v_sql||' where employee_id=:id';
open cur_emp_man for v_sql using p_id;
end if;
loop
fetch cur_emp_man into v_name,v_sal;
exit    when  cur_emp_man%notfound;
dbms_output.put_line('adi'||v_name||'maasi: '||v_sal);
end loop;
close cur_emp_man;


end;

select emp_list() from dual;

execute emp_list(101);