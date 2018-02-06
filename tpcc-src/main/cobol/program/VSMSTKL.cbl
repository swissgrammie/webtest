       identification division.

       program-id. vsmstkl.

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
       01  ws-program-name                   pic x(8) value 'VSMSTKL '.

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
       01  namecnt                           pic s9(9) comp.

       01  stock-ind                         pic s9(9) comp.

       01  dist-per-ware                     pic 99 value 10.

       01 filler.
           03  stock-tab occurs 0 to 300 depending on stock-ind
                   indexed by n.
               05  t-s-i-id                  pic s9(9) comp.
               05  t-s-w-id                  pic s9(9) comp.

       copy cicserrd.

       copy tpctdata.

       LINKAGE SECTION.

       01 DFHCOMMAREA.

       copy cpystkl.

       PROCEDURE DIVISION.
       MAIN SECTION.
       main-para.
           move "YYYY-MM-DD-HH.MM.SS" to datetime

           move wid to w-id
           move did to d-id

           move w-id to d-w-id

           if tpc-trace-reqd
               set trace-vsmstkl to true
               move x'01' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-read to true
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
               resp(response)
           end-exec
           if tpc-trace-reqd
               set trace-vsmstkl to true
               move x'01' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move d-next-o-id to o-id

           move 0 to stockcount

           move w-id to ol-w-id
           move d-id to ol-d-id
           move o-id to ol-o-id
           subtract 20 from ol-o-id

           if tpc-trace-reqd
               set trace-vsmstkl to true
               move x'02' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-start-br to true
               move 'Ol' to tpc-trace-info(1:2)
               move order-line-alt-key
                 to tpc-trace-info(3:length of order-line-alt-key)
               move 6 to tpc-trace-data-length
               add length of order-line-alt-key
                 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           exec cics
               startbr file('ORDLINE')
               ridfld(order-line-alt-key)
               keylength(length of order-line-alt-key) generic
               resp(response)
           end-exec
           if tpc-trace-reqd
               set trace-vsmstkl to true
               move x'02' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           perform with test after until
                   (response = dfhresp(NOTFND))
                   or
                   (ol-w-id not = w-id or ol-d-id not = d-id
                           or ol-o-id >= o-id)
               if tpc-trace-reqd
                   set trace-vsmstkl to true
                   move x'03' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-read-next to true
                   move 'Ol' to tpc-trace-info(1:2)
                   move order-line-alt-key
                     to tpc-trace-info(3:length of order-line-alt-key)
                   move 6 to tpc-trace-data-length
                   add length of order-line-alt-key
                     to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   readnext file('ORDLINE') into(ol-record)
                   ridfld(order-line-alt-key)
                   keylength(length of order-line-alt-key)
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmstkl to true
                   move x'03' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               if response = dfhresp(NOTFND)
      *            *> no find
                   continue
               else
                   if response not = dfhresp(NORMAL)
                       perform CICSError
                   end-if
                   if ol-w-id not = w-id or ol-d-id not = d-id
                           or ol-o-id >= o-id
                       continue
                   else

                       move w-id to s-w-id
                       move ol-i-id to s-i-id

                       if tpc-trace-reqd
                           set trace-vsmstkl to true
                           move x'04' to tpc-trace-call-seq
                           set trace-before-call to true
                           set trace-vsm-read to true
                           move 'St' to tpc-trace-info(1:2)
                           move stock-key
                             to tpc-trace-info(3:length of stock-key)
                           move 6 to tpc-trace-data-length
                           add length of stock-key
                             to tpc-trace-data-length
                           call 'TPCTRACE' using tpc-trace-data-block
                       end-if
                       exec cics
                           read file('STOCK') into(s-record)
                           ridfld(stock-key)
                           resp(response)
                       end-exec
                       if tpc-trace-reqd
                           set trace-vsmstkl to true
                           move x'04' to tpc-trace-call-seq
                           set trace-after-call to true
                           move low-values to tpc-trace-data
                           move 0 to tpc-trace-data-length
                           call 'TPCTRACE' using tpc-trace-data-block
                       end-if

                       if response not = dfhresp(NORMAL)
                           perform CICSError
                       end-if

                       move 0 to stock-ind

                       if s-quantity < threshold
                           set n to 1
                           move 0 to i
                           search stock-tab
                               when s-i-id = t-s-i-id(n)
                                   move 1 to i
                           end-search

                           if i = 0
                               add 1 to stockcount
                               add 1 to stock-ind
                               move s-i-id to t-s-i-id(stock-ind)
                           end-if
                       end-if
                       move 0 to stock-ind
                   end-if
               end-if

           end-perform

           exec cics
               syncpoint
               resp(response)
           end-exec

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move 0 to result-code

           exec cics return end-exec.


       CICSError section.

       copy CICSERR.

           exec cics syncpoint rollback end-exec

           exec cics return end-exec.
           .
      ***--------------------------------------------------------------*
      ***  $Workfile:   vsmstkl.cbl  $ end
      ***--------------------------------------------------------------*
