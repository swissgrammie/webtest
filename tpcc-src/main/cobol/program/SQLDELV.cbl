       identification division.

       program-id. sqldelv.

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
      * TPCC Delivery transaction
      *=================================================================
      *set CONSTANT WEB(1)
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
LJ    * IMPLEMENTOR clause.
LJ     SYSERR IS OUTERR. | DISPLAY goes to SYSERR
LJ    * SYSOUT IS OUTERR.
LJ     SOURCE-COMPUTER. JVM with debugging mode. | SETS DEBUGGING ON
       DATA DIVISION.
       
       
       
       WORKING-STORAGE SECTION.
       
       01  ws-program-name                   pic x(8) value 'SQLDELV '.

           EXEC SQL INCLUDE SQLCA END-EXEC

           EXEC SQL INCLUDE TPCC END-EXEC

       01  currentdate.
           03  cdyyyy                        pic 9(4).
           03  cdmm                          pic 9(2).
           03  cddd                          pic 9(2).
       01  currenttime.
           03  cthh                          pic 9(2).
           03  ctmn                          pic 9(2).
           03  ctss                          pic 9(2).

           EXEC SQL BEGIN DECLARE SECTION END-EXEC

       01  datetime                          pic x(20).
           EXEC SQL END DECLARE SECTION END-EXEC

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
           03  filler                        pic x(1).

       01  tpcc-log-rec                      pic x(80).

       01  log-rba                           pic s9(9) comp.

       01  response                          pic s9(9) comp.

       01  dist-per-ware                     pic 9(2) value 10.

       01  i                                 pic s9(9) comp.
       01  n                                 pic s9(9) comp.
       01  namecnt                           pic s9(9) comp.

       01  did                               pic 9(2).
       01  oid                               pic 9(9).

      
       copy tpctdata.

       LINKAGE SECTION.

       01 DFHCOMMAREA.

       copy cpydelv.

       PROCEDURE DIVISION.
        
       MAIN. | SECTION.
           EXEC SQL WHENEVER SQLERROR go to sqlerr END-EXEC

           move "YYYY-MM-DD HH:MM:SS" to datetime
           accept currentdate from date yyyymmdd
           accept currenttime from time
           move cdyyyy to dtyear
           move cdmm  to dtmonth
           move cddd  to dtday
           move cthh  to dthour
           move ctmn  to dtmin
           move ctss  to dtsec

           move wid to w-id
           move ocarrierid to o-carrier-id

      *    *> For each district in warehouse */
           move spaces to tpcc-log-rec
           string
               "W: " delimited size
               wid delimited size
               " CARRIER: " delimited size
               ocarrierid delimited size
gg-01 *    into TPCC-LOG-REC
gg-01      into d-log
      *    write TPCC-LOG-REC
