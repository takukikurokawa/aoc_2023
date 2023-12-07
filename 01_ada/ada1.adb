with Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure Ada1 is
    s : String (1 .. 100);
    last : Natural;
    ans : Integer := 0;
begin
    loop
        begin
            Ada.Text_IO.Get_line(s, last);
        exception
            when Ada.Text_IO.End_Error =>
                exit;
        end;
        for i in 1 .. last loop
            if s(i) in '0' .. '9' then
                ans := ans + 10 * (Character'Pos(s(i)) - Character'Pos('0'));
                exit;
            end if;
        end loop;
        for i in reverse 1 .. last loop
            if s(i) in '0' .. '9' then
                ans := ans + (Character'Pos(s(i)) - Character'Pos('0'));
                exit;
            end if;
        end loop;
    end loop;
    Ada.Integer_Text_IO.Put(ans);
end Ada1;
