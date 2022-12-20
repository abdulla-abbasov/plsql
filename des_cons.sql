select * from departments;




declare
e_fk_err exception;
pragma EXCEPTION_INIT(e_fk_err,-02292);
begin
 delete from departments;
 
 exception 
 when e_fk_err then
 RAISE_APPLICATION_ERROR (-20001,'ERROR');
 end;
 
 
 
 
 
 
 
 
 declare
e_fk_err exception;
pragma EXCEPTION_INIT(e_fk_err,-02292);
begin
 delete from departments;
 
 exception 
 when e_fk_err then
 raise_application_error(-20001,'ERROR',true);
 end;
 
 
 
 
 
 
 
 
 -----
 
 create or replace procedure  aue(vemp_id number)
 is
 emp_info employees%rowtype;
 function tax(p_salary number) return number
 is
 
 begin
 return p_salary*0.85;
 
 end;
 
 begin
 select * into emp_info from employees where employee_id=vemp_id;
 dbms_output.put_line('tax salary'||tax(emp_info.salary));
 
 
 end;
 
 
 execute aue(100);
 
 
 
 --definers right
 
 drop table hr_table;
 
 
 create table hr_table(p_id number,p_name varchar2(100));
 
 
create or replace procedure add_hr(hr_id number,hr_name varchar2)
is

begin
insert into hr_table values(hr_id,hr_name);

end;
 
execute add_hr(1,'Abdulla');
select * from hr_table;
 
 
 
 grant execute on add_hr to ford;
 
  grant execute on add_hr_2 to ford;

 
 
 create or replace procedure add_hr_2(e_id number,e_name varchar2) authid current_user
is


begin
insert into hr_table values(e_id,e_name);


end;
 
 
 
 
 
 
 ---- AUTONOMOUS TRANSACTION
 
 create table t(p_name varchar2(100)); 
 
 
 
 create or replace procedure child_block
 is
 
 begin
 
 insert into t  values('child block executed');
 commit;
 
 end;
 
 execute child_block;
 execute parent_block;
 
 select * from t;
 
 
 
 create or replace procedure parent_block
 is 
 
 begin
 insert into t values('parent block executed');
 child_block;
 rollback;
 
 end;
 
 
 select * from t;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ----
 
 create or replace procedure pass_by_value_1(p_id in out number)
 is 
 
 
 begin
 p_id:=p_id*10;
 if  p_id>100 then
 raise VALUE_ERROR;
  end if;
end; 
 
 
 
 
 declare
 v number:=5; ----try first 5 then 10;
 begin
  pass_by_value_1(v);
 
 dbms_output.put_line('no issue'||v);
 exception 
 when value_error then
 
 
 dbms_output.put_line('exception'||v);
 
 
 end;
 
 
 
 -- no copy ill go no effects
 
 
 
create or replace procedure pass_by_value_3(p_id in out nocopy number)
is
begin
p_id:=p_id*10;
if p_id>100 then 
raise value_error;
end if;
end;




declare

v  number(10):=20; -- if the actual value is number no copy hint not work here thumbs up and remember it
begin
pass_by_value_3(v);
dbms_output.put_line('no issue'||v);
exception
when value_error then
dbms_output.put_line('exception'||v);
end;

 
 
 
 
 
 
 -- create package specification
 
 
 create or replace package nocopy_test is
 
type number_t is table of varchar2(32767)  index by binary_integer; 
procedure pass_by_value (nums in out number_t);
procedure pass_by_reference (nums in out nocopy number_t);
procedure init; 
end;
 
 
 
 create or replace package body nocopy_test is
 l_numbers  number_t;
 c_array_size number(10000);
 c_it number:=20;
 procedure pass_by_value(nums in out number_t)
 is
 indx pls_integer;
 begin
 indx:=nums.count;
 end;
 ----
 procedure pass_by_reference(nums in out nocopy number_t)
 is 
 indx pls_integer;
 begin
 indx:=nums.count;
 end;
 
     procedure init
     is
     begin
     l_numbers.delete;
     for i in 1..c_array_size
     loop
     l_numbers(i):='s'||i;
     end  loop;
    dbms_output.put_line('start'||to_char(sysdate,'hh:mi:ss'));
     for i in 1..1000
     loop
     pass_by_value(l_numbers);
     
     end loop;
     dbms_output.put_line('end'||to_char(sysdate,'hh:mi:ss'));
    dbms_output.put_line('start'||to_char(sysdate,'hh:mi:ss'));
    
    for i in 1..1000
    
    
    loop
    pass_by_reference(l_numbers);
    end loop;
    
    dbms_output.put_line('end'||to_char(sysdate,'hh:mi:ss'));
    
    end;


end;
------ 
begin
 nocopy_test.init;
end;
 
 
 
 
 
 --- write a function to sum salary each of employees
 
 
 
 
 
 
 
 
 
 
 
 
 