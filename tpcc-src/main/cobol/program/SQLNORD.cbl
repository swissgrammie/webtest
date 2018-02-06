       identification division.

       program-id. sqlnord.

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
      * TPCC New Order transaction
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
       01  ws-program-name                   pic x(8) value 'SQLNORD '.

           EXEC SQL INCLUDE SQLCA END-EXEC

           EXEC SQL INCLUDE TPCC END-EXEC

           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  ws-olno                           pic s9(9) comp.
           EXEC SQL END DECLARE SECTION END-EXEC

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

       01  i                                 pic s9(9) comp.
       01  ntotal                            pic 99999V99 comp-3.
       01  ws-line-item                      pic S9(9) comp.

      
       copy tpctdata.

       LINKAGE SECTION.

       01 DFHCOMMAREA.

       copy cpynord.

       PROCEDURE DIVISION.
       MAIN.
           EXEC SQL WHENEVER NOT FOUND go to sqlerr END-EXEC
           EXEC SQL WHENEVER SQLERROR go to sqlerr END-EXEC

      *    *> Initialize timestamp (for date columns)
           move "YYYY-MM-DD HH:MM:SS" to datetime
           accept currentdate from date yyyymmdd
           accept currenttime from time
           move cdyyyy to dtyear
           move cdmm  to dtmonth
           move cddd  to dtday
           move cthh  to dthour
           move ctmn  to dtmin
           move ctss  to dtsec

  lh  *    string
  lh  *        cddd       delimited by size
  lh  *        '-'        delimited by size
  lh  *        cdmm       delimited by size
  lh  *        '-'        delimited by size
  lh  *        cdyyyy     delimited by size
  lh  *        ' '        delimited by size
  lh  *        cthh       delimited by size
  lh  *        ':'        delimited by size
  lh  *        ctmn       delimited by size
  lh  *        ':'        delimited by size
  lh  *        ctss       delimited by size
  lh  *    into oentrydt
           move datetime to oentrydt

           move cid to c-id
           move did to d-id
           move wid to w-id

           move 0 to ntotal

           if tpc-trace-reqd
               set trace-sqlnord to true
               move x'01' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-select to true
               move 'CuWh' to tpc-trace-info
               move 6 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC JAVA
           CountTheTime ctt1 = new 
           CountTheTime("SQLNORD-SelectFromCustomerWarehouse");
           END-EXEC
           EXEC SQL
               SELECT c_discount, c_last, c_credit, w_tax
               INTO :c-discount, :c-last, :c-credit, :w-tax
               FROM customer, warehouse
               WHERE w_id = :w-id AND c_w_id = w_id AND
                   c_d_id = :d-id AND c_id = :c-id
           END-EXEC
           EXEC JAVA
                ctt1.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlnord to true
               move x'01' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           move c-last to clast
           move c-credit to ccredit
           move c-discount to cdiscount
           move w-tax to wtax

gg    *    EXEC SQL
gg    *        SELECT d_next_o_id, d_tax
gg    *        INTO :d-next-o-id, :d-tax
gg    *        FROM district
gg    *        WHERE d_id = :d-id AND d_w_id = :w-id
gg    *    END-EXEC
gg    *
gg    *    move d-tax to dtax

           if tpc-trace-reqd
               set trace-sqlnord to true
               move x'02' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-update to true
               move 'Di' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC JAVA
           CountTheTime ctt2 = new 
           CountTheTime("SQLNORD-UpdateDistrict");
           END-EXEC
           EXEC SQL
               UPDATE district
               SET d_next_o_id = d_next_o_id + 1
               WHERE d_id = :d-id AND d_w_id = :w-id
           END-EXEC
           EXEC JAVA
           ctt2.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlnord to true
               move x'02' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if tpc-trace-reqd
               set trace-sqlnord to true
               move x'03' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-select to true
               move 'Di' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC JAVA
           CountTheTime ctt3 = new 
           CountTheTime("SQLNORD-SelectFromDistrict");
           END-EXEC
