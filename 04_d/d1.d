// AoC Day4 Part1
import std.algorithm;
import std.array;
import std.container.rbtree;
import std.stdio;
import std.string;

void main() {
    int ans = 0;
    while (true) {
        string l = stdin.readln();
        l = strip(l, "\n");
        if (l.length == 0) {
            break;
        }
        auto s = l.split(" ");
        int x = cast(int) s.countUntil!(v => v == "|");
        auto st = redBlackTree(s[0 .. x]);
        st.removeKey("");
        int t = 0;
        foreach (w; s[x + 1 .. s.length]) {
            if (w in st) {
                t = max(t + 1, 2 * t);
            }
        }
        ans += t;
    }
    writeln(ans);
}
