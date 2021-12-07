import strutils, sequtils       

let contents = readFile("input.txt")

var positions = strutils.split(contents, ",").map(proc(x: string):int = parseInt(x))

let sum = sequtils.foldl(positions, a + b, 0)

var min_total_fuel = -1

for destination in positions[sequtils.minIndex(positions)]..positions[sequtils.maxIndex(positions)]:
    let diffs = sequtils.map(positions, proc(x: int):int = abs(x - destination))
    let total_fuel = sequtils.foldl(diffs, a + b, 0)
    if (total_fuel < min_total_fuel or min_total_fuel == -1):
        min_total_fuel = total_fuel

echo min_total_fuel