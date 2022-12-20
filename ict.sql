drop table students;


create table students (student_id number,
student_name varchar2(100),
bod date);

insert into students values(1,'Abdulla','21-OCT-1997');
insert into students values(2,'Nurlan','24-OCT-1996');
insert into students values(3,'Merac','12-JUL-1996');


select * from students;


--c
create or replace view v1_students as

select * from students;

create or replace procedure print_all_students is
begin
for i in (select * from v1_students)
loop
dbms_output.put_line(i.student_id||i.student_name);
end loop;
end;





