import strutils, sequtils       
import std/math
import std/algorithm

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

var gamma_binary: seq[int] = @[]
var epsilon_binary: seq[int] = @[]
for c in counts:
    if c > 500:
        gamma_binary.add(1)
        epsilon_binary.add(0)
    else:
        gamma_binary.add(0)
        epsilon_binary.add(1)

echo gamma_binary
echo epsilon_binary

var gamma = 0
var epsilon = 0
for i in 0..(gamma_binary.len - 1):
    gamma = gamma * 2 + gamma_binary[i]
    epsilon = epsilon * 2 + epsilon_binary[i]

echo gamma * epsilon