select *from employees where department_id=30;

declare
cursor c_emp is 
select employee_id,first_name from employees where employee_id=30;

v_id employees.employee_id%type;
v_name employees.first_name%type;


begin
open c_emp;
loop
fetch c_emp into v_id,v_name ;
exit when c_emp%notfound;
dbms_output.put_line(v_id||v_name);-- exit sh

end loop;
close c_emp;

end;