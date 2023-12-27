// AoC Day23 Part2
import "io" for File

var dx = [-1, 0, 1, 0]
var dy = [0, 1, 0, -1]

var s = File.read("data/in.txt").trim().split("\n")
var n = s.count
var m = s[0].count

var ans = 0
var set = {}
var dfs = Fn.new {|self, x, y|
    if (x == n - 1) {
        ans = ans.max(set.count)
    }
    set[x * m + y] = null
    for (dir in 0..3) {
        var nx = x + dx[dir]
        var ny = y + dy[dir]
        // System.printAll([" " * 2 * (set.count - 1), x, " ", y, ": ", nx, " ", ny, " ", s[nx][ny], " ", set.containsKey(nx * m + ny)])
        if (nx < 0 || n <= nx || ny < 0 || m <= ny || s[nx][ny] == "#" || set.containsKey(nx * m + ny)) {
            continue
        }
        self.call(self, nx, ny)
    }
    set.remove(x * m + y)
}
dfs.call(dfs, 0, s[0].indexOf("."))
System.print(ans)
