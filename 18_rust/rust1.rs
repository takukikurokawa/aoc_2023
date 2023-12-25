// AoC Day18 Part1
use std::io::{self, BufRead};

fn main() {
    let dx: [i32; 4] = [-1, 0, 1, 0];
    let dy: [i32; 4] = [0, 1, 0, -1];
    let ds: &str = "URDL";
    let mut dir: Vec<char> = Vec::new();
    let mut len: Vec<i32> = Vec::new();
    let mut _col: Vec<String> = Vec::new();
    for l in io::stdin().lock().lines() {
        let t: String = l.unwrap();
        let s: Vec<&str> = t.trim().split_whitespace().collect();
        dir.push(s[0].chars().next().unwrap());
        len.push(s[1].parse::<i32>().unwrap());
        _col.push(s[2][2..8].to_string());
    }
    let n: usize = dir.len();
    let mut area: i32 = 0;
    let mut bound: i32 = 0;
    let mut _x: i32 = 0;
    let mut y: i32 = 0;
    for i in 0..n {
        let index: usize = ds.find(dir[i]).unwrap();
        area += dx[index] * len[i] * y;
        bound += len[i];
        _x += dx[index] * len[i];
        y += dy[index] * len[i];
    }
    let interior: i32 = area - bound / 2 + 1;
    println!("{}", interior + bound);
}
