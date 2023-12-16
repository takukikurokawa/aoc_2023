// AoC Day16 Part2
Program Pascal2;

function Calculate(sx, sy, sz: integer; s: array of string): integer;
type
    Tuple = record
        x, y, z: integer;
    end;

var
    n, m: integer;
    x, y, z: integer;
    nx, ny: integer;
    i, j: integer;
    ans: integer;
    qbeg, qend: integer;
    a: array of array of array of boolean;
    dx: array[0 .. 3] of integer = (-1, 0, 1, 0);
    dy: array[0 .. 3] of integer = (0, 1, 0, -1);
    que: array of Tuple;

procedure Add(p, q, r: integer);
begin
    if not a[p][q][r] then
    begin
        a[p][q][r] := true;
        que[qend].x := p;
        que[qend].y := q;
        que[qend].z := r;
        qend := qend + 1;
    end;
end;

procedure Check(p, q, r: integer);
begin
    if s[p][q] = '.' then
        Add(p, q, r)
    else if s[p][q] = '/' then
        Add(p, q, r xor 1)
    else if s[p][q] = '\' then
        Add(p, q, r xor 3)
    else if s[p][q] = '|' then
        if z mod 2 = 0 then
            Add(p, q, r)
        else
        begin
            Add(p, q, 0);
            Add(p, q, 2);
        end
    else if s[p][q] = '-' then
        if z mod 2 = 1 then
            Add(p, q, r)
        else
        begin
            Add(p, q, 1);
            Add(p, q, 3);
        end;
end;

begin
    n := Length(s) - 1;
    m := Length(s[1]);
    SetLength(a, n + 1, m + 1, 4);
    SetLength(que, 4 * n * m);
    qbeg := 0;
    qend := 0;
    Check(sx, sy, sz);
    while qbeg < qend do
    begin
        x := que[qbeg].x;
        y := que[qbeg].y;
        z := que[qbeg].z;
        qbeg := qbeg + 1;
        nx := x + dx[z];
        ny := y + dy[z];
        if (nx < 1) or (n < nx) or (ny < 1) or (m < ny) then
            continue;
        Check(nx, ny, z);
    end;
    ans := 0;
    for i := 1 to n do
        for j := 1 to m do
            if a[i][j][0] or a[i][j][1] or a[i][j][2] or a[i][j][3] then
                ans := ans + 1;
    Calculate := ans;
end;

function Max(a, b: integer): integer;
begin
    if a > b then
        Max := a
    else
        Max := b;
end;

var
    n, m: integer;
    i, j, k: integer;
    ans: integer;
    s: array of string;
    buf: string;

begin
    SetLength(s, 1);
    while not eof do
    begin
        readln(buf);
        SetLength(s, Length(s) + 1);
        s[High(s)] := buf;
    end;
    n := Length(s) - 1;
    m := Length(s[1]);
    ans := 0;
    for i := 1 to n do
        for k := 0 to 3 do
        begin
            ans := Max(ans, Calculate(i, 1, k, s));
            ans := Max(ans, Calculate(i, m, k, s));
        end;
    for j := 1 to m do
        for k := 0 to 3 do
        begin
            ans := Max(ans, Calculate(1, j, k, s));
            ans := Max(ans, Calculate(n, j, k, s));
        end;
    writeln(ans);
end.
