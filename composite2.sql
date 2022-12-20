-- record datatype

declare
type c_emp is record (c_name employees.first_name%type,
c_id employees.employee_id%type,
c_sal employees.salary%type);

v_emp c_emp;


begin
select first_name,employee_id,salary into v_emp from employees where employee_id=100;
dbms_output.put_line(v_emp.c_name);


end;

select * from employees where employee_id=100;



declare
type c_emp is record(
c_name employees.first_name%type,
c_sal employees.salary%type
);
v_emp c_emp;
begin
for i in 100..103
loop
select first_name,salary into v_emp from employees where employee_id=i;
dbms_output.put_line(i||'first_name '||v_emp.c_name||'maas : '||v_emp.c_sal);
end loop;
end;


