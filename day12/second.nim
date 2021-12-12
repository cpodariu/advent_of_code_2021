import strutils, sequtils       
import tables

let contents = readFile("input.txt")

type 
    Node = ref NodeObj
    NodeObj = object
        val: string
        links: seq[Node]
    
        
proc is_small*(n: Node): bool = n.val[0].isLowerAscii

var lines = strutils.split(contents, "\n")

var nodes = initTable[string, Node]()

for line in lines:
    let parts = line.split("-")

    if not nodes.hasKey(parts[0]):
        nodes[parts[0]] = Node(val: parts[0], links: @[])
    if not nodes.hasKey(parts[1]):
        nodes[parts[1]] = Node(val: parts[1], links: @[])
    nodes[parts[0]].links.add(nodes[parts[1]])
    nodes[parts[1]].links.add(nodes[parts[0]])

var queue = @[nodes["start"]]

proc recurstion(q: seq[Node], small_visited = false): int =
    echo q[q.len() - 1].val

    if q[q.len() - 1].val == "end":
        return 1

    var res = 0
    for node in q[q.len() - 1].links:
        var copy = q
        if node.val == "start":
            continue
        if node in q and node.is_small():
            if not small_visited:
                copy.add(node)
                res += recurstion(copy, true)
            continue
        copy.add(node)
        res += recurstion(copy, small_visited)
    return res

echo recurstion(queue)