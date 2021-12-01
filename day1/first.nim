import strutils, sequtils       

let contents = readFile("input.txt")

let lines = strutils
    .split(contents, "\n")
    .filter(proc(x: string):bool = len(x) > 0)
    .map(proc(x: string):int = parseInt(x))

type PartialRes = tuple[count: int, last: int]

let t: PartialRes = (count: 0, last: lines[0])

let result = foldl(lines[1..^1], 
    (count: if a.last < b: a.count + 1 else: a.count, last: b), 
    t)

echo result