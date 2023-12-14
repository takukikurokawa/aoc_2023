# AoC Day14 Part2
import std/hashes
import tables

proc hash(x: seq[seq[char]]): Hash =
    var h: Hash = 0
    for y in x:
        for z in y:
            h = h !& hash(z)
    return !$h

proc rotate(x: seq[seq[char]]): seq[seq[char]] =
    var y: seq[seq[char]] = @[]
    let n = len(x[0])
    let m = len(x)
    for i in 0..n - 1:
        y.add(@[])
        for j in 0..m - 1:
            y[i].add(x[m - 1 - j][i])
    return y

proc tilt(x: seq[seq[char]]): seq[seq[char]] =
    var y: seq[seq[char]] = x
    let n = len(x[0])
    let m = len(x)
    for j in 0..m - 1:
        var k: int = 0
        for i in 0..n - 1:
            if y[i][j] == '#':
                k = i + 1
            elif x[i][j] == 'O':
                y[i][j] = '.'
                y[k][j] = 'O'
                k += 1
    return y

proc cycle(x: seq[seq[char]]): seq[seq[char]] =
    var y: seq[seq[char]] = x
    for i in 0..3:
        y = rotate(tilt(y))
    result = y

var s: seq[seq[char]] = @[]
try:
    while true:
        let l = readLine(stdin)
        if l == "":
            break
        var t: seq[char] = @[]
        for c in l:
            t.add(c)
        s.add(t)
except EOFError:
    discard

let c = 1000000000
let n = len(s)
let m = len(s[0])

var mp: Table[seq[seq[char]], int] = initTable[seq[seq[char]], int]()
var st: seq[seq[seq[char]]] = @[]

st.add(s)
mp[s] = 0

for i in 1..c:
    s = cycle(s)
    if mp.contains(s):
        let l = i - mp[s]
        s = st[mp[s] + (c - mp[s]) mod l]
        break
    st.add(s)
    mp[s] = i

var ans = 0
for i in 0..n - 1:
    for j in 0..m - 1:
        if s[i][j] == 'O':
            ans += n - i
echo ans
