       identification division.
       program-id. vsmpaym.

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
       01  ws-program-name                   pic x(8) value 'VSMPAYM '.

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
       01  n                                 pic s9(9) comp.
       01  namecnt                           pic s9(9) comp.
       01  c-new-data                        pic x(500).

       01  cust-tab-ind                      pic s9(9).

       01 filler.
           03  cust-tab
                   occurs 0 to 30000 times depending on cust-tab-ind
                   ascending t-c-first.
               05  t-c-id                    pic s9(9) comp.
               05  t-c-d-id                  pic s9(9) comp.
               05  t-c-w-id                  pic s9(9) comp.
               05  t-c-first                 pic x(16).

       copy cicserrd.

       copy tpctdata.

       LINKAGE SECTION.

       01 DFHCOMMAREA.

       copy cpypaym.

       PROCEDURE DIVISION.
       MAIN SECTION.
       main-para.
           move "YYYY-MM-DD-HH.MM.SS" to datetime
           move 0 to cust-tab-ind

           accept currentdate from date yyyymmdd
           accept currenttime from time
           move cdyyyy to dtyear
           move cdmm  to dtmonth
           move cddd  to dtday
           move cthh  to dthour
           move ctmn  to dtmin
           move ctss  to dtsec

           string
               cddd   delimited by size
               '-'    delimited by size
               cdmm   delimited by size
               '-'    delimited by size
               cdyyyy delimited by size
               ' '    delimited by size
               cthh   delimited by size
               ':'    delimited by size
               ctmn   delimited by size
               ':'    delimited by size
               ctss   delimited by size
           into hdate

           move wid to w-id
           move did to d-id
           move cid to c-id
           move cdid to c-d-id c-d-id2
           move cwid to c-w-id c-w-id2
           move hamount to h-amount
           move clast to c-last

           if tpc-trace-reqd
               set trace-vsmpaym to true
               move x'01' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-read-update to true
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
               update
               resp(response)
           end-exec
           if tpc-trace-reqd
               set trace-vsmpaym to true
               move x'01' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           add h-amount to w-ytd

           if tpc-trace-reqd
               set trace-vsmpaym to true
               move x'02' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-rewrite to true
               move 'Wh' to tpc-trace-info(1:2)
               move warehouse-key
                 to tpc-trace-info(3:length of warehouse-key)
               move 6 to tpc-trace-data-length
               add length of warehouse-key to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           exec cics
               rewrite file('WHOUSE') from(w-record)
               resp(response)
           end-exec
           if tpc-trace-reqd
               set trace-vsmpaym to true
               move x'02' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move w-street-1 to wstreet1
           move w-street-2 to wstreet2
           move w-city to wcity
           move w-state to wstate

           string
               w-zip(1:5) delimited by size
               '-'        delimited by size
               w-zip(6:4) delimited by size
           into wzip

           move w-id to d-w-id

           if tpc-trace-reqd
               set trace-vsmpaym to true
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
               set trace-vsmpaym to true
               move x'03' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           add h-amount to d-ytd

           if tpc-trace-reqd
               set trace-vsmpaym to true
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
               set trace-vsmpaym to true
               move x'04' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move d-street-1 to dstreet1
           move d-street-2 to dstreet2
           move d-city to dcity
           move d-state to dstate

           string
               d-zip(1:5) delimited by size
               '-'        delimited by size
               d-zip(6:4) delimited by size
           into dzip

           if clast not = spaces

               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'05' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-start-br to true
                   move 'Ca' to tpc-trace-info(1:2)
                   move customer-alt-key
                     to tpc-trace-info(3:length of customer-alt-key)
                   move 6 to tpc-trace-data-length
                   add length of customer-alt-key
                     to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   startbr file('CUSTALT')
                       ridfld(customer-alt-key)
                       keylength(length of customer-generic-name)
                       generic
                       resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'05' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if response not = dfhresp(NORMAL) and
                  response not = dfhresp(NOTFND)
                   perform CICSError
               end-if

               if response not = dfhresp(NOTFND)
                   if tpc-trace-reqd
                       set trace-vsmpaym to true
                       move x'06' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-vsm-read-next to true
                       move 'Ca' to tpc-trace-info(1:2)
                       move customer-alt-key
                         to tpc-trace-info(3:length of customer-alt-key)
                       move 6 to tpc-trace-data-length
                       add length of customer-alt-key
                         to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   exec cics
                       readnext file('CUSTALT') into(c-record)
                           ridfld(customer-alt-key)
                           resp(response)
                   end-exec
                   if tpc-trace-reqd
                       set trace-vsmpaym to true
                       move x'06' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
               end-if

               move 0 to cust-tab-ind

               perform until
                       (response = dfhresp(NOTFND))
                   or
                       (c-d-id not = did or c-w-id not = wid
                        or c-last not = clast)

                   if response not = dfhresp(NORMAL)
                       perform CICSError
                   end-if

                   add 1 to cust-tab-ind
                   move c-id to t-c-id(cust-tab-ind)
                   move c-d-id to t-c-d-id(cust-tab-ind)
                   move c-w-id to t-c-w-id(cust-tab-ind)
                   move c-first to t-c-first(cust-tab-ind)

                   if tpc-trace-reqd
                       set trace-vsmpaym to true
                       move x'07' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-vsm-read-next to true
                       move 'Ca' to tpc-trace-info(1:2)
                       move customer-alt-key
                         to tpc-trace-info(3:length of customer-alt-key)
                       move 6 to tpc-trace-data-length
                       add length of customer-alt-key
                         to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   exec cics
                       readnext file('CUSTALT') into(c-record)
                       ridfld(customer-alt-key)
                       resp(response)
                   end-exec
                   if tpc-trace-reqd
                       set trace-vsmpaym to true
                       move x'07' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
               end-perform

               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'08' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-stop-br to true
                   move 'Ca' to tpc-trace-info(1:2)
                   move 6 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   endbr file('CUSTALT')
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'08' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if response not = dfhresp(NORMAL)
                   perform CICSError
               end-if

               move cust-tab-ind to namecnt

               if namecnt = 0
                   perform cust-not-found
               end-if

      *        sort cust-tab

      *        *> Locate midpoint customer
               if function mod(namecnt,2) not = 0
                   add 1 to namecnt
               end-if

               divide 2 into namecnt

               move t-c-id(namecnt) to c-id
               move t-c-w-id(namecnt) to c-w-id
               move t-c-d-id(namecnt) to c-d-id

               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'09' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-read-update to true
                   move 'Cu' to tpc-trace-info(1:2)
                   move customer-key
                     to tpc-trace-info(3:length of customer-key)
                   move 6 to tpc-trace-data-length
                   add length of customer-key
                     to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   read file('CUSTOMER') into(c-record)
                   ridfld(customer-key)
                   update
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'09' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if response not = dfhresp(NORMAL)
                   perform CICSError
               end-if
           else
               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'0A' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-read-update to true
                   move 'Cu' to tpc-trace-info(1:2)
                   move customer-key
                     to tpc-trace-info(3:length of customer-key)
                   move 6 to tpc-trace-data-length
                   add length of customer-key
                     to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   read file('CUSTOMER') into(c-record)
                   ridfld(customer-key)
                   update
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'0A' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if response not = dfhresp(NORMAL)
                   perform cust-not-found
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
               c-zip(1:5) delimited by size
               '-'        delimited by size
               c-zip(6:4) delimited by size
           into czip

           string
               c-phone(1:6)  delimited by size
               '-'           delimited by size
               c-phone(7:3)  delimited by size
               '-'           delimited by size
               c-phone(10:3) delimited by size
               '-'           delimited by size
               c-phone(13:4) delimited by size
           into cphone

           string
               c-since(9:2) delimited by size
               "-"          delimited by size
               c-since(6:2) delimited by size
               "-"          delimited by size
               c-since(1:4) delimited by size
           into csince

           move c-credit to ccredit
           move c-credit-lim to ccreditlim
           move c-discount to cdiscount

           subtract h-amount from c-balance

           move c-balance to cbalance

           add h-amount to c-ytd-payment

           add 1 to c-payment-cnt

           if c-credit = "BC"
               string
                   "ª "    delimited by size
                   cid     delimited by size
                   " "     delimited by size
                   cdid    delimited by size
                   " "     delimited by size
                   cwid    delimited by size
                   " "     delimited by size
                   did     delimited by size
                   " "     delimited by size
                   wid     delimited by size
                   " "     delimited by size
                   hamount delimited by size
                   " "     delimited by size
                   hdate   delimited by size
                   " "     delimited by size
                   c-data  delimited by size
               into c-new-data

               move c-new-data to c-data

               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'0B' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-rewrite to true
                   move 'Cu' to tpc-trace-info(1:2)
                   move customer-key
                     to tpc-trace-info(3:length of customer-key)
                   move 6 to tpc-trace-data-length
                   add length of customer-key
                     to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   rewrite file('CUSTOMER') from(c-record)
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'0B' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if response not = dfhresp(NORMAL)
                   perform CICSError
               end-if

               move c-new-data to cdata

           else
               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'0C' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-rewrite to true
                   move 'Cu' to tpc-trace-info(1:2)
                   move customer-key
                     to tpc-trace-info(3:length of customer-key)
                   move 6 to tpc-trace-data-length
                   add length of customer-key
                     to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   rewrite file('CUSTOMER') from(c-record)
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmpaym to true
                   move x'0C' to tpc-trace-call-seq
                   set trace-after-call to true
                   move low-values to tpc-trace-data
                   move 0 to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if

               if response not = dfhresp(NORMAL)
                   perform CICSError
               end-if

               move spaces to cdata
           end-if

           string
               w-name delimited by size
               d-name delimited by size
               "    " delimited by size
           into h-data

           move c-d-id to h-c-d-id
           move c-w-id to h-c-w-id
           move c-id to h-c-id
           move d-id to h-d-id
           move w-id to h-w-id
           move datetime to h-date

           if tpc-trace-reqd
               set trace-vsmpaym to true
               move x'0D' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-write to true
               move 'Hi' to tpc-trace-info(1:2)
               move history-key
                 to tpc-trace-info(3:length of history-key)
               move 6 to tpc-trace-data-length
               add length of history-key
                 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           exec cics
               write file('HISTORY') from(h-record)
               ridfld(history-key)
               resp(response)
           end-exec
           if tpc-trace-reqd
               set trace-vsmpaym to true
               move x'0D' to tpc-trace-call-seq
               set trace-after-call to true
               move low-values to tpc-trace-data
               move 0 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           exec cics
               syncpoint
               resp(response)
           end-exec

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move 0 to result-code

           exec cics return end-exec.


       cust-not-found.
      *    ROLLBACK
           exec cics
               syncpoint
               rollback
               resp(response)
           end-exec

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move "Customer name is not valid" to err

           move -1 to result-code

           exec cics return end-exec.


       CICSError section.

       copy CICSERR.

           exec cics syncpoint rollback end-exec

           exec cics return end-exec.
           .

      ***--------------------------------------------------------------*
      ***  $Workfile:   vsmpaym.cbl  $ end
      ***--------------------------------------------------------------*
