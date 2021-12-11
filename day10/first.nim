import strutils, sequtils       

let contents = readFile("input.txt")


var lines = strutils.split(contents, "\n")

var points = 0

for line in lines:
    var stack: seq[char] = @[]
    for c in line:
        if c == '(' or c == '[' or c == '{' or c == '<':
            stack.add(c)
        else:
            var top = '\0'
            if stack.len() > 0:
                top = stack.pop()
            if c == ')' and top != '(':
                echo 3
                points += 3
                break
            if c == ']' and top != '[':
                echo 57
                points += 57
                break
            if c == '}' and top != '{':
                echo 1197
                points += 1197
                break
            if c == '>' and top != '<':
                echo 25137
                points += 25137
                break

echo points