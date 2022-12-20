--Write a PL/SQL code to count the number of Sundays between the two inputted dates.
create or replace function get_sundays
return number
is

v_num number;
begin
v_1 :=&first_date;
v_1 :=&second_date;


end;

declare
v_1 date;
v_2 date;
v_num number;

begin  
v_1 :=&first_date;
v_2 :=&second_date;

dbms_output.put_line(to_char(v_1,'dd'));

end;