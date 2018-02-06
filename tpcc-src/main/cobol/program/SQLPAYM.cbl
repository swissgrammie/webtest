       identification division.

       program-id. sqlpaym.

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
      * TPCC Payment transaction
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
       01  ws-program-name                   pic x(8) value 'SQLPAYM '.

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

       01  datetime                          pic x(19).
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

       01  i                                 pic s9(9) comp.
       01  n                                 pic s9(9) comp.

           EXEC SQL BEGIN DECLARE SECTION END-EXEC

       01  namecnt                           pic s9(9) comp.
           EXEC SQL END DECLARE SECTION END-EXEC

      
       copy tpctdata.

       LINKAGE SECTION.

       01 DFHCOMMAREA.

       copy cpypaym.

       PROCEDURE DIVISION.
       MAIN.
           EXEC SQL WHENEVER NOT FOUND go to sqlerr END-EXEC
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
  lh  *    into hdate
           move datetime to hdate

           move wid to w-id
           move did to d-id
           move cid to c-id
           move cdid to c-d-id
           move cwid to c-w-id
           move hamount to h-amount
           move clast to c-last

           if tpc-trace-reqd
               set trace-sqlpaym to true
               move x'01' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-select to true
               move 'Wh' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC JAVA
           CountTheTime ctt1 = new 
           CountTheTime("SQLPAYM-SelectFromWarehouse");
           END-EXEC
           EXEC SQL
               SELECT w_street_1, w_street_2, w_city, w_state, w_zip,
                   w_name
               INTO :w-street-1, :w-street-2, :w-city, :w-state,
                   :w-zip, :w-name
               FROM warehouse
               WHERE w_id=:w-id
           END-EXEC
           EXEC JAVA
           ctt1.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlpaym to true
               move x'01' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           move w-street-1 to wstreet1
           move w-street-2 to wstreet2
           move w-city to wcity
           move w-state to wstate

           string
               w-zip(1:5)   delimited by size
               '-'          delimited by size
               w-zip(6:4)   delimited by size
           into wzip

           if tpc-trace-reqd
               set trace-sqlpaym to true
               move x'02' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-select to true
               move 'Di' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           EXEC JAVA
           CountTheTime ctt2 = new 
           CountTheTime("SQLPAYM-SelectFromDistrict");
           END-EXEC
           EXEC SQL
               SELECT d_street_1, d_street_2, d_city, d_state, d_zip,
                   d_name
               INTO :d-street-1, :d-street-2, :d-city, :d-state, :d-zip,
                   :d-name
               FROM district
               WHERE d_w_id=:w-id AND d_id=:d-id
           END-EXEC
           EXEC JAVA
           ctt2.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlpaym to true
               move x'02' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           move d-street-1 to dstreet1
           move d-street-2 to dstreet2
           move d-city to dcity
           move d-state to dstate

           string
               d-zip(1:5)      delimited by size
               '-'             delimited by size
               d-zip(6:4)      delimited by size
           into dzip

           move clast to c-last

           if c-last not = spaces
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'03' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-select to true
                   move 'Cu' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC JAVA
           CountTheTime ctt3 = new 
           CountTheTime("SQLPAYM-SelectFromCustomerDistinct");
           END-EXEC
               EXEC SQL
                   SELECT count(distinct c_id) INTO :namecnt
                   FROM customer
                   WHERE c_last=:c-last AND c_d_id=:c-d-id
                       AND c_w_id=:c-w-id
               END-EXEC
           EXEC JAVA
           ctt3.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'03' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if namecnt = 0
                   perform cust-not-found
               end-if

               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'04' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-csr-declare to true
                   move 'CSR 01' to tpc-trace-info
                   move 8 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC JAVA
           CountTheTime ctt4 = new 
           CountTheTime("SQLPAYM-SelectFromCustomerOrderBy");
           END-EXEC
               EXEC SQL DECLARE c_byname CURSOR FOR
                   SELECT c_first, c_middle, c_id,
                       c_street_1, c_street_2, c_city, c_state,
                       c_zip, c_phone, c_credit, c_credit_lim,
                       c_discount, c_balance, c_since
                   FROM customer
                   WHERE c_w_id=:c-w-id AND c_d_id=:c-d-id
                       AND c_last=:c-last
                   ORDER BY c_first
               END-EXEC
           EXEC JAVA
           ctt4.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'04' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'05' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-csr-open to true
                   move 'CSR 01' to tpc-trace-info
                   move 8 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC SQL OPEN c_byname END-EXEC
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'05' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

      *        *> Locate midpoint customer
               if function mod(namecnt,2) not = 0
                   add 1 to namecnt
               end-if
               perform varying n from 0 by 1 until n >= namecnt / 2
                   if tpc-trace-reqd
                       set trace-sqlpaym to true
                       move x'06' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-sql-csr-fetch to true
                       move 'CSR 01' to tpc-trace-info
                       move 8 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   EXEC SQL
                       FETCH c_byname
                       INTO :c-first, :c-middle, :c-id,
                           :c-street-1, :c-street-2, :c-city, :c-state,
                           :c-zip, :c-phone, :c-credit, :c-credit-lim,
                           :c-discount, :c-balance, :c-since
                   END-EXEC
                   if tpc-trace-reqd
                       set trace-sqlpaym to true
                       move x'06' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
               end-perform

               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'07' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-csr-close to true
                   move 'CSR 01' to tpc-trace-info
                   move 8 to tpc-trace-data-length
                  call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC SQL CLOSE c_byname END-EXEC
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'07' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
           else
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'08' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-select to true
                   move 'Cu' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               EXEC JAVA
           CountTheTime ctt5 = new 
           CountTheTime("SQLPAYM-SelectFromCustomer");
           END-EXEC
               EXEC SQL
                   SELECT c_first, c_middle, c_last,
                       c_street_1, c_street_2, c_city, c_state, c_zip,
                       c_phone, c_credit, c_credit_lim,
                       c_discount, c_balance, c_since
                   INTO :c-first, :c-middle, :c-last,
                       :c-street-1, :c-street-2, :c-city, :c-state,
                       :c-zip, :c-phone, :c-credit, :c-credit-lim,
                       :c-discount, :c-balance, :c-since
                   FROM customer
                   WHERE c_w_id=:c-w-id AND c_d_id=:c-d-id
                       AND c_id=:c-id
               END-EXEC
           EXEC JAVA
           ctt5.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'08' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
           end-if

           move c-id to cid
           move c-first to cfirst
           move c-middle to cmiddle
           move c-last to clast
           move c-street-1 to cstreet1
           move c-street-2 to cstreet2
           move c-city to ccity
           move c-state to cstate

           string
               c-zip(1:5)      delimited by size
               '-'             delimited by size
               c-zip(6:4)      delimited by size
           into czip

           string
               c-phone(1:6)    delimited by size
               '-'             delimited by size
               c-phone(7:3)    delimited by size
               '-'             delimited by size
               c-phone(10:3)   delimited by size
               '-'             delimited by size
               c-phone(13:4)   delimited by size
           into cphone

           string
               c-since(9:2) delimited size
               "-" delimited size
               c-since(6:2) delimited size
               "-" delimited size
               c-since(1:4) delimited size
           into csince

           move c-credit to ccredit
           move c-credit-lim to ccreditlim
           move c-discount to cdiscount

           subtract h-amount from c-balance

           move c-balance to cbalance

           if c-credit = "BC"
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'09' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-select to true
                   move 'Cu' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
                   EXEC JAVA
           CountTheTime ctt6 = new 
           CountTheTime("SQLPAYM-SelectFromCustomer2");
           END-EXEC
               EXEC SQL
                   SELECT c_data
                   INTO :c-data
                   FROM customer
                   WHERE c_w_id=:c-w-id AND c_d_id=:c-d-id
                       AND c_id=:c-id
               END-EXEC
           EXEC JAVA
           ctt6.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'09' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               string
                   "� " delimited size
                   cid delimited size
                   " "  delimited size
                   cdid delimited size
                   " "  delimited size
                   cwid delimited size
                   " "  delimited size
                   did  delimited size
                   " "  delimited size
                   wid  delimited size
                   " "  delimited size
                   hamount delimited size
                   " "  delimited size
                   hdate delimited size
                   " "  delimited size
                   c-data-data delimited size
               into c-new-data-data
               move length c-new-data-data to c-new-data-len

               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'0A' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-update to true
                   move 'Cu' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
                   EXEC JAVA
           CountTheTime ctt7 = new 
           CountTheTime("SQLPAYM-UpdateCustomer");
           END-EXEC
               EXEC SQL
                   UPDATE customer
                   SET c_balance = :c-balance,  c_data = :c-new-data,
                       c_ytd_payment = c_ytd_payment + :h-amount,
                       c_payment_cnt = c_payment_cnt + 1
                   WHERE c_w_id = :c-w-id AND c_d_id = :c-d-id
                       AND c_id = :c-id
               END-EXEC
           EXEC JAVA
           ctt7.close();
           END-EXEC
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'0A' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               move c-new-data to cdata

           else
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'0B' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-sql-update to true
                   move 'Cu' to tpc-trace-info
                   move 4 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
                   EXEC JAVA
           CountTheTime ctt8 = new 
           CountTheTime("SQLPAYM-UpdateCustomer2");
           END-EXEC
               EXEC SQL
                   UPDATE customer
                   SET c_balance = :c-balance,
                       c_ytd_payment = c_ytd_payment + :h-amount,
                       c_payment_cnt = c_payment_cnt + 1
                   WHERE c_w_id = :c-w-id AND c_d_id = :c-d-id
                       AND c_id = :c-id
               END-EXEC
          EXEC JAVA
          ctt8.close();
          END-EXEC
               if tpc-trace-reqd
                   set trace-sqlpaym to true
                   move x'0B' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               move spaces to cdata
           end-if

           string
               w-name delimited size
               d-name delimited size
               "    " delimited size
           into h-data

           if tpc-trace-reqd
               set trace-sqlpaym to true
               move x'0C' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-insert to true
               move 'Hi' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
               EXEC JAVA
           CountTheTime ctt9 = new 
           CountTheTime("SQLPAYM-InsertIntoHistory");
           END-EXEC
           EXEC SQL
               INSERT INTO history
                   (h_c_d_id, h_c_w_id, h_c_id, h_d_id,
                    h_w_id, h_date, h_amount, h_data)
               VALUES
                   (:c-d-id, :c-w-id, :c-id, :d-id,
                    :w-id, :datetime, :h-amount, :h-data)
           END-EXEC
           EXEC JAVA
           ctt9.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlpaym to true
               move x'0C' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if tpc-trace-reqd
               set trace-sqlpaym to true
               move x'0D' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-update to true
               move 'Di' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
               EXEC JAVA
           CountTheTime ctt10 = new 
           CountTheTime("SQLPAYM-UpdateDistrict");
           END-EXEC
           EXEC SQL
               UPDATE district
               SET d_ytd = d_ytd + :h-amount
               WHERE d_w_id=:w-id AND d_id=:d-id
           END-EXEC
           EXEC JAVA
           ctt10.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlpaym to true
               move x'0D' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if tpc-trace-reqd
               set trace-sqlpaym to true
               move x'0E' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-sql-update to true
               move 'Wh' to tpc-trace-info
               move 4 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
               EXEC JAVA
           CountTheTime ctt11 = new 
           CountTheTime("SQLPAYM-UPDATEWAREHOUSE");
           END-EXEC
           EXEC SQL
               UPDATE warehouse
               SET w_ytd = w_ytd + :h-amount
               WHERE w_id=:w-id
           END-EXEC
           EXEC JAVA
           ctt11.close();
           END-EXEC
           if tpc-trace-reqd
               set trace-sqlpaym to true
               move x'0E' to tpc-trace-call-seq
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
      ***  $Workfile:   sqlpaym.cbl  $ end
      ***--------------------------------------------------------------*
