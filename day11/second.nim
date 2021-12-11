import strutils, sequtils       

let contents = readFile("input.txt")


var lines = strutils.split(contents, "\n")
    .map(proc(x: string): seq[int] = @x.map(proc(c: char): int = parseInt($c)))

var flashes = 0

proc increase(map: var seq[seq[int]], x: int, y: int): int =
    if x < 0 or x > map.len() - 1:
        return 0
    if y < 0 or y > map[x].len() - 1:
        return 0
    var flashes = 0
    if map[x][y] < 10:
        map[x][y] = map[x][y] + 1
        if map[x][y] == 10:
            flashes += 1
            flashes += increase(map, x, y + 1)
            flashes += increase(map, x, y - 1)
            flashes += increase(map, x + 1, y)
            flashes += increase(map, x + 1, y + 1)
            flashes += increase(map, x + 1, y - 1)
            flashes += increase(map, x - 1, y)
            flashes += increase(map, x - 1, y + 1)
            flashes += increase(map, x - 1, y - 1)
    return flashes


var sum = 0
for step in 1..1000:
    for i in 0..<lines.len():
        for j in 0..<lines[0].len():
            sum += increase(lines, i, j)
    var flashes = 0
    for i in 0..<lines.len():
        for j in 0..<lines[0].len():
            if lines[i][j] == 10:
                flashes += 1
                lines[i][j] = 0
    if flashes == 100:
        echo step
    
            