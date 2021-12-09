import strutils, sequtils       
import std/algorithm

type Position = tuple[x: int, y: int]

type Element = tuple[pos: Position, value: int]

let contents = readFile("input.txt")


var lines = strutils.split(contents, "\n")
    .map(proc(x: string): seq[int] = @x.map(proc(c: char): int = parseInt($c)))

proc less_than_all(nr: int, sequence: seq[Element]): bool = 
    for i in sequence:
        if i.value <= nr:
            return false
    return true

proc get_neighbors(position: Position, lines: seq[seq[int]]): seq[Element] =
    var neighbors: seq[Element] = @[]
    if position.x > 0:
        neighbors.add((pos: (x: position.x - 1, y: position.y), value: lines[position.x - 1][position.y]))
    if position.x < lines.len() - 1:
        neighbors.add((pos: (x: position.x + 1, y: position.y), value: lines[position.x + 1][position.y]))
    if position.y > 0:
        neighbors.add((pos: (x: position.x, y: position.y - 1), value: lines[position.x][position.y - 1]))
    if position.y < lines[0].len() - 1:
        neighbors.add((pos: (x: position.x, y: position.y + 1), value: lines[position.x][position.y + 1]))
    return neighbors

proc get_chasm_size(map: var seq[seq[int]], start: Position): int =
    var queue = @[start]
    var i = 0;
    while i < queue.len():
        let neighbors = get_neighbors(queue[i], map)
        for n in neighbors:
            if n.value < 9 and not queue.contains(n.pos):
                queue.add(n.pos)
        i += 1
    return queue.len()


var sizes: seq[int] = @[]

for i in 0..<lines.len():
    for j in 0..<lines[i].len():
        var neighbors = get_neighbors((x: i, y: j), lines)
        if less_than_all(lines[i][j], neighbors):
            sizes.add(get_chasm_size(lines, (x: i, y: j)))

sizes.sort()

echo foldl(sizes[sizes.len() - 3..sizes.len() - 1], a * b, 1)