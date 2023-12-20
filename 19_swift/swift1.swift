// AoC Day19 Part1
import Glibc

struct Rule {
    let variable: Character
    let relation: Character
    let constant: Int
    let nextWf: String

    func check(_ rating: [Character: Int]) -> Bool {
        if (relation == "<" && rating[variable]! < constant) {
            return true
        }
        if (relation == ">" && rating[variable]! > constant) {
            return true
        }
        return false
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

func searchWorkflow(through mapWf: [String: Workflow], from current: String, with rating: [Character: Int]) -> Bool {
    if current == "A" {
        return true
    } else if current == "R" {
        return false
    } else {
        // print(current)
        // fflush(stdout)
        let node = mapWf[current]!
        for rule in node.rules {
            if rule.check(rating) {
                return searchWorkflow(through: mapWf, from: rule.nextWf, with: rating)
            }
        }
        return searchWorkflow(through: mapWf, from: node.defaultWf, with: rating)
    }
}

func extractRating(from s: String) -> [Character: Int] {
    let arrRt = s.dropFirst().dropLast().split(separator: ",").map { String($0).split(separator: "=") }
    var mapRt = [Character: Int]()
    for pair in arrRt {
        mapRt[Character(String(pair[0]))] = Int(pair[1])
    }
    return mapRt
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
    var ans = 0
    while let line = readLine() {
        let rating = extractRating(from: line)
        if searchWorkflow(through: mapWf, from: "in", with: rating) {
            ans += rating.values.reduce(0, +)
        }
    }
    print(ans)
}

main()
