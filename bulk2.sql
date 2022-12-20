---
desc employees;
create table ename as
select distinct(first_name) from employees;
drop table ename;


declare
type e_tab is table of varchar2(100);
e_table_name e_tab:=e_tab();
v_val number:=0;
begin
for i in (select * from ename)
loop
v_val:=v_val+1;
e_table_name.extend;
e_table_name(v_val):=i.first_name;
end loop;
for i in e_table_name.first..e_table_name.last
loop
update ename set first_name=first_name||'to be added' where first_name=e_table_name(i);
end loop;
exception
when others then
null;
end;
----------------------------
declare
type e_tab is table of varchar2(100);
e_table_name e_tab:=e_tab();
v_val number:=0;
begin
for i in (select * from ename)
loop
v_val:=v_val+1;
e_table_name.extend;
e_table_name(v_val):=i.first_name;
end loop;
forall i in e_table_name.first..e_table_name.last save exceptions 

update ename set first_name=first_name||'to be added' where first_name=e_table_name(i);
exception
when others then
null;
end;

select * from ename;


declare
type e_tab is table of varchar2(100);
e_table_name e_tab:=e_tab();
v_val number:=0;
errors number;
begin
for i in (select * from ename)
loop
v_val:=v_val+1;
e_table_name.extend;
e_table_name(v_val):=i.first_name;
end loop;
forall i in e_table_name.first..e_table_name.last save exceptions 

update ename set first_name=first_name||'to be added' where first_name=e_table_name(i);
exception
when others then
errors:=sql%bulk_exceptions.count;
dbms_output.put_line('total errors occured in procedure :'||errors);
for j in 1..errors
loop
dbms_output.put_line('the error iteration is: '||sql%bulk_exceptions(j).error_index||
'and error code is: '||sql%bulk_exceptions(j).error_code
||'and error message is: '||sqlerrm(-sql%bulk_exceptions(j).error_code));

end loop;
end;


----

declare
type ename_t is table of varchar2(100);
ename_t_tab ename_t:=ename_t();
errors number;
begin
select first_name bulk collect into ename_t_tab from ename;
forall i in ename_t_tab.first..ename_t_tab.last save exceptions
update ename set first_name=first_name||'added to'   where first_name=ename_t_tab(i);
exception
when others then
errors:=sql%bulk_exceptions.count;
dbms_output.put_line('total errors occured in procedure :'||errors);
for j in 1..errors
loop
dbms_output.put_line('the error iteration is: '||sql%bulk_exceptions(j).error_index||
'and error code is: '||sql%bulk_exceptions(j).error_code
||'and error message is: '||sqlerrm(-sql%bulk_exceptions(j).error_code));

end loop; 

end;

drop table ename;
select  * from ename;



create table ename_2 as
select employee_id,first_name from employees;  


drop table ename_2;
select * from ename_2;

declare
type v_emp is table of varchar2(100) index by binary_integer;
c number:=0;
emp_table v_emp:=v_emp();
begin
for i in (select first_name from ename_2)
loop
c:=c+1;
emp_table(c):=i.first_name;
end loop;
--------
for i in emp_table.first..emp_table.last
loop
dbms_output.put_line(i||'ci first_name'||emp_table(i));

end loop;

end;

-----

declare
type v_emp is table of varchar2(100) index by binary_integer;
v_emp_table v_emp:=v_emp();

begin
select first_name bulk collect into v_emp_table from ename_2;
for i in v_emp_table.first..v_emp_table.last
loop
dbms_output.put_line(i||v_emp_table(i));
end loop;
end;


------ without bulk collect
declare
type emp_t is table of employees%rowtype;
emp_table emp_t:=emp_t();
c number:=0;
cursor e_all is select * from employees;
begin
open e_all;
loop
emp_table.extend;
c:=c+1;
fetch e_all into emp_table(c);
exit when e_all%notfound;
dbms_output.put_line(emp_table(c).first_name);
end loop;
close e_all;
end;
--with bulk collect

declare
type v_emp is table of employees%rowtype;
v_emp_table v_emp:=v_emp();
cursor c_emp is select * from employees;
begin
open c_emp;
fetch c_emp bulk collect into v_emp_table;

for i in v_emp_table.first..v_emp_table.last
loop
dbms_output.put_line(v_emp_table(i).first_name);
end loop;
end;

-- with bulk collect and limit;
declare
type v_emp is table of employees%rowtype;
cursor c_emp is select * from employees;
v_emp_table v_emp:=v_emp();
begin
open c_emp;
fetch c_emp bulk collect into v_emp_table limit 5;

for i in v_emp_table.first..v_emp_table.last
loop
dbms_output.put_line(v_emp_table(i).first_name);
end loop;
end;

-- 
create or replace procedure p_amount_salary(e_id number,p_amount number)
is
new_sal number;
begin
update employees set salary=salary+p_amount where employee_id=e_id returning salary into new_sal;
dbms_output.put_line('new salary is '||new_sal);
end;

select * from employees where employee_id=200;
execute p_amount_salary(200,1);

drop table ename_2;


create table ename_2 as
select employee_id,salary from employees;

select * from ename_2;

declare
type v_emp is table of ename_2%rowtype;
v_emp_table v_emp:=v_emp();
emp_new_sal v_emp:=v_emp();
begin
select * bulk collect into v_emp_table from ename_2;
forall i in v_emp_table.first..v_emp_table.last
update ename_2 set salary=salary/2 where employee_id=v_emp_table(i).employee_id returning employee_id,salary bulk collect into emp_new_sal;
for i in emp_new_sal.first..emp_new_sal.last
loop
dbms_output.put_line(emp_new_sal(i).employee_id||'maasi: '||emp_new_sal(i).salary);
end loop;
end;


-- indices of main thing in bulk collect
declare
type emp_table is table of number index by binary_integer;
v_emp_table emp_table:=emp_table();
 
begin
v_emp_table(1):=100;
v_emp_table(2):=101;
v_emp_table(3):=102;
v_emp_table(100):=103;
dbms_output.put_line(v_emp_table.first);
dbms_output.put_line(v_emp_table.last);
forall i in v_emp_table.first..v_emp_table.last save exceptions
update employees set salary=salary/2 where employee_id=v_emp_table(i);
end;

declare
type emp_table is table of number index by binary_integer;
v_emp_table emp_table:=emp_table();
 
begin
v_emp_table(1):=100;
v_emp_table(2):=101;
v_emp_table(3):=102;
v_emp_table(100):=103;
dbms_output.put_line(v_emp_table.first);
dbms_output.put_line(v_emp_table.last);
forall i in indices of v_emp_table
update employees set salary=salary/2 where employee_id=v_emp_table(i);
end;


select * from employees where employee_id in (101,102,103);

























































