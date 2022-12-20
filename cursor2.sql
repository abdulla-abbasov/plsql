--explicit cursor

declare
cursor dep_30 is
select employee_id,first_name,salary from employees where department_id=30;
v_id employees.employee_id%type;
v_name employees.first_name%type;
v_sal employees.salary%type;
begin
open dep_30;
loop
fetch dep_30 into v_id,v_name,v_sal;
exit when dep_30%notfound;
end loop;
close dep_30;
end;

--
declare
cursor c_emp is select employee_id,first_name from employees;
v_emp employees.employee_id%type;
v_name employees.first_name%type;
begin
open c_emp;
loop
fetch c_emp into v_emp,v_name;
exit when c_emp%notfound or c_emp%rowcount>10;
dbms_output.put_line(v_emp||v_name);
end loop;
close c_emp;
end;


-- for loop for explicit cursor;
declare
cursor emp_30 is select employee_id,first_name from employees where department_id=30;
begin
for i in emp_30
loop
dbms_output.put_line(i.employee_id);
dbms_output.put_line(i.first_name);
end loop;
end;


-- cursor with parametres;
declare
cursor c_emp(dep_id number) is select first_name,employee_id from employees where department_id=dep_id;
v_name employees.first_name%type;
v_id employees.employee_id%type;


begin
open c_emp(30);
dbms_output.put_line('20ci depde isleyen isciler');
loop
fetch c_emp into v_name,v_id;
exit when c_emp%notfound;
dbms_output.put_line(v_name||v_id);

end loop;
close c_emp;

--20ci dep
open c_emp(20);
dbms_output.put_line('30depde calisan isciler');
loop
fetch c_emp into v_name,v_id;
exit when c_emp%notfound;
dbms_output.put_line(v_name||v_id);
end loop;
close c_emp;
end;






