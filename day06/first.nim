import strutils, sequtils       

let contents = readFile("input.txt")

var fish = strutils.split(contents, ",").map(proc(x: string):int = parseInt(x))

for day in 1..256:
    echo day
    let count = fish.len
    for i in 0..<count:
        if fish[i] == 0:
            fish.add(8)
            fish[i] = 6
        else:
            fish[i] = fish[i] - 1
    
echo fish.len()