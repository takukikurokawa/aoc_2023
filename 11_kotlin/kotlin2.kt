// AoC Day11 Part2
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
    val h = s.size
    val w = s[0].length
    val a = ArrayList<Pair<Int, Int>>()
    for (i in 0 until h) {
        for (j in 0 until w) {
            if (s[i][j] == '#') {
                a.add(Pair(i, j))
            }
        }
    }
    val n = a.size
    var ans = 0L
    for (i in 0 until n) {
        for (j in i + 1 until n) {
            val (x0, y0) = a[i]
            val (x1, y1) = a[j]
            var cnt = 0
            for (x in minOf(x0, x1) + 1 until maxOf(x0, x1)) {
                if (s[x].all { it == '.' }) {
                    cnt++
                }
            }
            for (y in minOf(y0, y1) + 1 until maxOf(y0, y1)) {
                if (s.all { it[y] == '.' }) {
                    cnt++
                }
            }
            ans += (abs(x0 - x1) + abs(y0 - y1) + cnt * 999999).toLong()
        }
    }
    println(ans)
}
