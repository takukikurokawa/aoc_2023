// AoC Day7 Part1
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

func getScore(s string) int {
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
        return 11
    } else if (c == 'Q') {
        return 12
    } else if (c == 'K') {
        return 13
    } else {
        return 14
    }
}

func main() {
    var c []camel
    for {
        var x camel
        if _, err := fmt.Scan(&x.hand); err != nil {
            break
        }
        fmt.Scan(&x.bid)
        x.score = int64(getScore(x.hand))
        for i := 0; i < 5; i++ {
            x.score *= 100
            x.score += int64(getCardValue(x.hand[i]))
        }
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
    // fmt.Println(c)
    fmt.Println(ans)
}
/*
order := make([]int, n)
for i := 0; i < n; i++ {
    order[i] = i
}
sort.Slice(order[:], func(i, j int) bool {
    if (scores[i] != scores[j]) {
        return scores[i] < scores[j]
    }
    for k := 0; k < 5; k++ {
        if (hands[i][k] != hands[j][k]) {
            return getCardValue(hands[i][k]) < getCardValue(hands[j][k])
        }
    }
    return i < j
})
*/
