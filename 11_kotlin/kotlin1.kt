// AoC Day11 Part1
import kotlin.math.abs

fun main() {
    val s = ArrayList<String>()
    while (true) {
        try {
            val l = readln()
            s.add(l)
        } catch (e: Exception) {
            break
        }
    }
    var h = s.size
    var w = s[0].length
    for (i in h - 1 downTo 0) {
        if (s[i].all { it == '.' }) {
            s.add(i + 1, s[i])
            h++
        }
    }
    for (j in w - 1 downTo 0) {
        if (s.all { it[j] == '.' }) {
            for (i in 0 until h) {
                s[i] = s[i].substring(0, j + 1) + "." + s[i].substring(j + 1)
            }
            w++
        }
    }
    val a = ArrayList<Pair<Int, Int>>()
    for (i in 0 until h) {
        for (j in 0 until w) {
            if (s[i][j] == '#') {
                a.add(Pair(i, j))
            }
        }
    }
    val n = a.size
    var ans = 0
    for (i in 0 until n) {
        for (j in i + 1 until n) {
            val (x0, y0) = a[i]
            val (x1, y1) = a[j]
            ans += abs(x0 - x1) + abs(y0 - y1)
        }
    }
    println(ans)
}
