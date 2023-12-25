// AoC Day18 Part2
use std::io::{self, BufRead};

fn main() {
    let dx: [i32; 4] = [0, 1, 0, -1];
    let dy: [i32; 4] = [1, 0, -1, 0];
    let mut area: i64 = 0;
    let mut bound: i64 = 0;
    let mut _x: i64 = 0;
    let mut y: i64 = 0;
    for l in io::stdin().lock().lines() {
        let t: String = l.unwrap();
        let s: Vec<&str> = t.trim().split_whitespace().collect();
        let dir: usize = s[2][7..8].parse::<usize>().unwrap();
        let len: i64 = i64::from_str_radix(&s[2][2..7], 16).unwrap();
        area += dx[dir] as i64 * len * y;
        bound += len;
        _x += dx[dir] as i64 * len;
        y += dy[dir] as i64 * len;
    }
    let interior: i64 = area - bound / 2 + 1;
    println!("{}", interior + bound);
}
