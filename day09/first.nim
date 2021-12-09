import strutils, sequtils       

let contents = readFile("input.txt")


var lines = strutils.split(contents, "\n")
    .map(proc(x: string): seq[int] = @x.map(proc(c: char): int = parseInt($c)))

proc less_than_all(nr: int, sequence: seq[int]): bool = 
    for i in sequence:
        if i <= nr:
            return false
    return true

var sum = 0

for i in 0..<lines.len():
    for j in 0..<lines[i].len():
        var neighbors: seq[int] = @[]
        if i > 0:
            neighbors.add(lines[i - 1][j])
        if i < lines.len() - 1:
            neighbors.add(lines[i + 1][j])
        if j > 0:
            neighbors.add(lines[i][j - 1])
        if j < lines[i].len() - 1:
            neighbors.add(lines[i][j + 1])
        if less_than_all(lines[i][j], neighbors):
            sum += lines[i][j] + 1

echo sum