import strutils, sequtils       

let contents = readFile("input.txt")

type Line = tuple[direction: string, number: int]

let lines = strutils
    .split(contents, "\n")
    .filter(proc(x: string):bool = len(x) > 0)
    .map(proc(x: string):seq[string] = strutils.split(x, " "))
    .map(proc(x: seq[string]):Line = (x[0], parseInt(x[1])))

type PartialRes = tuple[depth: int, position: int]

let t: PartialRes = (depth: 0, position: 0)

let result = foldl(lines, 
    (depth: case b.direction:
        of "down": a.depth + b.number
        of "up": a.depth - b.number
        else: a.depth
    , position: case b.direction:
        of "forward": a.position + b.number
        else: a.position), 
    t)

echo result.depth * result.position