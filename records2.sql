--
select * from department_copy;

create table copy_department as
select * from departments where 1=2;

select * from copy_department;

--- assosciative array in collecion

declare
type v_assoc is table of varchar2(20) index by  pls_integer;

t_assoc v_assoc;
begin
t_assoc(1):='Abdulla';
t_assoc(2):='Nurlan';
dbms_output.put_line(t_assoc(1));
end;

---
declare
type v_as is table of number index by varchar2(80);

v_ad v_as;
begin
v_ad('Abdulla'):=1;
v_ad('Nurlan'):=2;
dbms_output.put_line(v_ad('Abdulla'));
dbms_output.put_line(v_ad('Nurlan'));
end;








