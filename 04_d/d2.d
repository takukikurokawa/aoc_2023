// AoC Day4 Part2
import std.algorithm;
import std.array;
import std.container.rbtree;
import std.stdio;
import std.string;

void main() {
    int[] dp = new int[201];
    for (int c = 1; c <= 198; c++) {
        dp[c]++;
        string l = stdin.readln();
        l = strip(l, "\n");
        auto s = l.split(" ");
        int x = cast(int) s.countUntil!(v => v == "|");
        auto st = redBlackTree(s[0 .. x]);
        st.removeKey("");
        int t = 0;
        foreach (w; s[x + 1 .. s.length]) {
            if (w in st) {
                t++;
            }
        }
        for (int i = 1; i <= t; i++) {
            dp[c + i] += dp[c]; 
        }
    }
    writeln(reduce!((a, b) => a + b)(0, dp));
}
