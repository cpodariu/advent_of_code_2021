import strutils, sequtils       
import std/math
import std/algorithm

let contents = readFile("input.txt")

let lines = strutils
    .split(contents, "\n")
    .filter(proc(x: string):bool = len(x) > 0)

let numbers: seq[int] = strutils
    .split(lines[0], ",")
    .map(proc(x: string):int = parseInt(x))


var others = lines[1..^1]
    .map(proc(x: string):seq[int] = strutils.split(x, " ")
        .filter(proc(x: string):bool = len(x) > 0)
        .map(proc(x: string):int = parseInt(x)))


type Board = seq[seq[int]]

var boards: seq[Board] = @[]

while others.len() > 0 :
    let board = others[0..4]
    others = others[5..^1]
    boards.add(board)

proc isBingo(board: Board):bool =
    var res = false
    for i in 0..(board[0].len() - 1):
        var hasUnmarked = false
        for j in 0..(board[0].len() - 1):
            if board[i][j] != -1:
                hasUnmarked = true
        if not hasUnmarked:
            res = true
    for i in 0..(board[0].len() - 1):
        var hasUnmarked = false
        for j in 0..(board[0].len() - 1):
            if board[j][i] != -1:
                hasUnmarked = true
        if not hasUnmarked:
            res = true
    return res

proc mark(board: Board, number: int):Board =
    var newBoard: Board = @[]
    for i in 0..(board[0].len() - 1):
        var newLine: seq[int] = @[]
        for j in 0..(board[0].len() - 1):
            if board[i][j] == number:
                newLine.add(-1)
            else:
                newLine.add(board[i][j])
        newBoard.add(newLine)
    return newBoard

proc findBingo(boards: var seq[Board], numbers: seq[int]):tuple[board: Board, number: int] =
    var lastBoard: Board = @[]
    for number in numbers:
        var markedBoards: seq[Board] = @[]
        for board in boards:
            let marked = mark(board, number)
            if not isBingo(marked):
                markedBoards.add(marked)
            else:
                if boards.len() == 1:
                    lastBoard = marked
        boards = markedBoards
        if boards.len() == 0:
            return (lastBoard, number)
    return (@[], 0)

let result = findBingo(boards, numbers)

echo result

var sum = 0
for i in result.board:
    for j in i:
        if (j != -1):
            sum += j

echo sum * result.number