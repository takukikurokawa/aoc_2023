// AoC Day24 Part2
import x10.lang.Math;
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
        }

        public def this(px: Long, py: Long, pz: Long, vx: Long, vy: Long, vz: Long) {
            this.px = px;
            this.py = py;
            this.pz = pz;
            this.vx = vx;
            this.vy = vy;
            this.vz = vz;
        }
    }

    static def checkIsect(a: Hailstone, b: Hailstone): Boolean {
        if ((a.px - b.px) as Double * (a.vx - b.vx) > 0.0) {
            return false;
        }
        if (!isSameDouble((a.px - b.px) as Double * (a.vy - b.vy), (a.py - b.py) as Double * (a.vx - b.vx))) {
            return false;
        }
        if (!isSameDouble((a.px - b.px) as Double * (a.vz - b.vz), (a.pz - b.pz) as Double * (a.vx - b.vx))) {
            return false;
        }
        return true;
    }

    static def checkIsectAll(a: Rail[Hailstone], b: Hailstone): Boolean {
        for (x in a) {
            if (!checkIsect(x, b)) {
                return false;
            }
        }
        return true;
    }

    static def solveLinear(a: Long, b: Long, c: Long, d: Long, e: Long, f: Long): Rail[Long] {
        val res: Rail[Long] = new Rail[Long](2);
        if (a * e - b * d == 0) {
            return res;
        }
        res(0) = (c * e - b * f) / (a * e - b * d);
        res(1) = (a * f - c * d) / (a * e - b * d);
        return res;
    }

    public static def main(args: Rail[String]): void {
        val lines: Rail[String] = readLines();
        val h: Rail[Hailstone] = new Rail[Hailstone](lines.size, (i: Long) => new Hailstone(splitLine(lines(i))));
        val n: Long = h.size;
        val lim: Long = 500;
        for (vx in (-lim..lim)) {
            for (vy in (-lim..lim)) {
                val t: Rail[Long] = solveLinear(h(0).vx - vx, vx - h(1).vx, h(1).px - h(0).px, h(0).vy - vy, vy - h(1).vy, h(1).py - h(0).py);
                if (t(0) - t(1) == 0) {
                    continue;
                }
                val vz: Long = ((h(0).vz * t(0) + h(0).pz) - (h(1).vz * t(1) + h(1).pz)) / (t(0) - t(1));
                val px: Long = h(0).px + (h(0).vx - vx) * t(0);
                val py: Long = h(0).py + (h(0).vy - vy) * t(0);
                val pz: Long = h(0).pz + (h(0).vz - vz) * t(0);
                val r: Hailstone = new Hailstone(px, py, pz, vx, vy, vz);
                // Console.OUT.println(r);
                if (checkIsectAll(h, r)) {
                    Console.OUT.println(px + py + pz);
                    return;
                }
            }
        }
        Console.OUT.println(-1);
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

    static def isSameDouble(x: Double, y: Double): Boolean {
        // Console.OUT.println(x);
        // Console.OUT.println(y);
        // Console.OUT.println(Math.abs(x - y));
        // Console.OUT.println(1e-6 * Math.max(Math.abs(x), Math.abs(y)));
        return Math.abs(x - y) < 1e-6 * Math.max(1.0, Math.max(Math.abs(x), Math.abs(y)));
    }
}
