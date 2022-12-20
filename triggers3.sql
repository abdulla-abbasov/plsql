-- 
drop table t_1;

create table t_1 (emp_id number,ename varchar2(100));
insert into t_1 values(1,'abdulla');
insert into t_1 values(2,'nurlan');
select * from t_1;

--- statement trigger
create or replace trigger update_ename before update on t_1
begin
dbms_output.put_line(':)');

end;
update t_1 set ename=ename||' ';
update t_1 set ename=ename||''  where emp_id=666;

---row level triggers
create or replace trigger row_trig
before update on t_1
for each row
begin
dbms_output.put_line(':)');
end;


update t_1 set ename=ename||' ';
update t_1 set ename=ename||''  where emp_id=666;



--- statement level trigger1
create or replace trigger dep_check_time_1 
before  update or delete or insert on departments
begin
if to_number(to_char(sysdate,'hh24'))not  between 8 and 16 then
raise_application_error(-20010,'in these perido u cant do dml operation here');
end if;
end;

desc departments;
select * from departments;
delete from departments;
delete from departments where department_id=-4;



select * from user_objects where object_name='DEP_CHECK_TIME_1';
SELECT * FROM USER_TRIGGERS WHERE TRIGGER_NAME='DEP_CHECK_TIME_1';

DROP TABLE EMP_COPY;

CREATE TABLE EMP_COPY AS
SELECT * FROM EMPLOYEES;

SELECT * FROM EMP_COPY;

create or replace trigger emp_copy_check 
before 
update or insert 
on emp_copy
for each row
begin
 if :new.salary<500 then
 raise_application_error(-20030,'cannot insert or update salary where value less than 500');
 end if;
end;

update emp_copy set salary=200 where employee_id=100;
create or replace trigger emp_copy
before 
update or insert 
on emp_copy
for each row
begin
 if :new.salary<500 then
dbms_output.put_line('s');
end if;
end;


---
drop table emp_copy;
create table emp_copy as
select * from employees;
select * from emp_copy;


--create table audit
create table emp_audit(emp_id number,
new_sal number,
operation varchar2(20),
old_sal number,
op_date date,
by_user varchar2(100));


create or replace trigger emp_copy_audit
after insert or update or delete
on emp_copy
for each row
begin
 if inserting then
 insert into emp_audit values(:new.employee_id,:new.salary,'inserting',null,sysdate,user);
 end if;
    
 if updating then
 insert into emp_audit values(:old.employee_id,:new.salary,'updating',:old.salary,sysdate,user);
 end if;
  
 if deleting then
 insert into emp_audit values(:old.employee_id,null,'deleting',:old.salary,sysdate,user);
 end if;
end;



update emp_copy set salary=200 where employee_id=100;

select * from emp_audit;


delete from employees where employee_id=10;
drop view emp_all;
create or replace view emp_all
as select * from employees;
select * from emp_all;















