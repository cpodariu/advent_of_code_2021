import strutils, sequtils       

let contents = readFile("input.txt")

type Line = tuple[direction: string, number: int]

let lines = strutils
    .split(contents, "\n")
    .filter(proc(x: string):bool = len(x) > 0)
    .map(proc(x: string):seq[string] = strutils.split(x, " "))
    .map(proc(x: seq[string]):Line = (x[0], parseInt(x[1])))

type PartialRes = tuple[depth: int, position: int, aim: int]

let t: PartialRes = (depth: 0, position: 0, aim: 0)

let result = foldl(lines, 
    (depth: case b.direction:
        of "forward": a.depth + b.number * a.aim
        else: a.depth
    , position: case b.direction:
        of "forward": a.position + b.number
        else: a.position
    , aim: case b.direction:
        of "down": a.aim + b.number
        of "up": a.aim - b.number
        else: a.aim), 
    t)

echo result.depth * result.position