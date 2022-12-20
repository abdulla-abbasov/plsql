--utl file exampele


declare



begin



end;

    select * from all_directories;
    
    
    
    
create or replace procedure 
read_any_directory (l_dir in varchar2,l_file_name varchar2)
is
l_file UTL_FILE.file_type;
l_text varchar2(32767);
begin
l_file:=UTL_FILE.fopen(l_dir,l_file_name,'r');
begin
loop
UTL_FILE.get_line(l_file,l_text);
dbms_output.put_line('text is '||l_text);
end loop;
exception when no_data_found then
dbms_output.put_line('there is no data here');
UTL_FILE.fclose(l_file);

end;
exception
when UTL_FILE.invalid_operation then
    dbms_output.put_line('there is invalid operation here');
when UTL_FILE.read_error then
    dbms_output.put_line('there is read error here');

end read_any_directory;

EXECUTE READ_ANY_DIRECTORY('DOC','sample');


--utl mail send example;







    