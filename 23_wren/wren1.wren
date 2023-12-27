// AoC Day23 Part1
import "io" for File

var dx = [-1, 0, 1, 0]
var dy = [0, 1, 0, -1]
var dz = "^>v<"

var s = File.read("data/in.txt").trim().split("\n")
var n = s.count
var m = s[0].count

var d = []
for (i in 1..n) {
    var d0 = []
    for (j in 1..m) {
        var d1 = []
        for (k in 1..4) {
            d1.add(-1)
        }
        d0.add(d1)
    }
    d.add(d0)
}

var queue = []
d[0][1][2] = 0
queue.insert(-1, [0, 1, 2])
while (queue.count > 0) {
    var x = queue[0][0]
    var y = queue[0][1]
    var z = queue[0][2]
    // System.printAll(d[7][3])
    queue.removeAt(0)
    for (dir in 0..3) {
        if ((dir ^ z) == 2) {
            continue
        }
        if (s[x][y] != "." && s[x][y] != dz[z]) {
            continue
        }
        var nx = x + dx[dir]
        var ny = y + dy[dir]
        if (nx < 0 || n <= nx || ny < 0 || m <= ny || s[nx][ny] == "#") {
            continue
        }
        /*
        if (x == 7 && y == 3) {
            System.print(d[nx][ny][dir])
            System.print(d[x][y][z])
            System.printAll([nx, " ", ny, " ", dir])
        }
        */
        if (d[nx][ny][dir] < d[x][y][z] + 1) {
            d[nx][ny][dir] = d[x][y][z] + 1
            queue.insert(-1, [nx, ny, dir])
        }
    }
}
System.print(d[-1][-2][2])