gg         EXEC SQL
gg             SELECT d_next_o_id, d_tax
gg             INTO :d-next-o-id, :d-tax
gg             FROM district
gg             WHERE d_id = :d-id AND d_w_id = :w-id
gg         END-EXEC
           EXEC JAVA
           ctt3.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlnord to true
               move x'03' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           move d-tax to dtax
           move d-next-o-id to o-id
           move o-id to oid

           move 1 to o-all-local
           perform varying o-ol-cnt from 1 by 1 until o-ol-cnt = 16
                       or (supware(o-ol-cnt) = 0 or itemid(o-ol-cnt) = 0
                           or qty(o-ol-cnt) = 0)
               move supware(o-ol-cnt) to ol-supply-w-id
               if ol-supply-w-id not = w-id
                   move 0 to o-all-local
               end-if
           end-perform
           subtract 1 from o-ol-cnt
           move o-ol-cnt to oolcnt

           if tpc-trace-reqd
               set trace-sqlnord to true
               move x'04' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-insert to true
               move 'Or' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC JAVA
           CountTheTime ctt4 = new 
           CountTheTime("SQLNORD-InsertIntoOrders");
           END-EXEC
           EXEC SQL
               INSERT INTO ORDERS
                   (o_id, o_d_id, o_w_id, o_c_id,
                    o_entry_d, o_ol_cnt, o_all_local)
               VALUES
                   (:o-id, :d-id, :w-id, :c-id,
                    :datetime, :o-ol-cnt, :o-all-local)
           END-EXEC
           EXEC JAVA
                ctt4.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlnord to true
               move x'04' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if tpc-trace-reqd
               set trace-sqlnord to true
               move x'05' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-insert to true
               move 'No' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC JAVA
           CountTheTime ctt5 = new 
           CountTheTime("SQLNORD-InsertIntoNewOrder");
           END-EXEC
           EXEC SQL
               INSERT INTO NEW_ORDER
                   (no_o_id, no_d_id, no_w_id)
               VALUES
                   (:o-id, :d-id, :w-id)
           END-EXEC
           EXEC JAVA
           ctt5.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlnord to true
               move x'05' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           perform varying ws-line-item from 1 by 1
                   until ws-line-item > o-ol-cnt
               move supware(ws-line-item) to ol-supply-w-id
               move itemid(ws-line-item) to ol-i-id
               move qty(ws-line-item) to ol-quantity

               EXEC SQL WHENEVER NOT FOUND go to invaliditem END-EXEC

               if tpc-trace-reqd
                   set trace-sqlnord to true
                   move x'06' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-select to true
                   move 'It' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC JAVA
           CountTheTime ctt6 = new 
           CountTheTime("SQLNORD-SelectItem");
           END-EXEC
               EXEC SQL
                   SELECT i_price, i_name , i_data
                   INTO :i-price, :i-name, :i-data
                   FROM item
                   WHERE i_id = :ol-i-id
               END-EXEC
           EXEC JAVA
                ctt6.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqlnord to true
                   move x'06' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               move i-price to price(ws-line-item)
               move i-name to iname(ws-line-item)

               EXEC SQL WHENEVER NOT FOUND go to sqlerr END-EXEC

               if tpc-trace-reqd
                   set trace-sqlnord to true
                   move x'07' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-select to true
                   move 'St' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC JAVA
           CountTheTime ctt7 = new 
           CountTheTime("SQLNORD-SelectFromStock");
           END-EXEC
               EXEC SQL
                   SELECT s_quantity, s_data,
                       s_dist_01, s_dist_02, s_dist_03, s_dist_04,
                       s_dist_05, s_dist_06, s_dist_07, s_dist_08,
                       s_dist_09, s_dist_10
                  INTO :s-quantity, :s-data,
                       :s-dist-01, :s-dist-02, :s-dist-03, :s-dist-04,
                       :s-dist-05, :s-dist-06, :s-dist-07, :s-dist-08,
                       :s-dist-09, :s-dist-10
                  FROM stock
                  WHERE s_i_id = :ol-i-id AND s_w_id = :ol-supply-w-id
               END-EXEC
           EXEC JAVA
           ctt7.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqlnord to true
                   move x'07' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

      *        *> pick correct s_dist_xx
               evaluate d-id
               when 1
                   move s-dist-01 to ol-dist-info
               when 2
                   move s-dist-02 to ol-dist-info
               when 3
                   move s-dist-03 to ol-dist-info
               when 4
                   move s-dist-04 to ol-dist-info
               when 5
                   move s-dist-05 to ol-dist-info
               when 6
                   move s-dist-06 to ol-dist-info
               when 7
                   move s-dist-07 to ol-dist-info
               when 8
                   move s-dist-08 to ol-dist-info
               when 9
                   move s-dist-09 to ol-dist-info
               when 10
                   move s-dist-10 to ol-dist-info
               end-evaluate

               move s-quantity to stock(ws-line-item)

               move 0 to i
               inspect i-data tallying i for all "original"
               inspect s-data tallying i for all "original"
               if i > 0
                   move 'B' to bg(ws-line-item)
               else
                   move 'G' to bg(ws-line-item)
               end-if

               if s-quantity > ol-quantity
                   compute s-quantity = s-quantity - ol-quantity
               else
                   compute s-quantity = s-quantity - ol-quantity + 91;
               end-if

               if tpc-trace-reqd
                   set trace-sqlnord to true
                   move x'08' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-update to true
                   move 'St' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
                   EXEC JAVA
           CountTheTime ctt8 = new 
           CountTheTime("SQLNORD-UpdateStock");
           END-EXEC
               EXEC SQL
                   UPDATE stock
                   SET s_quantity = :s-quantity
                   WHERE s_i_id = :ol-i-id AND s_w_id = :ol-supply-w-id
               END-EXEC
          EXEC JAVA
          ctt8.close();
          END-EXEC
               if tpc-trace-reqd
                   set trace-sqlnord to true
                   move x'08' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               compute ol-amount = ol-quantity * i-price
                   * (1 + w-tax + d-tax) * (1 - c-discount)

               move ol-amount to amt(ws-line-item)
               add ol-amount to ntotal
               move ntotal to total

               move olno (ws-line-item) to ws-olno

               if tpc-trace-reqd
                   set trace-sqlnord to true
                   move x'09' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-insert to true
                   move 'Ol' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
                   EXEC JAVA
           CountTheTime ctt9 = new 
           CountTheTime("SQLNORD-InsertIntoOrderLine");
           END-EXEC
               EXEC SQL
                   INSERT INTO order_line
                        (ol_o_id, ol_d_id, ol_w_id, ol_number,
                         ol_i_id, ol_supply_w_id, ol_delivery_d,
                         ol_quantity, ol_amount, ol_dist_info)
                   VALUES
                       (:o-id, :d-id, :w-id, :ws-olno,
                        :ol-i-id, :ol-supply-w-id, :datetime,
                        :ol-quantity, :ol-amount, :ol-dist-info)
               END-EXEC
           EXEC JAVA
           ctt9.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqlnord to true
                   move x'09' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

           end-perform
      *    *> End Order Lines

           EXEC CICS SYNCPOINT END-EXEC

           move "Order accepted" to msg

           move 0 to result-code
           exec cics return end-exec.

       invaliditem.
           EXEC CICS SYNCPOINT ROLLBACK END-EXEC
           move "Item number is not valid" to msg

           move 1 to result-code
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
      ***  $Workfile:   sqlnord.cbl  $ end
      ***--------------------------------------------------------------*
