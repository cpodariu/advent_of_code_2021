import strutils, sequtils       

let contents = readFile("input.txt")

var lines = strutils.split(contents, "\n")
    .map(proc(x: string): seq[seq[string]] = strutils.split(x, " | ")
        .map(proc (y: string): seq[string] = strutils.split(y, " ")))

let counts = lines.map(proc(x: seq[seq[string]]): int = x[1].filter(proc(y:string): bool = y.len() == 2 or y.len() == 4 or y.len() == 3 or y.len() == 7).len())

let sum = sequtils.foldl(counts, a + b, 0)

echo sum