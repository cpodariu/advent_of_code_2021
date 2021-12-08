import strutils, sequtils       

let contents = readFile("input.txt")

var entries = strutils.split(contents, "\n")
    .map(proc(x: string): seq[seq[string]] = strutils.split(x, " | ")
        .map(proc (y: string): seq[string] = strutils.split(y, " ")))


var sum = 0

for entry in entries:
    let one = entry[0].filter(proc(x: string): bool = x.len() == 2)[0]
    let four = entry[0].filter(proc(x: string): bool = x.len() == 4)[0]
    let seven = entry[0].filter(proc(x: string): bool = x.len() == 3)[0]
    let eight = entry[0].filter(proc(x: string): bool = x.len() == 7)[0]

    var top_segment: char = '\0'
    for c in seven:
        if not strutils.contains(one, $c):
            top_segment = c

    var three: string

    for e in entry[0]:
        if e.len() == 5 and strutils.contains(e, $one[0]) and strutils.contains(e, $one[1]):
            three = e

    var bottom_segment: char

    for c in three:
        if not strutils.contains(four, $c) and c != top_segment:
            bottom_segment = c
    
    var middle_segment: char

    for c in three:
        if c != top_segment and c != bottom_segment and c != one[0] and c != one[1]:
            middle_segment = c

    var top_left_segment: char

    for c in four:
        if c != middle_segment and c != one[0] and c != one[1]:
            top_left_segment = c

    var five: string

    for e in entry[0]:
        if e.len() == 5 and strutils.contains(e, $middle_segment) and strutils.contains(e, $top_segment) and strutils.contains(e, $bottom_segment) and strutils.contains(e, $top_left_segment):
            five = e

    var bottom_right_segment: char

    for c in five:
        if c != top_segment and c != bottom_segment and c != middle_segment and c != top_left_segment:
            bottom_right_segment = c

    let top_right_segment: char = if one[0] == bottom_right_segment: one[1] else: one[0]

    var bottom_left_segment: char

    for c in eight:
        if c != top_segment and c != bottom_segment and c != middle_segment and c != top_left_segment and c != top_right_segment and c != bottom_right_segment:
            bottom_left_segment = c

    var number = 0
    for digit in entry[1]:
        if digit.len() == 2:
            number = number * 10 + 1
        elif digit.len() == 4:
            number = number * 10 + 4
        elif digit.len() == 3:
            number = number * 10 + 7
        elif digit.len() == 7:
            number = number * 10 + 8
        elif digit.len() == 5:
            if strutils.contains(digit, $top_left_segment):
                number = number * 10 + 5
            elif strutils.contains(digit, $bottom_left_segment):
                number = number * 10 + 2
            else:
                number = number * 10 + 3
        elif digit.len() == 6:
            if strutils.contains(digit, $middle_segment):
                if strutils.contains(digit, $top_right_segment):
                    number = number * 10 + 9
                else:
                    number = number * 10 + 6
            else: number = number * 10    
    sum += number

echo sum
