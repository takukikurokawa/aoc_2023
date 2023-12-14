# AoC Day14 Part1
var s: seq[string] = @[]

try:
    while true:
        let l = readLine(stdin)
        if l == "":
            break
        s.add(l)
except EOFError:
    discard

let n = len(s)
let m = len(s[0])
var ans = 0

for j in 0..m - 1:
    var t = 0
    for i in 0..n - 1:
        if s[i][j] == 'O':
            ans += n - t
            t += 1
        elif s[i][j] == '#':
            t = i + 1

echo ans
