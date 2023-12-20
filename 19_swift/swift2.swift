// AoC Day19 Part2
struct Rule {
    let variable: Character
    let relation: Character
    let constant: Int
    let nextWf: String

    func eval(_ ratings: [Character: (Int, Int)]) -> ([Character: (Int, Int)], [Character: (Int, Int)]) {
        if (relation == "<") {
            var satisfied = ratings
            var failed = ratings
            satisfied[variable] = (satisfied[variable]!.0, min(constant - 1, satisfied[variable]!.1))
            failed[variable] = (max(constant, failed[variable]!.0), failed[variable]!.1)
            return (satisfied, failed)
        }
        if (relation == ">") {
            var satisfied = ratings
            var failed = ratings
            satisfied[variable] = (max(constant + 1, satisfied[variable]!.0), satisfied[variable]!.1)
            failed[variable] = (failed[variable]!.0, min(constant, failed[variable]!.1))
            return (satisfied, failed)
        }
        let empty = "xmas".reduce(into: [Character: (Int, Int)]()) { (map, char) in map[char] = (1, 0) }
        return (empty, ratings)
    }
}

struct Workflow {
    let name: String
    let rules: [Rule]
    let defaultWf: String
}

func extractRule(from s: String) -> Rule {
    let variable = s[s.index(s.startIndex, offsetBy: 0)]
    let relation = s[s.index(s.startIndex, offsetBy: 1)]
    let constant = Int(s[s.index(s.startIndex, offsetBy: 2)..<s.firstIndex(of: ":")!])!
    let nextWf = String(s[s.index(s.firstIndex(of: ":")!, offsetBy: 1)...])
    return Rule(variable: variable, relation: relation, constant: constant, nextWf: nextWf)
}

func extractWorkflow(from s: String) -> Workflow {
    let name = String(s[..<s.firstIndex(of: "{")!])
    let rules = s[s.index(s.firstIndex(of: "{")!, offsetBy: 1)..<s.lastIndex(of: ",")!].split(separator: ",").map { extractRule(from: String($0)) }
    let defaultWf = String(s[s.index(s.lastIndex(of: ",")!, offsetBy: 1)..<s.lastIndex(of: "}")!])
    return Workflow(name: name, rules: rules, defaultWf: defaultWf)
}

func searchWorkflow(through mapWf: [String: Workflow], from current: String, with ratings: [Character: (Int, Int)]) -> Int {
    // print(current)
    // print(ratings)
    let invalid = "xmas".reduce(into: false) { (invalid, char) in invalid = invalid || (ratings[char]!.0 > ratings[char]!.1) }
    if invalid {
        return 0
    } else if current == "A" {
        let count = "xmas".reduce(into: 1) { (count, char) in count *= (ratings[char]!.1 - ratings[char]!.0 + 1) }
        // let calc: (Int) -> Int = { x in return x * (x + 1) / 2 }
        // let res = "xmas".reduce(into: 0) { (res, char) in res += (ratings[char]!.1 + ratings[char]!.0) } * count / 2
        return count
    } else if current == "R" {
        return 0
    } else {
        var res = 0
        let node = mapWf[current]!
        var currentRatings = ratings
        for rule in node.rules {
            let (satisfied, failed) = rule.eval(currentRatings)
            res += searchWorkflow(through: mapWf, from: rule.nextWf, with: satisfied)
            currentRatings = failed
        }
        res += searchWorkflow(through: mapWf, from: node.defaultWf, with: currentRatings)
        return res
    }
}

func main() {
    var mapWf = [String: Workflow]()
    while true {
        let line = readLine()!
        if (line == "") {
            break
        }
        let wf = extractWorkflow(from: line)
        mapWf[wf.name] = wf
    }
    var ratings = [Character: (Int, Int)]()
    ratings["x"] = (1, 4000)
    ratings["m"] = (1, 4000)
    ratings["a"] = (1, 4000)
    ratings["s"] = (1, 4000)
    let ans = searchWorkflow(through: mapWf, from: "in", with: ratings)
    print(ans)
}

main()
