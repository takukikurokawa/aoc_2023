# AoC Day17 Part1
%new-style

list<string> s;
while (True) {
    *string l = stdin.readLine();
    if (!exists l) {
        break;
    }
    string t = l;
    s += trim(t);
}

int n = s.size();
int m = s[0].size();
int inf = int(1e9);
list<int> dx = (-1, 0, 1, 0);
list<int> dy = (0, 1, 0, -1);

list<int> d;
for (int i = 0; i < n * m * 4; i++) {
    d += inf;
}
for (int k = 0; k < 4; k++) {
    d[k] = 0;
}

list<bool> ok;
for (int i = 0; i < d.size(); i++) {
    ok += False;
}

sub convert(int x, int y, int z) {
    return (x * m + y) * 4 + z;
}

for (int e = 0; e < d.size(); e++) {
    int t = -1;
    int mn = inf;
    for (int i = 0; i < d.size(); i++) {
        if (!ok[i] && mn >= d[i]) {
            t = i;
            mn = d[i];
        }
    }
    int x = t / 4 / m % n;
    int y = t / 4 % m;
    int z = t % 4;
    # printf("%d %d %d %d %d %d\n", x, y, z, t, convert(x, y, z), d[t]);
    ok[convert(x, y, z)] = True;
    for (int dir = 0; dir < 4; dir++) {
        if (abs(dir - z) % 2 == 0) {
            continue;
        }
        int c = 0;
        for (int len = 1; len <= 3; len++) {
            int nx = x + dx[dir] * len;
            int ny = y + dy[dir] * len;
            if (nx < 0 || n <= nx || ny < 0 || m <= ny) {
                break;
            }
            int nz = dir;
            int nt = convert(nx, ny, nz);
            c += int(s[nx][ny]) - int('0');
            d[nt] = min(d[nt], d[t] + c);
        }
    }
}

int ans = inf;
for (int k = 0; k < 4; k++) {
    ans = min(ans, d[convert(n - 1, m - 1, k)]);
}
printf("%d\n", ans);
