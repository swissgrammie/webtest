       IDENTIFICATION DIVISION.
       PROGRAM-ID. ONLDEMO.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01    WS-START-CD  PIC X(02).
       01    WS-RESP      PIC S9(08) COMP.
       01    WS-ABSTIME   PIC S9(15).
       01    WS-COMM      PIC X(4).
             COPY ONLDEMO.
             COPY DFHBMSCA.
             COPY DFHAID.
             EXEC SQL
                 INCLUDE SQLCA
             END-EXEC.
             EXEC SQL
                INCLUDE DCLGENF
             END-EXEC.

       LINKAGE SECTION.
       01    DFHCOMMAREA    PIC X(4).
       PROCEDURE DIVISION.
       MAIN-PARA.
           move dfhcommarea(1:eibcalen) to WS-COMM.
           MOVE LOW-VALUES TO SHOWEMI.
           IF EIBCALEN = 0
              MOVE '2' TO WS-COMM
              PERFORM SEND-INITIAL-MAP THRU SEND-INITIAL-MAP-EXIT
              PERFORM RETURN-PARA THRU RETURN-EXIT
           ELSE
              PERFORM RECEIVE-PARA THRU RECEIVE-PARA-EXIT
              PERFORM KEY-PARA THRU KEY-PARA-EXIT
              PERFORM RETURN-PARA THRU RETURN-EXIT
           END-IF.

       SEND-INITIAL-MAP.
           EXEC CICS ASKTIME
                ABSTIME (WS-ABSTIME)
           END-EXEC.

           EXEC CICS FORMATTIME
                ABSTIME(WS-ABSTIME)
                MMDDYYYY(DATEO)
                DATESEP('/')
                TIME  (TIMEO)
                TIMESEP (':')
           END-EXEC.
           
           EXEC CICS SEND
              MAP('SHOWEM')
              MAPSET('ONLDEMO')
              FREEKB
              ERASE
           END-EXEC.
       SEND-INITIAL-MAP-EXIT.
           EXIT.

       SEND-MAP.
           EXEC CICS ASKTIME
                ABSTIME (WS-ABSTIME)
           END-EXEC.

           EXEC CICS FORMATTIME
                ABSTIME(WS-ABSTIME)
                MMDDYYYY(DATEO)
                DATESEP('/')
                TIME  (TIMEO)
                TIMESEP (':')
           END-EXEC.

           EXEC CICS SEND
              MAP('SHOWEM')
              MAPSET('ONLDEMO')
              FROM(SHOWEMO)
              FREEKB
              DATAONLY
           END-EXEC.
       SEND-MAP-EXIT.
           EXIT.

       RETURN-PARA.
           EXEC CICS RETURN
               TRANSID('ONLD')
               COMMAREA(WS-COMM)
           END-EXEC.
       RETURN-EXIT.
           EXIT.

       RECEIVE-PARA.
           MOVE LOW-VALUES TO SHOWEMI.
           EXEC CICS RECEIVE
               MAP('SHOWEM')
               MAPSET('ONLDEMO')
               RESP (WS-RESP)
           END-EXEC.
       RECEIVE-PARA-EXIT.
           EXIT
           .
       KEY-PARA.
           EVALUATE EIBAID
              WHEN DFHCLEAR
                 MOVE SPACES  TO CNUMO
                                 NAMEO
                                 INVAMTO
                 MOVE 'PRESS ACTION KEY PF5 OR PF3' TO MESSO
                 PERFORM SEND-INITIAL-MAP THRU SEND-INITIAL-MAP-EXIT
              WHEN DFHENTER
                 PERFORM SELECT-PARA THRU SELECT-PARA-EXIT
                 PERFORM SEND-MAP THRU SEND-MAP-EXIT
              WHEN DFHPF5
                PERFORM UPDATE-PARA THRU UPDATE-PARA-EXIT
                PERFORM SEND-MAP THRU SEND-MAP-EXIT
              WHEN OTHER
                 MOVE 'PRESS ACTION KEY PF5 OR PF3' TO MESSO
                 PERFORM SEND-MAP THRU SEND-MAP-EXIT
           END-EVALUATE.
       KEY-PARA-EXIT.
           EXIT.

       SELECT-PARA.
           MOVE CNUMI TO CUST-NUM.

           EXEC SQL
              SELECT CUSTNO
                    ,CUST_NAME
                    ,CUST_INVOICE_AMT
                INTO :CUST-NUM
                    ,:CUST-NAME
                    ,:CUST-INVOICE-AMT
                FROM CUSTTAX
               WHERE CUSTNO =:CUST-NUM
           END-EXEC.
           IF SQLCODE = 0
              MOVE ' SELECT SUCCESSFUL' TO MESSO
              MOVE CUST-NUM TO CNUMO
              MOVE CUST-NAME TO NAMEO
              MOVE CUST-INVOICE-AMT TO INVAMTO
           ELSE
              MOVE SQLERRMC TO MESSO
              DISPLAY SQLCODE UPON SYSOUT
              DISPLAY SQLERRMC UPON SYSOUT
           END-IF.

       SELECT-PARA-EXIT.
           EXIT.

        UPDATE-PARA.
           MOVE CNUMI TO CUST-NUM.
           MOVE INVAMTI TO CUST-INVOICE-AMT.

           EXEC SQL
              UPDATE CUSTTAX
                  SET CUST_INVOICE_AMT = :CUST-INVOICE-AMT
                WHERE CUSTNO =:CUST-NUM
           END-EXEC.
           IF SQLCODE = 0
              MOVE ' UPDATE SUCCESSFUL' TO MESSO
           ELSE
              MOVE SQLERRMC TO MESSO
              DISPLAY SQLCODE UPON SYSOUT
              DISPLAY SQLERRMC UPON SYSOUT
           END-IF.

       UPDATE-PARA-EXIT.
           EXIT.

       EXIT-PARA.
           EXEC CICS RETURN
           END-EXEC.