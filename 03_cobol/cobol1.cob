      * AoC Day03 Part1
       IDENTIFICATION DIVISION.
       PROGRAM-ID. cobol1.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 STRING-ARRAY.
           05 STRING-ELEMENT OCCURS 140 TIMES PIC X(140).
       01 BOOLEAN-2D-ARRAY.
           05 BOOLEAN-ARRAY OCCURS 140 TIMES.
               10 BOOLEAN-ELEMENT OCCURS 140 TIMES PIC 9(1) VALUE 0.
       01 I PIC 9(3).
       01 J PIC 9(3).
       01 K PIC 9(3).
       01 DI PIC 9(3).
       01 DJ PIC 9(3).
       01 NI PIC 9(3).
       01 NJ PIC 9(3).
       01 C PIC X(1).
       01 ANS PIC 9(7).
       01 NUM PIC 9(7).
       01 OK PIC 9(1).

       PROCEDURE DIVISION.
           MOVE 0 TO ANS.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 140
               ACCEPT STRING-ELEMENT(I)
           END-PERFORM.

           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 140
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > 140
                   MOVE STRING-ELEMENT(I)(J:1) TO C
                   IF C NOT NUMERIC AND C NOT EQUAL '.'
                       PERFORM VARYING DI FROM 1 BY 1 UNTIL DI > 3
                           MOVE I TO NI
                           ADD DI TO NI
      *                    This "CONTINUE" actually does nothing.
      *                    Since there are no symbols in I = 1 or I =
      *                    140 in the input file, it works without
      *                    out-of-bound references.
                           IF NI <= 2 OR NI > 142
                               CONTINUE
                           END-IF
                           SUBTRACT 2 FROM NI
                           PERFORM VARYING DJ FROM 1 BY 1 UNTIL DJ > 3
                               MOVE J TO NJ
                               ADD DJ TO NJ
                               IF NJ <= 2 OR NJ > 142
                                   CONTINUE
                               END-IF
                               SUBTRACT 2 FROM NJ
                               MOVE 1 TO BOOLEAN-ELEMENT(NI NJ)
                           END-PERFORM
                       END-PERFORM
                   END-IF
               END-PERFORM
           END-PERFORM.

           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 140
               MOVE 1 TO J
               PERFORM UNTIL J > 140
                   IF STRING-ELEMENT(I)(J:1) NOT NUMERIC
                       ADD 1 TO J
                   ELSE
                       MOVE J TO NJ
                       PERFORM UNTIL NJ > 140
                           IF STRING-ELEMENT(I)(NJ:1) NOT NUMERIC
                               EXIT PERFORM
                           END-IF
                           ADD 1 TO NJ
                       END-PERFORM
                       MOVE 0 TO OK
                       MOVE 0 TO NUM
                       PERFORM VARYING K FROM J BY 1 UNTIL K >= NJ
                           MULTIPLY 10 BY NUM
                           ADD FUNCTION NUMVAL(STRING-ELEMENT(I)(K:1))
                               TO NUM
                           IF BOOLEAN-ELEMENT(I K) = 1
                               MOVE 1 TO OK
                           END-IF
                       END-PERFORM
                       IF OK = 1
                           ADD NUM TO ANS
                       END-IF
                       MOVE NJ TO J
                   END-IF
               END-PERFORM
           END-PERFORM.
           DISPLAY ANS.
           STOP RUN.
