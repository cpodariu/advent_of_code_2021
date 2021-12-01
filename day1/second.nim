import strutils, sequtils       

let contents = readFile("input.txt")

let lines = strutils
    .split(contents, "\n")
    .filter(proc(x: string):bool = len(x) > 0)
    .map(proc(x: string):int = parseInt(x))

type PartialRes = tuple[count: int, first: int, second: int, third: int]

let t: PartialRes = (count: 0, first: lines[0], second: lines[1], third: lines[2])

let result = foldl(lines[3..^1], 
    (count: if a.first < b: a.count + 1 else: a.count, first: a.second, second: a.third, third: b), 
    t)

echo result