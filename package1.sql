--

create or replace package area
is
function square_area(p_side number)
return number;
function rectangul_area(p_w number,p_l number)
return number;
--we dont have begin in package specification

end;

create or replace package body area is
function square_area(p_side number)
return number
is
begin
return p_side*p_side;
end;
function rectangul_area(p_w number,p_l number)
return number is
begin
return p_l*p_w;
end;

--begin is optional in package body
begin
dbms_output.put_line('salam aleykum');

end;

begin

dbms_output.put_line(area.square_area(4));
dbms_output.put_line(area.rectangul_area(4,5));


end;
