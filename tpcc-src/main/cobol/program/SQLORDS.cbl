000100  identification division.

       program-id. sqlords.

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
      * TPCC Order Status transaction
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
       01  ws-program-name                   pic x(8) value 'SQLORDS '.

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

       01  i                                 PIC S9(9) comp.
       01  n                                 PIC S9(9) comp.

           EXEC SQL BEGIN DECLARE SECTION END-EXEC

       01  namecnt                           PIC S9(9) comp.

       01  ind                               PIC S9(4) comp.

       01  entdate                           pic x(20).
       01  ol-delivery-d                     pic x(20).
           EXEC SQL END DECLARE SECTION END-EXEC

      
       copy tpctdata.

       LINKAGE SECTION.

       01 DFHCOMMAREA.

       copy cpyords.

       PROCEDURE DIVISION.
       MAIN.
           EXEC SQL WHENEVER NOT FOUND go to sqlerr END-EXEC
           EXEC SQL WHENEVER SQLERROR go to sqlerr END-EXEC

           move "YYYY-MM-DD HH:MM:SS" to datetime
           move cid to c-id
           move wid to w-id
           move did to d-id
           move clast to c-last

           if c-last not = spaces
               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'01' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-select to true
                   move 'Cu' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
                   EXEC JAVA
           CountTheTime ctt1 = new 
           CountTheTime("SQLORDS-SelectFromCustomerDistinct");
           END-EXEC
               EXEC SQL
                   SELECT count(distinct c_id)
                   INTO :namecnt
                   FROM customer
                   WHERE c_last=:c-last AND c_d_id=:d-id
                       AND c_w_id=:w-id
               END-EXEC
           EXEC JAVA
                ctt1.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'01' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if namecnt = 0
                   perform cust-not-found
               end-if

               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'02' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-csr-declare to true
                   move 'CSR 01' to tpc-trace-info
                   move 6 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
                       EXEC JAVA
           CountTheTime ctt2 = new 
           CountTheTime("SQLORDS-SelectFromCustomerOrderBy");
           END-EXEC
               EXEC SQL
                   DECLARE c_name CURSOR FOR
                   SELECT c_balance, c_first, c_middle, c_id
                   FROM customer
                   WHERE c_last=:c-last AND c_d_id=:d-id
                       AND c_w_id=:w-id
                   ORDER BY c_first
               END-EXEC
          EXEC JAVA
          ctt2.close();
          END-EXEC
               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'02' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'03' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-csr-open to true
                   move 'CSR 01' to tpc-trace-info
                   move 6 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC SQL OPEN c_name END-EXEC
               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'03' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

      *        *> Locate midpoint customer
               if function mod(namecnt,2) not = 0
                   add 1 to namecnt
               end-if

               perform varying n from 0 by 1 until n >= namecnt /2
                   if tpc-trace-reqd
                       set trace-sqlords to true
                       move x'04' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-sql-csr-fetch to true
                       move 'CSR 01' to tpc-trace-info
                       move 6 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   EXEC SQL
                       FETCH c_name
                       INTO :c-balance, :c-first, :c-middle, :c-id
                   END-EXEC
                   if tpc-trace-reqd
                       set trace-sqlords to true
                       move x'04' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
               end-perform

               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'05' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-csr-close to true
                   move 'CSR 01' to tpc-trace-info
                   move 6 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC SQL CLOSE c_name END-EXEC
               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'05' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
           else
               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'06' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-select to true
                   move 'Cu' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
                       EXEC JAVA
           CountTheTime ctt3 = new 
           CountTheTime("SQLORDS-SelectFromCustomer");
           END-EXEC
               EXEC SQL
                   SELECT c_balance, c_first, c_middle, c_last
                   INTO :c-balance, :c-first, :c-middle, :c-last
                   FROM customer
                   WHERE c_id=:c-id AND c_d_id=:d-id AND c_w_id=:w-id
               END-EXEC
           EXEC JAVA
                ctt3.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'06' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
           end-if

           move c-balance to cbalance
           move c-first to cfirst
           move c-middle to cmiddle
           move c-last to clast
           move c-id to cid

           if tpc-trace-reqd
               set trace-sqlords to true
               move x'07' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-select to true
               move 'Or' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
                   EXEC JAVA
           CountTheTime ctt4 = new 
           CountTheTime("SQLORDS-SelectFromOrders");
           END-EXEC
           EXEC SQL
               SELECT o1.o_id, o1.o_carrier_id, o1.o_entry_d
               INTO :o-id, :o-carrier-id:ind, :entdate
               FROM orders o1
               WHERE o1.o_w_id = :w-id AND o1.o_d_id = :d-id
                       AND o1.o_c_id = :c-id
                       AND NOT EXISTS (
                           SELECT o2.o_id
                           FROM orders o2
                           WHERE o2.o_w_id = :w-id AND o2.o_d_id = :d-id
                                   AND o2.o_c_id = :c-id
                                   AND o2.o_id > o1.o_id
                        )
           END-EXEC
           EXEC JAVA
           ctt4.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlords to true
               move x'07' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if ind < 0
               move 0 to o-carrier-id
           end-if
           move o-id to oid
           move o-carrier-id to ocarrierid
           string
               entdate(9:2) delimited size
               "-" delimited size
               entdate(6:2) delimited size
               "-" delimited size
               entdate(1:4) delimited size
               " " delimited size
               entdate(12:2) delimited size
               ":" delimited size
               entdate(15:2) delimited size
               ":" delimited size
               entdate(18:2) delimited size
           into oentryd

           if tpc-trace-reqd
               set trace-sqlords to true
               move x'08' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-csr-declare to true
               move 'CSR 02' to tpc-trace-info
               move 6 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
                   EXEC JAVA
           CountTheTime ctt5 = new 
           CountTheTime("SQLORDS-SelectFromOrderLine");
           END-EXEC
           EXEC SQL
               DECLARE c_line CURSOR FOR
               SELECT ol_i_id, ol_supply_w_id, ol_quantity,
                   ol_amount, ol_delivery_d
               FROM order_line
               WHERE ol_o_id=:o-id AND ol_d_id=:d-id AND ol_w_id=:w-id
           END-EXEC
           EXEC JAVA
           ctt5.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlords to true
               move x'08' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if tpc-trace-reqd
               set trace-sqlords to true
               move x'09' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-csr-open to true
               move 'CSR 02' to tpc-trace-info
               move 6 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC SQL OPEN c_line END-EXEC
           if tpc-trace-reqd
               set trace-sqlords to true
               move x'09' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           EXEC SQL WHENEVER NOT FOUND CONTINUE END-EXEC

           move 0 to i
           perform until sqlcode = 100
               add 1 to i
               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'0A' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-csr-fetch to true
                   move 'CSR 02' to tpc-trace-info
                   move 6 to tpc-trace-data-length
                  call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC SQL
                   FETCH c_line
                   INTO :ol-i-id, :ol-supply-w-id,
                       :ol-quantity, :ol-amount, :ol-delivery-d:ind
               END-EXEC
               if tpc-trace-reqd
                   set trace-sqlords to true
                   move x'0A' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               if sqlcode not = 100
                   move ol-i-id to itemid(i)
      *            move sqlcode to itemid(i)
                   move ol-supply-w-id to supware(i)
                   move ol-quantity to qty(i)
                   move ol-amount to amt(i)
                   if ind = 0
                       string
                           ol-delivery-d(9:2) delimited size
                           "-" delimited size
                           ol-delivery-d(6:2) delimited size
                           "-" delimited size
                           ol-delivery-d(1:4) delimited size
                       into deldate(i)
                   else
                       move spaces to deldate(i)
                   end-if
               end-if
           end-perform

           if tpc-trace-reqd
               set trace-sqlords to true
               move x'0B' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-csr-close to true
               move 'CSR 02' to tpc-trace-info
               move 6 to tpc-trace-data-length
              call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC SQL CLOSE c_line END-EXEC
           if tpc-trace-reqd
               set trace-sqlords to true
               move x'0B' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           EXEC CICS SYNCPOINT END-EXEC
           move 0 to result-code
           exec cics return end-exec.

       cust-not-found.
           EXEC CICS SYNCPOINT ROLLBACK END-EXEC
           move "Customer name is not valid" to err
           move 1 to result-code
           exec cics return end-exec.

       SQLErr.
           move sqlcode to csqlcode
      *    move i to csqlcode
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
      ***  $Workfile:   sqlords.cbl  $ end
      ***--------------------------------------------------------------*
