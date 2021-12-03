import strutils, sequtils

let contents = readFile("input.txt")

let lines = strutils
    .split(contents, "\n")
    .filter(proc(x: string):bool = len(x) > 0)
    .map(proc(x: string):seq[int] = sequtils.toSeq(x).map(proc(x: char):int = int(x) - 48))

var counts: seq[int] = @[]
for i in 1..lines[0].len:
    counts.add(0)

for line in lines:
    for i in 0..(line.len - 1):
        counts[i] = counts[i] + line[i]

proc most_common_for_pos(lines: seq[seq[int]], pos: int):int =
    var count = 0
    for line in lines:
        count += line[pos]
    if count.float >= len(lines) / 2:
        return 1
    else:
        return 0

proc least_common_for_pos(lines: seq[seq[int]], pos: int):int =
    var count = 0
    for line in lines:
        count += line[pos]
    if count.float >= len(lines) / 2:
        return 0
    else:
        return 1

proc get_oxygen(lines: seq[seq[int]]):seq[int] =
    var solutions = lines
    for i in 0..(lines[0].len - 1):
        solutions = solutions.filter(proc(x: seq[int]):bool = x[i] == most_common_for_pos(solutions, i))
        if solutions.len == 1:
            return solutions[0]

proc get_co2(lines: seq[seq[int]]):seq[int] =
    var solutions = lines
    for i in 0..(lines[0].len - 1):
        solutions = solutions.filter(proc(x: seq[int]):bool = x[i] == least_common_for_pos(solutions, i))
        if solutions.len == 1:
            return solutions[0]

let oxygen_binary = get_oxygen(lines)
let co2_binary = get_co2(lines)

var oxygen = 0
var co2 = 0
for i in 0..(oxygen_binary.len - 1):
    oxygen = oxygen * 2 + oxygen_binary[i]
    co2 = co2 * 2 + co2_binary[i]

echo oxygen * co2