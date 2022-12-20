drop table emp;

create table emp (id number,
emp_name varchar2(100));

create table fired_first(seq number,trigger_name varchar2(100));

create sequence s;

create or replace trigger t_1 after insert on emp
begin

insert into fired_first values(s.nextval,'t1');

end;

create or replace trigger t_2 after insert on emp
begin

insert into fired_first values(s.nextval,'t_2');

end;

insert into emp values(1,'Abdulla');

select * from fired_first;



create or replace trigger t_2 after insert on emp
follows t_1 begin
insert into fired_first values(s.nextval,'t_2');


end;

insert into emp values(2,'Nurlan');
select * from fired_first;


--compound trgger;
create or replace trigger comp_test for insert or update or delete on emp
compound trigger

before statement is
begin

dbms_output.put_line('1');

end before statement;

before each row is
begin
dbms_output.put_line('2');


end before each row;


after each row is
begin
dbms_output.put_line('3');

end after each row;

after statement is
begin

dbms_output.put_line('4');


end after statement;


end;

drop table customers;



create table customers (id number,
emp_name varchar2(100));

create or replace trigger customers_seq
before insert on customers
for each row
declare
v_id number;


begin
select nvl(max(id),0)+1 into v_id from customers;
:new.id:=v_id;

end;


insert into customers(emp_name) values('Abdulla');
select * from customers;



select * from employees where job_id='IT_PROG';



create or replace trigger it_prog_range for update or insert on employees
when (new.job_id='IT_PROG')
compound trigger
v_max_sal number;
v_min_sal number;
before statement is
begin
select max(salary),min(salary) into v_max_sal,v_min_sal from employees where job_id='IT_PROG';

end before statement;

before each row is
begin
if :new.salary not between  v_min_sal and v_max_sal then
raise_application_error(-20300,'invalid range');
end if;
end before each row;
END;

    UPDATE EMPLOYEES SET SALARY=200 WHERE EMPLOYEE_ID=107;

select job_id,min(salary) minsal,max(salary) maxsal from employees group by job_id order by 1;

create or replace trigger change_sal  for insert or update on employees
compound trigger
type job_t is record(min_sal number,max_sal number);
type emp_t is table of job_t  index by varchar2(100);
emp emp_t;
before statement is
BEGIN
for i in (select job_id,min(salary) minsal,max(salary) maxsal from employees group by job_id)
LOOP
 emp(i.job_id).min_sal:=i.minsal;
 emp(i.job_id).max_sal:=i.maxsal;

END LOOP;
end before statement;

before each row is
begin
if :new.salary not between emp(:new.job_id).min_sal and emp(:new.job_id).max_sal then

raise_application_error(-20300,'Invalid range');
end if;
end before each row;
end;

update  employees set salary=1000 where job_id='AC_ACCOUNT';
update employees set salary=100 where employee_id=107;



-- ddl trigger

create or replace trigger ddl_trigger
before create on schema

begin

  if to_number(to_char(sysdate,'hh24')) not between 8 and 10 then
  raise_application_error(-20010,'not allowed in these hours');
  
  end if;

end;


create table b (id number);
drop trigger ddl_trigger;
 


---
drop table ddl_log;

create table ddl_log(
operation varchar2(100),
obj_owner varchar2(100),
object_name varchar2(100),
attemp_by varchar2(100),
attempt_dt date
)

create or replace trigger ddl_trig after ddl
on schema
begin

insert into ddl_log  select ora_sysevent,ora_dict_obj_owner,ora_dict_obj_name,user,sysdate from dual;

end;


select * from ddl_log;


create table t1 (n number);

-- database trigger logon logofff;
alter session set container=orclpdb;

show con_name;
alter database open;





create table log_table(
user_id number,
log_date date,
action varchar2(100)
);


create or replace trigger logon_t after logon on database

begin

insert into log_table values(user,sysdate,'logon');


end;
 


create or replace trigger logof_t before logoff on database
begin

insert into log_table values(user,sysdate,'logoff');



end;


select * from log_table;



