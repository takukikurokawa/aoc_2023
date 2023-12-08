      * AoC Day03 Part2
       IDENTIFICATION DIVISION.
       PROGRAM-ID. cobol2.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 STRING-ARRAY.
           05 STRING-ELEMENT OCCURS 140 TIMES PIC X(140).
       01 I PIC 9(3).
       01 J PIC 9(3).
       01 C PIC X(1).
       01 ANS PIC 9(9).
       01 NUM PIC 9(9).
       01 CNT PIC 9(1).
       01 K PIC 9(3).
       01 L PIC 9(3).
       01 R PIC 9(3).
       01 NI PIC 9(3).
       01 VAL PIC 9(9).

       PROCEDURE DIVISION.
           MOVE 0 TO ANS.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 140
               ACCEPT STRING-ELEMENT(I)
           END-PERFORM.

           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 140
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > 140
                   MOVE STRING-ELEMENT(I)(J:1) TO C
                   IF C EQUAL '*'
                       PERFORM CALCULATE
                   END-IF
               END-PERFORM
           END-PERFORM.

           DISPLAY ANS.
           STOP RUN.


       CALCULATE SECTION.

       MOVE 0 TO CNT
       MOVE 1 TO NUM
       MOVE I TO NI
       IF NI > 1
           SUBTRACT 1 FROM NI
       ELSE
           MOVE 1 TO NI
       END-IF

       PERFORM UNTIL NI > 140 OR NI > I + 1
           MOVE J TO L
           IF L > 5
               SUBTRACT 5 FROM L
           ELSE
               MOVE 1 TO L
           END-IF
           PERFORM UNTIL L > 140 OR L > J + 1
               IF STRING-ELEMENT(NI)(L:1) NOT NUMERIC
                   ADD 1 TO L
               ELSE
                   MOVE L TO R
                   PERFORM UNTIL R > 140
                       IF STRING-ELEMENT(NI)(R:1) NOT NUMERIC
                           EXIT PERFORM
                       END-IF
                       ADD 1 TO R
                   END-PERFORM
                   MOVE 0 TO VAL
                   PERFORM VARYING K FROM L BY 1 UNTIL K >= R
                       MULTIPLY 10 BY VAL
                       ADD FUNCTION NUMVAL(STRING-ELEMENT(NI)(K:1))
                           TO VAL
                   END-PERFORM
                   IF L - 1 <= J AND J <= R
                       MULTIPLY NUM BY VAL GIVING NUM
                       ADD 1 TO CNT
                   END-IF
                   MOVE R TO L
               END-IF
           END-PERFORM
           ADD 1 TO NI
       END-PERFORM

       IF CNT = 2
           ADD NUM TO ANS
       END-IF
       
       EXIT SECTION.
