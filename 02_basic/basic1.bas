REM AoC Day2 Part1

SUB SPLIT(s AS STRING, res() AS STRING)
    DIM t AS STRING
    DIM i AS INTEGER
    DIM p AS INTEGER

    i = 0

    DO
        p = INSTR(1, s, " ")
        IF p = 0 THEN
            t = RIGHT(s, LEN(s) - IIF(i = 0, 0, p))
        ELSE
            t = LEFT(s, p - 1)
            s = RIGHT(s, LEN(s) - p)
        END IF
        t = TRIM(t)
        IF LEN(t) > 0 THEN
            res(i) = TRIM(t)
            i = i + 1
        END IF
        IF p = 0 THEN EXIT DO
    LOOP

    REDIM PRESERVE res(i - 1)
END SUB

DIM ans AS INTEGER

ans = 0

OPEN "data/in1.txt" FOR INPUT AS #1
OPEN "data/out1.txt" FOR OUTPUT AS #2

DO
    DIM s AS STRING
    DIM t(100) AS STRING
    DIM i AS INTEGER
    DIM add AS INTEGER

    LINE INPUT #1, s
    IF s = "" THEN EXIT DO

    SPLIT s, t()

    add = VAL(LEFT(t(1), LEN(t(1)) - 1))

    FOR i = 2 to 100 STEP 2
        IF t(i) = "" THEN EXIT FOR
        DIM x AS STRING
        DIM y AS INTEGER
        x = LEFT(t(i + 1), 1)
        y = VAL(t(i))
        IF x = "r" and y > 12 THEN
            add = 0
        ELSEIF x = "g" and y > 13 THEN
            add = 0
        ELSEIF x = "b" and y > 14 THEN
            add = 0
        ENDIF
    NEXT i
 
    ans = ans + add
LOOP

PRINT #2, ans
