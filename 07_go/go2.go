// AoC Day7 Part2
package main

import (
    "fmt"
    "sort"
)

type camel struct {
    hand  string
    bid   int
    score int64
}

func getHandScore(s string) int {
    mp := make(map[rune]int)
    for _, c := range s {
        if _, ok := mp[c]; ok {
            mp[c]++
        } else {
            mp[c] = 1
        }
    }
    res := 0
    for _, v := range mp {
        t := 1
        for j := 0; j < v; j++ {
            t *= 10
        }
        res += t
    }
    return res
}

func getCardValue(c byte) int {
    if (2 <= int(c - '0') && int(c - '0') <= 9) {
        return int(c - '0')
    } else if (c == 'T') {
        return 10
    } else if (c == 'J') {
        return 1
    } else if (c == 'Q') {
        return 12
    } else if (c == 'K') {
        return 13
    } else {
        return 14
    }
}

func dfs(s string, i int) int64 {
    if (i == 5) {
        return int64(getHandScore(s))
    } else if (s[i] != 'J') {
        return dfs(s, i + 1)
    } else {
        res := int64(0)
        for _, c := range "23456789TJQKA" {
            t := s[:i] + string(c) + s[i + 1:]
            d := dfs(t, i + 1)
            if (d > res) {
                res = d
            }
        }
        return res
    }
}

func getScore(s string) int64 {
    res := dfs(s, 0)
    for i := 0; i < 5; i++ {
        res *= 100
        res += int64(getCardValue(s[i]))
    }
    return res
}

func main() {
    var c []camel
    for {
        var x camel
        if _, err := fmt.Scan(&x.hand); err != nil {
            break
        }
        fmt.Scan(&x.bid)
        x.score = getScore(x.hand)
        c = append(c, x)
    }
    n := len(c)
    sort.Slice(c, func(i, j int) bool {
        return c[i].score < c[j].score
    })
    ans := 0
    for i := 0; i < n; i++ {
        ans += (i + 1) * c[i].bid
    }
    fmt.Println(ans)
}
