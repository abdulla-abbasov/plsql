declare
l_file UTL_FILE.file_type;
l_location varchar2(100):='MYDIR';
l_filename varchar2(100):='sample.txt';
l_text varchar2(100);

begin   
--open file;
l_file:= UTL_FILE.fopen(l_location,l_filename,'r');
UTL_FILE.GET_LINE(l_file,l_text);
dbms_output.put_line('first line'||l_text);
UTL_FILE.GET_LINE(l_file,l_text);
dbms_output.put_line('ikinci line'||l_text);

UTL_FILE.fclose(l_file);
end;



--write file









declare
l_file UTL_FILE.file_type;
l_location VARCHAR2(100):='C';
l_filename VARCHAR2(100):='sample2.txt';




begin

  l_file:=UTL_FILE.fopen(l_location,l_filename,'w');


   for i in (select * from departments)
   loop
   
   UTL_FILE.PUT_LINE(l_file,i.department_name);
   
   
   end loop;
   
   UTL_FILE.fclose(l_file);
   
   

end;








