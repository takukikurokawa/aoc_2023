// AoC Day16 Part1
Program Pascal1;

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
    s: array of string;
    buf: string;
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
    // writeln(n, ' ', m);
    SetLength(a, n + 1, m + 1, 4);
    SetLength(que, 4 * n * m);
    qbeg := 0;
    qend := 0;
    if (s[1][1] = '\') or (s[1][1] = '|') then
        Add(1, 1, 2);
    if (s[1][1] = '/') or (s[1][1] = '|') then
        Add(1, 1, 0);
    if (s[1][1] = '.') or (s[1][1] = '-') then
        Add(1, 1, 1);
    while qbeg < qend do
    begin
        x := que[qbeg].x;
        y := que[qbeg].y;
        z := que[qbeg].z;
        // writeln(qbeg, ' ', x, ' ', y, ' ', z);
        qbeg := qbeg + 1;
        nx := x + dx[z];
        ny := y + dy[z];
        if (nx < 1) or (n < nx) or (ny < 1) or (m < ny) then
            continue;
        if s[nx][ny] = '.' then
            Add(nx, ny, z)
        else if s[nx][ny] = '/' then
            Add(nx, ny, z xor 1)
        else if s[nx][ny] = '\' then
            Add(nx, ny, z xor 3)
        else if s[nx][ny] = '|' then
            if z mod 2 = 0 then
                Add(nx, ny, z)
            else
            begin
                Add(nx, ny, 0);
                Add(nx, ny, 2);
            end
        else if s[nx][ny] = '-' then
            if z mod 2 = 1 then
                Add(nx, ny, z)
            else
            begin
                Add(nx, ny, 1);
                Add(nx, ny, 3);
            end;
    end;
    ans := 0;
    for i := 1 to n do
        for j := 1 to m do
            if a[i][j][0] or a[i][j][1] or a[i][j][2] or a[i][j][3] then
                ans := ans + 1;
    writeln(ans);
end.
