---direct dependecies and indiret dependencies exmple here

--

declare
v_num number;
begin

select employee_id into v_num from employees  where first_name='Neena';
dbms_output.put_line(v_num);

end;

select * from employees;


-- if u alter definition of table o view it can be not work in procedure o function which referencede u

drop table emp_copy;

drop table emp_copy;

create table emp_copy as

select * from employees;

create or replace view emp_copy1 as
select * from emp_copy;

select object_name,object_type,status from user_objects where object_name='EMP_COPY1';





drop table students;
create table students (student_id number,student_name varchar2(100),
dob date
);

insert into students values(1,'Abdulla',sysdate);
insert into students values(2,'Nurlan',sysdate);
insert into students values(3,'Merac',sysdate);

select * from students;

create or replace view v1_student as

select  * from students;


create or replace view v2_students as
select student_id,student_name from students;


create or replace procedure print_all_students
is
begin
    for i in (select * from students)
    loop
    dbms_output.put_line('student id'||i.student_id||'student_name'||i.student_name);

    end loop;

end;


execute print_all_students;

select * from user_dependencies where referenced_name='STUDENTS';


---
create or replace procedure print_all_students_from_v_1 is
begin
for i in (select * from v1_student)
loop
  dbms_output.put_line(i.student_id||' '||i.student_name);

end loop;
end;



--- write a function that get salary of employee
create or replace function get_cust_name(p_cust_id number)
return varchar2
   cust_name  customers.v_name%type;
is

begin
select v_name into cust_name  from customers where cust_id=p_cust_id;
exception when others then 
return null;
end;

select * from customers;







