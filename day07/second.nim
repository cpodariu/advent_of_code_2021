import strutils, sequtils       

let contents = readFile("input.txt")

var positions = strutils.split(contents, ",").map(proc(x: string):int = parseInt(x))

let sum = sequtils.foldl(positions, a + b, 0)

let destination = (sum / positions.len()).toInt() - 1

let diffs = sequtils.map(positions, proc(x: int):int = (abs(x - destination) * (abs(x - destination) + 1) / 2).toInt()) 

let total_fuel = sequtils.foldl(diffs, a + b, 0)

echo total_fuel