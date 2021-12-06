import strutils, sequtils

let contents = readFile("input.txt")

var fish = strutils.split(contents, ",").map(proc(x: string):int = parseInt(x))

var fishcount: seq[int] = @[0, 0, 0, 0, 0, 0, 0, 0, 0]

for f in fish:
    fishcount[f] = fishcount[f] + 1

for day in 1..256:
    var new_count = @[0, 0, 0, 0, 0, 0, 0, 0, 0]
    new_count[8] += fishcount[0]
    new_count[6] += fishcount[0]
    for i in 1..8:
        new_count[i - 1] += fishcount[i]
    fishcount = new_count
    
echo sequtils.foldl(fishcount, a + b, 0)