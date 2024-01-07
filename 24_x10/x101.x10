// AoC Day24 Part1
import x10.util.ArrayList;
import x10.util.RailUtils;

public class Main {
    public static struct Hailstone {
        public val px: Long;
        public val py: Long;
        public val pz: Long;
        public val vx: Long;
        public val vy: Long;
        public val vz: Long;

        public def this(r: Rail[Long]) {
            this.px = r(0);
            this.py = r(1);
            this.pz = r(2);
            this.vx = r(3);
            this.vy = r(4);
            this.vz = r(5);
            assert vx != 0;
            assert vy != 0;
            assert vz != 0;
        }
    }

    static def checkIsect2D(a: Hailstone, b: Hailstone, min: Long, max: Long): Boolean {
        var den: Long = a.vx * b.vy - b.vx * a.vy;
        if (den == 0) {
            return false;
        }
        val x: Double = ((a.py - b.py) as Double * a.vx * b.vx
                       - (a.px as Double * a.vy * b.vx)
                       + (b.px as Double * b.vy * a.vx)) / den;
        val y: Double = ((b.px - a.px) as Double * a.vy * b.vy
                       + (a.py as Double * a.vx * b.vy)
                       - (b.py as Double * b.vx * a.vy)) / den;
        return (min <= x && x <= max)
            && (min <= y && y <= max)
            && ((x - a.px) / a.vx >= 0)
            && ((x - b.px) / b.vx >= 0);
    }

    static def readLines(): Rail[String] {
        val lines: ArrayList[String] = new ArrayList[String]();
        while (Console.IN.available() != 0) {
            val line: String = Console.IN.readLine();
            lines.add(line);
        }
        return lines.toRail();
    }

    static def replace(s: String, from: String, to: String): String {
        val index: Long = s.indexOf(from);
        val head: String = s.substring(0 as Int, index as Int);
        val tail: String = s.substring((index + from.length()) as Int);
        return head + to + tail;
    }

    // "20, 19, 15 @  1, -5, -3" -> [20, 19, 15, 1, -5, -3]
    static def splitLine(s: String): Rail[Long] {
        val fmt: Rail[String] = replace(s, " @ ", ", ").split(", ");
        return new Rail[Long](fmt.size, (i: Long) => Long.parse(fmt(i).trim()));
    }

    public static def main(args: Rail[String]): void {
        val lines: Rail[String] = readLines();
        val hailstones: Rail[Hailstone] = new Rail[Hailstone](lines.size, (i: Long) => new Hailstone(splitLine(lines(i))));
        val n: Long = hailstones.size;
        var ans: Long = 0;
        for (i in (0..(n - 1))) {
            for (j in ((i + 1)..(n - 1))) {
                if (checkIsect2D(hailstones(i), hailstones(j), 200000000000000, 400000000000000)) {
                    ans = ans + 1;
                }
            }
        }
        Console.OUT.println(ans);
    }
}
