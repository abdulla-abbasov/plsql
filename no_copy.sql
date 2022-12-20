

select * from employees where employee_id in(100,101,102);

create or replace procedure without_bulk(p_amount number)
is
type emp_table is table of number index by binary_integer;
emp_table_t emp_table;
begin
emp_table_t(1):=100;
emp_table_t(2):=101;
emp_table_t(3):=102;
for i in emp_table_t.first..emp_table_t.last
loop
update employees set salary=salary+p_amount where employee_id =emp_table_t(i);
end loop;
commit;
end;

select * from employees where employee_id=100;
execute without_bulk(20);

create or replace procedure with_bulk(p_amount number)
is
type v_emp is table of number index by binary_integer;
v_emp_t v_emp;
begin
v_emp_t(1):=100;
v_emp_t(2):=101;
v_emp_t(3):=102;
forall i  in v_emp_t.first..v_emp_t.last
update employees set salary=salary+p_amount where employee_id=v_emp_t(i);
commit;
end;

execute with_bulk(20);

select * from employees where employee_id=100;

