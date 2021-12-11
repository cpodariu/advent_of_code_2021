import strutils, sequtils       
import std/algorithm

let contents = readFile("input.txt")


var lines = strutils.split(contents, "\n")

var scores: seq[int] = @[]

for line in lines:
    var stack: seq[char] = @[]
    var corupted = false
    var score = 0
    for c in line:
        if c == '(' or c == '[' or c == '{' or c == '<':
            stack.add(c)
        else:
            var top = '\0'
            if stack.len() > 0:
                top = stack.pop()
            if c == ')' and top != '(':
                corupted = true
                break
            if c == ']' and top != '[':
                corupted = true
                break
            if c == '}' and top != '{':
                corupted = true
                break
            if c == '>' and top != '<':
                corupted = true
                break
    if not corupted:
        while stack.len() > 0:
            var top = stack.pop()
            if top == '(':
                score = score * 5 + 1
            if top == '[':
                score = score * 5 + 2
            if top == '{':
                score = score * 5 + 3
            if top == '<':
                score = score * 5 + 4
        scores.add(score)

sort(scores)
echo scores[((len(scores) - 1) / 2).toInt()]