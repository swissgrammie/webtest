       identification division.

       program-id. vsmnord.

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
       01  ws-program-name                   pic x(8) value 'VSMNORD '.

       copy tpcfiles.

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
       01  ntotal                            pic 99999V99 comp-3.
       01  ws-line-item                      pic s9(9) comp.
       01  ws-olno                           pic s9(9) comp.

       copy cicserrd.
      
       copy tpctdata.

       LINKAGE SECTION.

       01 DFHCOMMAREA.
      
       copy cpynord.

       PROCEDURE DIVISION.
       MAIN SECTION.
       main-para.
           move "YYYY-MM-DD-HH.MM.SS" to datetime

      *    *> Initialize timestamp (for date columns)
           accept currentdate from date yyyymmdd
           accept currenttime from time
           move cdyyyy to dtyear
           move cdmm  to dtmonth
           move cddd  to dtday
           move cthh  to dthour
           move ctmn  to dtmin
           move ctss  to dtsec

           string
               cddd             delimited by size
               '-'              delimited by size
               cdmm             delimited by size
               '-'              delimited by size
               cdyyyy           delimited by size
               ' '              delimited by size
               cthh             delimited by size
               ':'              delimited by size
               ctmn             delimited by size
               ':'              delimited by size
               ctss             delimited by size
           into oentrydt

           move cid to c-id
           move did to d-id
           move wid to w-id

           move 0 to ntotal

           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'01' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-read to true
               move 'Wh' to tpc-trace-info(1:2)
               move warehouse-key
                 to tpc-trace-info(3:length of warehouse-key)
               move 6 to tpc-trace-data-length
               add length of warehouse-key to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           exec cics
               read file('WHOUSE') into(w-record)
               ridfld(warehouse-key)
               resp(response)
           end-exec
           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'01' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move w-id to c-w-id
           move d-id to c-d-id

           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'02' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-read-update to true
               move 'Cu' to tpc-trace-info(1:2)
               move customer-key
                 to tpc-trace-info(3:length of customer-key)
               move 6 to tpc-trace-data-length
               add length of customer-key to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           exec cics
               read file('CUSTOMER') into(c-record)
               ridfld(customer-key)
               resp(response)
