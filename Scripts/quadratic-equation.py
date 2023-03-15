#!/bin/python3
import sys
import math

def init():
    args="".join(sys.argv[1:])
    extractParameters(args)

def extractParameters(equation):
    [a, equation] = calculateParameter(equation, "x^")
    [b, equation] = calculateParameter(equation, "x")
    [c, equation] = calculateParameter(equation, "")
    
    try:
        [x1,x2]=solveEquation(a,b,c)
        print(x1,x2)
    except ValueError:
        pass
    # extract "a"

def solveEquation(a,b,c):
    try:
        delta = math.sqrt(math.pow(b,2)-4*a*c)
    except ValueError:
        return []
    return [ (-b +delta)/(2*a), (-b-delta)/(2*a) ]

def calculateParameter(equation, str):
    value = 0
    while (True):
        try:
            [temp, equation] = extractFirstParameter(equation, str)
            value+= temp
        except ValueError:
            break;
    return [value, equation]

def extractFirstParameter(mainStr, subStr):
    indexOfSubStr = mainStr.index(subStr) 
    if mainStr == "" : raise ValueError("main string is empty")

    if subStr == "": indexOfSubStr = len(mainStr)
    outputStr = ""
    forRanNTimes = 0 
    for index in range(indexOfSubStr-1, -1, -1):
        forRanNTimes+=1
        outputStr = mainStr[index] + outputStr
        if (mainStr[index] in ["+","-"]): break
    startIndex = indexOfSubStr-forRanNTimes
    
    endIndex = -1
    for index in range(startIndex+1, len(mainStr)):
        if mainStr[index] in ["-","+"]:
            endIndex = index
            break
    if endIndex == -1: endIndex = len(mainStr)

    if outputStr in ["", "+"]: outputStr = 1
    if outputStr == "-": outputStr = -1
    return [int(outputStr), mainStr[:startIndex]+mainStr[endIndex:]]
    


init()
