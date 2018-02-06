       identification division.

       program-id. sqlstkl.

       author.    Heirloom Computing Inc.
       
      ******************************************************************
      *        Copyright (C) 2010-2018 Heirloom Computing Inc.         *
      *                                                                *
      *                        ALL RIGHTS RESERVED                     *
      ******************************************************************
      *                                                                *
      * Property of Heirloom Computing Inc.  This software contains    *
      * confidential and proprietary information of Heirloom Computing *
      * Inc. and is made available solely pursuant to the terms of a   *
      * software license agreement, which governs its use.             *
      *                                                                *
      * No disclosure, reproduction or use of any portion of these     *
      * materials may be made without the express written consent of   *
      * Heirloom Computing Inc.                                        *
      *                                                                *
      ******************************************************************

      *=================================================================
      * TPCC Stock Level transaction
      *=================================================================
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
LJ     SOURCE-COMPUTER. JVM with debugging mode. | SETS DEBUGGING ON
       SPECIAL-NAMES.
LJ    * IMPLEMENTOR clause.
LJ     SYSERR IS OUTERR. | DISPLAY goes to SYSERR
LJ    * SYSOUT IS OUTERR.
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       
       01  ws-program-name                   pic x(8) value 'SQLSTKL '.

           EXEC SQL INCLUDE SQLCA END-EXEC

           EXEC SQL INCLUDE TPCC END-EXEC

       01  DIST-PER-WARE                     pic s9(8) comp value 10.

       01  currentdate.
           03  cdyyyy                        pic 9(4).
           03  cdmm                          pic 9(2).
           03  cddd                          pic 9(2).
       01  currenttime.
           03  cthh                          pic 9(2).
           03  ctmn                          pic 9(2).
           03  ctss                          pic 9(2).

       01  datetime                          pic x(19).
       01  filler redefines datetime.
           03  dtyear                        pic x(4).
           03  filler                        pic x(1).
           03  dtmonth                       pic x(2).
           03  filler                        pic x(1).
           03  dtday                         pic x(2).
           03  filler                        pic x(1).
           03  dthour                        pic x(2).
           03  filler                        pic x(1).
           03  dtmin                         pic x(2).
           03  filler                        pic x(1).
           03  dtsec                         pic x(2).

       01  i                                 pic s9(9) comp.
       01  n                                 pic s9(9) comp.
       01  namecnt                           pic s9(9) comp.

           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  ws-stockcount                     pic s9(9) comp.
       01  ws-threshold                      pic s9(9) comp.
           EXEC SQL END DECLARE SECTION END-EXEC
       
       copy tpctdata.
       
       
       LINKAGE SECTION.

       01 DFHCOMMAREA.
      
       copy cpystkl.

       PROCEDURE DIVISION.
       MAIN.
           EXEC SQL WHENEVER NOT FOUND go to sqlerr END-EXEC
           EXEC SQL WHENEVER SQLERROR go to sqlerr END-EXEC

           move "YYYY-MM-DD HH:MM:SS" to datetime

           move wid to w-id
           move did to d-id

           if tpc-trace-reqd
               set trace-sqlstkl to true
               move x'01' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-select to true
               move 'Di' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC JAVA
           CountTheTime ctt1 = new 
           CountTheTime("SQLPAYM-SelectFromDistrict");
           END-EXEC
           EXEC SQL
               SELECT d_next_o_id
               INTO :o-id
               FROM district
               WHERE d_w_id=:w-id AND d_id=:d-id
           END-EXEC
           EXEC JAVA
                ctt1.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlstkl to true
               move x'01' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           move threshold to ws-threshold

           if tpc-trace-reqd
               set trace-sqlstkl to true
               move x'02' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-select to true
               move 'OlSt' to tpc-trace-info
               move 6 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC JAVA
           CountTheTime ctt2 = new 
           CountTheTime("SQLSTKL-SelectFromOrderLineStock");
           END-EXEC
           EXEC SQL
               SELECT
                   COUNT(DISTINCT (s_i_id))
                   INTO :ws-stockcount
                   FROM order_line, stock
                   WHERE ol_w_id=:w-id AND
                       ol_d_id=:d-id AND ol_o_id<:o-id AND
                       ol_o_id>=:o-id - 20 AND s_w_id=:w-id AND
                       s_i_id=ol_i_id AND s_quantity < :ws-threshold
           END-EXEC
           EXEC JAVA
                ctt2.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlstkl to true
               move x'02' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           move ws-stockcount to stockcount

           EXEC CICS SYNCPOINT END-EXEC

           move 0 to result-code
           exec cics return end-exec.

       SQLErr.
           move sqlcode to csqlcode
           string
               "SQL Error: CODE=" delimited size
               csqlcode delimited size
               " STATE=" delimited size
               sqlstate delimited size
               " " delimited size
               sqlerrmc delimited size
           into err

           EXEC SQL WHENEVER SQLERROR CONTINUE END-EXEC
           EXEC CICS SYNCPOINT ROLLBACK END-EXEC

           move -1 to result-code
           exec cics return end-exec.

      ***--------------------------------------------------------------*
      ***  $Workfile:   sqlstkl.cbl  $ end
      ***--------------------------------------------------------------*