MWW   *        update
           end-exec
           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'02' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move c-last to clast
           move c-credit to ccredit
           move c-discount to cdiscount
           move w-tax to wtax

           move w-id to d-w-id

           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'03' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-read-update to true
               move 'Di' to tpc-trace-info(1:2)
               move district-key
                 to tpc-trace-info(3:length of district-key)
               move 6 to tpc-trace-data-length
               add length of district-key to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           exec cics
               read file('DISTRICT') into(d-record)
               ridfld(district-key)
               update
               resp(response)
           end-exec
           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'03' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move d-tax to dtax
           move d-next-o-id to o-id

           add 1 to d-next-o-id

           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'04' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-rewrite to true
               move 'Di' to tpc-trace-info(1:2)
               move district-key
                 to tpc-trace-info(3:length of district-key)
               move 6 to tpc-trace-data-length
               add length of district-key to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           exec cics
               rewrite file('DISTRICT') from(d-record)
               resp(response)
           end-exec
           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'04' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

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

           move d-id to o-d-id o-d-id2
           move w-id to o-w-id o-w-id2
           move c-id to o-c-id
           move datetime to o-entry-d
           move 0 to o-carrier-id

           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'05' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-write to true
               move 'Or' to tpc-trace-info(1:2)
               move order-key
                 to tpc-trace-info(3:length of order-key)
               move 6 to tpc-trace-data-length
               add length of order-key to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           exec cics
               write file('ORD') from(o-record)
               ridfld(order-key)
               resp(response)
           end-exec
           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'05' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move o-id to no-o-id
           move d-id to no-d-id
           move w-id to no-w-id

           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'06' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-write to true
               move 'No' to tpc-trace-info(1:2)
               move new-order-key
                 to tpc-trace-info(3:length of new-order-key)
               move 6 to tpc-trace-data-length
               add length of new-order-key to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           exec cics
               write file('NEWORD') from(no-record)
               ridfld(new-order-key)
               resp(response)
           end-exec
           if tpc-trace-reqd
               set trace-vsmnord to true
               move x'06' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           perform varying ws-line-item from 1 by 1
                   until ws-line-item > o-ol-cnt
               move supware(ws-line-item) to ol-supply-w-id
               move itemid(ws-line-item) to ol-i-id
               move qty(ws-line-item) to ol-quantity

               move ol-i-id to i-id

               if tpc-trace-reqd
                   set trace-vsmnord to true
                   move x'07' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-read to true
                   move 'It' to tpc-trace-info(1:2)
                   move new-order-key
                   to tpc-trace-info(3:length of item-key)
                   move 6 to tpc-trace-data-length
                   add length of item-key to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   read file('ITEM') into(i-record)
                   ridfld(item-key)
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmnord to true
                   move x'07' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if response = dfhresp(NOTFND)
      *            *> no find
                   perform invaliditem
               end-if

               move i-price to price(ws-line-item)
               move i-name to iname(ws-line-item)

               move ol-i-id to s-i-id
               move ol-supply-w-id to s-w-id
               if tpc-trace-reqd
                   set trace-vsmnord to true
                   move x'08' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-read-update to true
                   move 'St' to tpc-trace-info(1:2)
                   move stock-key
                     to tpc-trace-info(3:length of stock-key)
                   move 6 to tpc-trace-data-length
                   add length of stock-key to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   read file('STOCK') into(s-record)
                   ridfld(stock-key)
                   update
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmnord to true
                   move x'08' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if response not = dfhresp(NORMAL)
                   perform CICSError
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
                   set trace-vsmnord to true
                   move x'09' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-rewrite to true
                   move 'St' to tpc-trace-info(1:2)
                   move stock-key
                     to tpc-trace-info(3:length of stock-key)
                   move 6 to tpc-trace-data-length
                   add length of stock-key to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   rewrite file('STOCK') from(s-record)
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmnord to true
                   move x'09' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if response not = dfhresp(NORMAL)
                   perform CICSError
               end-if

               compute ol-amount = ol-quantity * i-price
                   * (1 + w-tax + d-tax) * (1 - c-discount)

               move ol-amount to amt(ws-line-item);
               add ol-amount to ntotal
               move ntotal to total

               move olno (ws-line-item) to ws-olno
               move ws-olno to ol-number

               move o-id to ol-o-id
               move d-id to ol-d-id
               move w-id to ol-w-id
               move datetime to ol-delivery-d

               if tpc-trace-reqd
                   set trace-vsmnord to true
                   move x'0A' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-write to true
                   move 'Ol' to tpc-trace-info(1:2)
                   move order-line-key
                     to tpc-trace-info(3:length of order-line-key)
                   move 6 to tpc-trace-data-length
                   add length of order-line-key to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   write file('ORDLINE') from(ol-record)
                   ridfld(order-line-key)
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmnord to true
                   move x'0A' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if response not = dfhresp(NORMAL)
                   perform CICSError
               end-if

           end-perform
      *    *> End Order Lines

      *    COMMIT
           exec cics
               syncpoint
               resp(response)
           end-exec

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move "Order accepted" to msg

           move -1 to result-code

           exec cics return end-exec.

       invaliditem.
      *    ROLLBACK
           exec cics
               syncpoint
               rollback
               resp(response)
           end-exec

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if
           move "Item number is not valid" to msg

           move 1 to result-code

           exec cics return end-exec.

       CICSError section.

       copy CICSERR.
gg    * CBLNORD map doesn't follow the pattern of the other modules
gg    * so we move err to msg so that the CICS debug info is now on
gg    * line 23 and wider
gg         move err to msg
gg         move spaces to err
           exec cics syncpoint rollback end-exec

           exec cics return end-exec.
       h    .

      ***--------------------------------------------------------------*
      ***  $Workfile:   vsmnord.cbl  $ end
      ***--------------------------------------------------------------*
