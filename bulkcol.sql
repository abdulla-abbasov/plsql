--
drop table emp;

create table emp as
select * from employees;

select * from emp;
--write plsql code collect name into type of nested table 

--
declare
type mp_name is table of varchar2(100);
my_nested_table mp_name:=mp_name();

begin
    for i in (select * from emp) loop
    my_nested_table.extend();
    my_nested_table(my_nested_table.last):=i.first_name;
    
    end loop;
    
    for i in my_nested_table.first..my_nested_table.last loop
    dbms_output.put_line(my_nested_table(i));
    
    
    end loop;
    

end;
----
drop table students;

create table students(name varchar2(100) not null);

set serveroutput on;

declare
type st_col is table of varchar2(100);
main_t st_col:=st_col();
begin
main_t.extend(7);
main_t(1):='Abdulla';
main_t(2):='Nurlan';
main_t(3):='Ali';
main_t(4):='Ehmed';
main_t(5):='Xalil';
main_t(6):='Ferhad';
main_t(7):='Abdulla';

forall i in main_t.first..main_t.last

 --dbms_output.put_line(main_t(i));
 insert into students values(main_t(i));
end;


select * from students;
rollback;








