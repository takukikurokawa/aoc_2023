with Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure Ada2 is
    s : String (1 .. 100);
    last : Natural;
    ans : Integer := 0;
    numbers : array (1 .. 9) of String (1 .. 6) := ("one???", "two???", "three?", "four??", "five??", "six???", "seven?", "eight?", "nine??");
begin
    loop
        begin
            Ada.Text_IO.Get_line(s, last);
        exception
            when Ada.Text_IO.End_Error =>
                exit;
        end;
        loop1:
        for i in 1 .. last loop
            if s(i) in '0' .. '9' then
                ans := ans + 10 * (Character'Pos(s(i)) - Character'Pos('0'));
                exit;
            end if;
            for j in 1 .. 9 loop
                for k in 1 .. 6 loop
                    if numbers(j)(k) = '?' then
                        ans := ans + 10 * j;
                        exit loop1;
                    end if;
                    if i + k - 1 > last or s(i + k - 1) /= numbers(j)(k) then
                        exit;
                    end if;
                end loop;
            end loop;
        end loop loop1;
        loop2:
        for i in reverse 1 .. last loop
            if s(i) in '0' .. '9' then
                ans := ans + (Character'Pos(s(i)) - Character'Pos('0'));
                exit;
            end if;
            for j in 1 .. 9 loop
                for k in 1 .. 6 loop
                    if numbers(j)(k) = '?' then
                        ans := ans + j;
                        exit loop2;
                    end if;
                    if i + k - 1 > last or s(i + k - 1) /= numbers(j)(k) then
                        exit;
                    end if;
                end loop;
            end loop;
        end loop loop2;
    end loop;
    Ada.Integer_Text_IO.Put(ans);
end Ada2;
