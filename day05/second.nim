import strutils, sequtils       
import std/math
import std/algorithm

let contents = readFile("input.txt")

let lines = strutils
    .split(contents, "\n")
    .filter(proc(x: string):bool = len(x) > 0)
    .map(proc(x: string):seq[seq[int]] = strutils.split(x, " -> ")
        .map(proc(y: string):seq[int] = strutils.split(y, ",")
            .map(proc(x: string):int = parseInt(x))))

var diagram: seq[seq[int]] = @[]
for i in 0..1000:
    var line: seq[int] = @[]
    for j in 0..1000:
        line.add(0)
    diagram.add(line)


var count = 0

for line in lines:
    if line[0][0] == line[1][0] or line[0][1] == line[1][1]:
        for i in min(line[0][0], line[1][0])..max(line[0][0], line[1][0]):
            for j in min(line[0][1], line[1][1])..max(line[0][1], line[1][1]):
                diagram[i][j] += 1
                if diagram[i][j] == 2:
                    count += 1
    if abs(line[0][0] - line[1][0]) == abs(line[0][1] - line[1][1]):
        echo line
        var i = line[0][0]
        var j = line[0][1]
        var istep = if line[0][0] > line[1][0]: -1 else: 1
        var jstep = if line[0][1] > line[1][1]: -1 else: 1
        while i != line[1][0] + istep:
            diagram[i][j] += 1
            if diagram[i][j] == 2:
                count += 1
            i+=istep
            j+=jstep

echo count