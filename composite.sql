--programmers defined methods is below!


declare
TYPE t_emp IS RECORD(
v_emp_id employees.employee_id%type,
v_emp_first_name employees.first_name%type,
v_emp_last_name employees.last_name%type
);
v_emp t_emp;

begin
select employee_id,first_name,last_name into v_emp.v_emp_id,v_emp.v_emp_first_name,v_emp.v_emp_last_name  from employees where employee_id=100;
DBMS_OUTPUT.PUT_LINE(v_emp.v_emp_id||''||v_emp.v_emp_first_name||''||v_emp.v_emp_last_name);

end;


declare
TYPE v_emp IS RECORD (ad employees.first_name%type,
salary employees.salary%type,
last_name employees.last_name%type);

v_temp v_emp;

begin
for i in 100..105
loop
select first_name,last_name,salary into v_temp.ad,v_temp.last_name,v_temp.salary from employees where employee_id=i;
dbms_output.put_line(v_temp.ad||''||v_temp.last_name||''||v_temp.salary);


end loop;


end;







--table based record %rowtype

select * from departments;

create table departments_copy as 
select * from departments where 1=2;

/*
declare
TYPE v_dep IS RECORD(dep_id departments_copy.department_id%type,
dep_name departments_copy.department_name%type,
dep_man_id departments_copy.manager_id%type,
dep_loc_id departments_copy.location_id%type
);

t_emp v_emp;



begin
select department_id,department_name,manager_id,location_id into t_emp from departments where department_id=10;
dbms_output.put_line(t_emp.dep_id||t_emp.dep_name||t_emp.dep_man_id||t_emp.dep_loc_id);

insert into departments_copy values t_emp;

end;

*/
select * from departments where department_id=10;


-- rowtype
declare
v_dept DEPARTMENTS%rowtype;


begin

SELECT department_id,department_name,manager_id,location_id into v_dept from departments where department_id=10;
insert into departments_copy values v_dept;


end;

--select * from departments_copy;

declare

v_dept DEPARTMENTS%rowtype;


begin

v_dept.department_id:=12;
v_dept.department_name:='IT';
update departments_copy set row=v_dept;


end;

select * from departments_copy;
select * from departments where department_id=10;






-- nested composite datatypes

create table information (
emp_id varchar2(100),
first_name varchar2(100),
mob_1   varchar2(100),
mob_2 varchar2(100),
landline varchar2(50)
);

insert into information values('1','Abdulla','45634634','2345345','34534534');

select * from information;


declare
type t_tel is record(
v_mob_1 information.mob_1%type,
v_mob_2 information.mob_2%type,
v_landline information.landline%type

);
type v_emp is record (
emp_id information.emp_id%type,
emp_name information.first_name%type,
v_tel t_tel
);

v_rec v_emp;
begin 

select emp_id,first_name,mob_1,mob_2,landline 
into v_rec.emp_id,v_rec.emp_name,v_rec.v_tel.v_mob_1,v_rec.v_tel.v_mob_2,v_rec.v_tel.v_landline 
from information where emp_id=1;
dbms_output.put_line('emp_id'||v_rec.emp_id||'landline'||v_rec.v_tel.v_landline );

end;


-- collections  practice

--associative array

declare
type v_emp is table of varchar2(100)
index by pls_integer;

v_name varchar2(100);
t_emp v_emp;

begin

for i in 100..110
loop
  select first_name||' '||last_name into v_name from employees where employee_id=i;
  t_emp(i):=v_name;

end loop;
for i in 100..110
loop
dbms_output.put_line(t_emp(i));


end loop;


end;



declare

type v_tab is table of varchar2(100)
index by pls_integer;

v_total number;
t_tab v_tab;


begin
t_tab(1):='Abdulla';
t_tab(3):='Nurlan';
t_tab(4):='Maga';
t_tab(5):='Ilkin';

for i in 1..6
    
loop
IF t_tab.exists(i) THEN
    dbms_output.put_line(i||'nimreli indexde variable var');
    ELSE
    dbms_output.put_line(i||'nomreli indexde variable movcud deyildir');
    END IF;

end loop;

v_total:=t_tab.count;
dbms_output.put_line('total number of variable in this array is '||v_total);
dbms_output.put_line('firsy index of this array is '||t_tab.first);
dbms_output.put_line('last variabe in this array '||t_tab.last);
dbms_output.put_line('next array from 3 index is  '||t_tab.next(3));
end;



declare
type t_tab is table of employees%rowtype
index by pls_integer;
t_var t_tab;
begin

for i in 100..105
loop
select * into t_var(i) from employees where employee_id=i;


end loop;

for i in t_var.first..t_var.last
loop
dbms_output.put_line('first_name'||t_var(i).first_name||'last_name'||t_var(i).last_name);

end loop;

end;


---- nested table collection comspoite data type
declare
type loc is table of varchar2(100);

t_loc loc;
begin
t_loc:=loc('Usa','Uk','jordan');
dbms_output.put_line(t_loc(1));
dbms_output.put_line(t_loc(2));

dbms_output.put_line(t_loc(3));




end;


--
declare
type t_loc is table of varchar2(100);
loc t_loc;


begin

loc:=t_loc('abdulla','nurlan','ilham');

for i in loc.first..loc.last
loop

dbms_output.put_line(loc(i));

end loop;



end;


--
declare
type t_loc is table of varchar2(100);
loc t_loc;


begin
loc:=t_loc('Abdulla','Nurlan');
loc.extend;
loc(3):='salam';

dbms_output.put_line(loc(1));
dbms_output.put_line(loc(2));
dbms_output.put_line(loc(3));
end;

--
declare
type loc is table of varchar2(100);
t_loc loc;


begin
t_loc:=loc('Aze','Tr','Russia');
t_loc.delete(2);
t_loc(2):='Iran';
for i in t_loc.first..t_loc.last

loop
dbms_output.put_line(t_loc(i));

end loop;


end;


--- nested table in sql initiliazing example

create or replace type tel is table of number;

create table customers(
cust_id number,
cust_name varchar2(100),
t_tel tel)

nested table t_tel store as t_tel_tbl;


insert into customers  values(1,'Abdulla',tel(235235,235235,235235));
select * from customers;

-- varray example

declare

type loc is varray(3) of varchar2(100);
t_loc loc;

begin
    t_loc:=loc('Abdulla','Nurlan','Ayten');
    t_loc.trim(1);
    dbms_output.put_line(t_loc(1));
    dbms_output.put_line(t_loc(2));

    


end;