gg-01 *    exec cics
gg-01 *        write file('DELVLOG') from(tpcc-log-rec)
gg-01 *        ridfld(log-rba) rba
gg-01 *        resp(response)
gg-01 *    end-exec
gg-01 *    if response not = dfhresp(NORMAL)
gg-01 *        perform fileError
gg-01 *    end-if
gg    *        EXEC SQL INSERT INTO
gg    *            DELVLOG (d_log)
gg    *                values (:d-log)
gg    *        END-EXEC

           perform varying d-id from 1 by 1 until d-id > DIST-PER-WARE
               move d-id to did
               EXEC SQL WHENEVER NOT FOUND go to sqlerr END-EXEC
               if tpc-trace-reqd
                   set trace-sqldelv to true
                   move x'01' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-csr-declare to true
                   move 'CSR 01' to tpc-trace-info
                   move 6 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
           EXEC JAVA
           CountTheTime ctt1 = new 
           CountTheTime("SQLDELV-SelectFromNewOrder");
           END-EXEC
               EXEC SQL
                   DECLARE c_no CURSOR FOR
                   SELECT no_o_id
                   FROM new_order
                   WHERE no_d_id = :d-id AND no_w_id = :w-id
                   ORDER BY no_o_id ASC
               END-EXEC
           EXEC JAVA
                ctt1.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqldelv to true
                   move x'01' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if tpc-trace-reqd
                   set trace-sqldelv to true
                   move x'02' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-csr-open to true
                   move 'CSR 01' to tpc-trace-info
                   move 6 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC SQL OPEN c_no END-EXEC
               if tpc-trace-reqd
                   set trace-sqldelv to true
                   move x'02' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               EXEC SQL WHENEVER NOT FOUND continue END-EXEC
               if tpc-trace-reqd
                   set trace-sqldelv to true
                   move x'03' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-csr-fetch to true
                   move 'CSR 01' to tpc-trace-info
                   move 6 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC SQL FETCH c_no INTO :no-o-id END-EXEC
               if tpc-trace-reqd
                   set trace-sqldelv to true
                   move x'03' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if SQLCODE NOT = 100

                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'04' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-sql-delete to true
                       move 'No' to tpc-trace-info
                       move 4 to tpc-trace-data-length
                      call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   EXEC JAVA
           CountTheTime ctt2 = new 
           CountTheTime("SQLDELV-DeleteFromNewOrder");
           END-EXEC
                   EXEC SQL
      *                DELETE FROM new_order WHERE CURRENT OF c_no
                       DELETE FROM new_order
                       WHERE no_w_id = :w-id
                           AND no_d_id = :d-id
                           AND no_o_id = :no-o-id
                   END-EXEC
                   EXEC JAVA
                        ctt2.close();
                   END-EXEC
                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'04' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'05' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-sql-csr-close to true
                       move 'CSR 01' to tpc-trace-info
                       move 6 to tpc-trace-data-length
                      call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   EXEC SQL CLOSE c_no END-EXEC
                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'05' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'06' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-sql-select to true
                       move 'Or' to tpc-trace-info
                       move 4 to tpc-trace-data-length
                      call 'TPCTRACE' using tpc-trace-data-block
                   end-if
           EXEC JAVA
           CountTheTime ctt3 = new 
           CountTheTime("SQLDELV-SelectFromOrders");
           END-EXEC
                   EXEC SQL
                       SELECT o_c_id
                       INTO :c-id
                       FROM orders
                       WHERE o_id = :no-o-id AND o_d_id = :d-id
                           AND o_w_id = :w-id
                   END-EXEC
           EXEC JAVA
                ctt3.close();
           END-EXEC
                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'06' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'07' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-sql-update to true
                       move 'Or' to tpc-trace-info
                       move 4 to tpc-trace-data-length
                      call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   EXEC JAVA
           CountTheTime ctt4 = new 
           CountTheTime("SQLDELV-UpdateOrders");
           END-EXEC
                   EXEC SQL
                       UPDATE orders
                       SET o_carrier_id = :o-carrier-id
                       WHERE o_id = :no-o-id AND o_d_id = :d-id
                           AND o_w_id = :w-id
                   END-EXEC
           EXEC JAVA
                ctt4.close();
           END-EXEC
                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'07' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'08' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-sql-update to true
                       move 'Ol' to tpc-trace-info
                       move 4 to tpc-trace-data-length
                      call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                           EXEC JAVA
           CountTheTime ctt5 = new 
           CountTheTime("SQLDELV-UpdateOrderLine");
           END-EXEC
                   EXEC SQL
                       UPDATE order_line
                       SET ol_delivery_d = :datetime
                       WHERE ol_o_id = :no-o-id AND ol_d_id = :d-id
                           AND ol_w_id = :w-id
                   END-EXEC
          EXEC JAVA
                ctt5.close();
           END-EXEC
                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'08' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'09' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-sql-select to true
                       move 'Ol' to tpc-trace-info
                       move 4 to tpc-trace-data-length
                      call 'TPCTRACE' using tpc-trace-data-block
                   end-if
           EXEC JAVA
           CountTheTime ctt6 = new 
           CountTheTime("SQLDELV-SelectFromOrderLine");
           END-EXEC
                   EXEC SQL
                       SELECT SUM(ol_amount)
                       INTO :ol-total
                       FROM order_line
                       WHERE ol_o_id = :no-o-id AND ol_d_id = :d-id
                           AND ol_w_id = :w-id
                   END-EXEC
          EXEC JAVA
                ctt6.close();
           END-EXEC
                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'09' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'0A' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-sql-update to true
                       move 'Cu' to tpc-trace-info
                       move 4 to tpc-trace-data-length
                      call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   EXEC JAVA
           CountTheTime ctt7 = new 
           CountTheTime("SQLDELV-UpdateCustomer");
           END-EXEC
                   EXEC SQL
                       UPDATE customer
                       SET c_balance = c_balance + :ol-total
                       WHERE c_id = :c-id AND c_d_id = :d-id
                           AND c_w_id = :w-id
                   END-EXEC
          EXEC JAVA
                ctt6.close();
           END-EXEC
                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'0A' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   exec cics syncpoint end-exec

                   move d-id to did
                   move no-o-id to oid

                   move spaces to TPCC-LOG-REC
                   string
                       "D: "           delimited by size
                       did             delimited by size
                       ", O: "         delimited by size
                       oid             delimited by size
                       ", time: "      delimited by size
                       datetime        delimited by size
gg-01 *            into TPCC-LOG-REC
gg-01              into d-log
      *            write TPCC-LOG-REC
gg-01 *            exec cics
gg-01 *                write file('DELVLOG') from(tpcc-log-rec)
gg-01 *                ridfld(log-rba) rba
gg-01 *                resp(response)
gg-01 *            end-exec
gg-01 *            if response not = dfhresp(NORMAL)
gg-01 *                perform fileError
gg-01 *            end-if
gg-01 *            EXEC SQL INSERT INTO
gg-01 *                DELVLOG (d_log)
gg-01 *                    values (:d-log)
gg-01 *            END-EXEC

               else
                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'0B' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-sql-csr-close to true
                       move 'CSR 01' to tpc-trace-info
                       move 6 to tpc-trace-data-length
                      call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   EXEC SQL CLOSE c_no END-EXEC
                   if tpc-trace-reqd
                       set trace-sqldelv to true
                       move x'0B' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   move spaces to TPCC-LOG-REC
                   string
                       "D: "           delimited by size
                       did             delimited by size
                       " no delivery"  delimited by size
gg-01 *            into TPCC-LOG-REC
                   into d-log
      *            write TPCC-LOG-REC
gg-01 *            exec cics
gg-01 *                write file('DELVLOG') from(tpcc-log-rec)
gg-01 *                ridfld(log-rba) rba
gg-01 *                resp(response)
gg-01 *            end-exec
gg-01 *            if response not = dfhresp(NORMAL)
gg-01 *                perform fileError
gg-01 *            end-if
gg-01 *            EXEC SQL INSERT INTO
gg-01 *                DELVLOG (d_log)
gg-01 *                    values (:d-log)
gg-01 *            END-EXEC

                   move 1 to return-code

               end-if

           end-perform

           EXEC CICS SYNCPOINT END-EXEC

           move "Delivery processing compete" to msg

           exec cics return end-exec.

      *=================================================================

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

       fileError section.
       fileError-para.
           exec cics syncpoint rollback end-exec
           move 'Log file I/O Error'
                                       to err
           exec cics return end-exec.

