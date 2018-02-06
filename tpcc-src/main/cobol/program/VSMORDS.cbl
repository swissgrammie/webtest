       identification division.

       program-id. vsmords.

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
       01  ws-program-name                   pic x(8) value 'VSMORDS '.

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
           03  dtday                         pic X(2).
           03  filler                        pic x(1).
           03  dthour                        pic x(2).
           03  filler                        pic x(1).
           03  dtmin                         pic x(2).
           03  filler                        pic x(1).
           03  dtsec                         pic x(2).

       01  ind                               pic s9(4) comp.

       01  i                                 pic s9(9) comp.
       01  n                                 pic s9(9) comp.
       01  namecnt                           pic s9(9) comp.

       01  try-o-id                          pic s9(9) comp.
       01  try-o-entry-d                     pic x(20).
       01  try-o-carrier-id                  pic s9(9) comp.

       01  entdate                           pic x(29).

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

       copy cpyords.

       PROCEDURE DIVISION.
       MAIN SECTION.
       main-para.
           exec cics ignore condition DUPKEY end-exec

           move "YYYY-MM-DD-HH.MM.SS" to datetime

           accept currentdate from date yyyymmdd
           accept currenttime from time
           move cdyyyy to dtyear
           move cdmm  to dtmonth
           move cddd  to dtday
           move cthh  to dthour
           move ctmn  to dtmin
           move ctss  to dtsec

           move 0 to cust-tab-ind

           move cid to c-id
           move wid to w-id
           move did to d-id
           move clast to c-last
           move did to c-d-id c-d-id2
           move wid to c-w-id c-w-id2

           if clast not = spaces

               if tpc-trace-reqd
                   set trace-vsmords to true
                   move x'01' to tpc-trace-call-seq
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
                   set trace-vsmords to true
                   move x'01' to tpc-trace-call-seq
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
                       set trace-vsmords to true
                       move x'02' to tpc-trace-call-seq
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
                       move x'02' to tpc-trace-call-seq
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
                       set trace-vsmords to true
                       move x'03' to tpc-trace-call-seq
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
                       move x'03' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
               end-perform

               if tpc-trace-reqd
                   set trace-vsmords to true
                   move x'04' to tpc-trace-call-seq
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
                   move x'04' to tpc-trace-call-seq
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
                   set trace-vsmords to true
                   move x'05' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-read to true
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

               if response not = dfhresp(NORMAL)
                   perform CICSError
               end-if
           else
               if tpc-trace-reqd
                   set trace-vsmords to true
                   move x'06' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-read to true
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

               if response not = dfhresp(NORMAL)
                   perform cust-not-found
               end-if

           end-if

           move c-balance to cbalance
           move c-first to cfirst
           move c-middle to cmiddle
           move c-last to clast
           move c-id to cid

           move w-id to o-w-id o-w-id2
           move d-id to o-d-id o-d-id2
           move c-id to o-c-id

           if tpc-trace-reqd
               set trace-vsmords to true
               move x'07' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-start-br to true
               move 'Oa' to tpc-trace-info(1:2)
               move order-alt-key
                 to tpc-trace-info(3:length of order-alt-key)
               move 6 to tpc-trace-data-length
               add length of order-alt-key
                 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
           end-if
           exec cics
               startbr file('ORDALT')
               ridfld(order-alt-key)
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

           if response not = dfhresp(NORMAL) and
              response not = dfhresp(NOTFND)
              perform CICSError
           end-if

           if response not = dfhresp(NOTFND)
               if tpc-trace-reqd
                   set trace-vsmords to true
                   move x'08' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-read-next to true
                   move 'Oa' to tpc-trace-info(1:2)
                   move order-alt-key
                     to tpc-trace-info(3:length of order-alt-key)
                   move 6 to tpc-trace-data-length
                   add length of order-alt-key
                     to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   readnext file('ORDALT') into(o-record)
                   ridfld(order-alt-key)
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
           end-if

           move 0 to try-o-id

           perform until
                   (response = dfhresp(NOTFND))
                   or
                   (o-d-id not = d-id or o-w-id not = w-id
                       or o-c-id not = c-id)
               if response not = dfhresp(NORMAL) and
                       response not = dfhresp(DUPKEY)
                   perform CICSError
               end-if

               if o-id > try-o-id
                   move o-id to try-o-id
                   move o-carrier-id to try-o-carrier-id
                   move o-entry-d to try-o-entry-d
               end-if

               if tpc-trace-reqd
                   set trace-vsmords to true
                   move x'09' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-read-next to true
                   move 'Oa' to tpc-trace-info(1:2)
                   move order-alt-key
                     to tpc-trace-info(3:length of order-alt-key)
                   move 6 to tpc-trace-data-length
                   add length of order-alt-key
                     to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   readnext file('ORDALT') into(o-record)
                   ridfld(order-alt-key)
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
           end-perform

           if tpc-trace-reqd
               set trace-vsmords to true
               move x'0A' to tpc-trace-call-seq
               set trace-before-call to true
               set trace-vsm-stop-br to true
               move 'Oa' to tpc-trace-info(1:2)
               move 6 to tpc-trace-data-length
               call 'TPCTRACE' using tpc-trace-data-block
               end-if
           exec cics
               endbr file('ORDALT')
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
               perform CICSError
           end-if

           move try-o-id to o-id
           move try-o-carrier-id to o-carrier-id
           move try-o-entry-d to o-entry-d
           move o-entry-d to entdate

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

           move o-id to ol-o-id
           move d-id to ol-d-id
           move w-id to ol-w-id

           move 0 to i
           move 0 to ol-number
           perform with test after until
                   (response = dfhresp(NOTFND))
                   or
                   (ol-o-id not = o-id or ol-d-id not = d-id
                       or ol-w-id not = w-id)

               add 1 to i
               add 1 to ol-number

               if tpc-trace-reqd
                   set trace-vsmords to true
                   move x'0B' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-read to true
                   move 'Ol' to tpc-trace-info(1:2)
                   move order-line-key
                     to tpc-trace-info(3:length of order-line-key)
                   move 6 to tpc-trace-data-length
                   add length of order-line-key
                     to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   read file('ORDLINE') into(ol-record)
                   ridfld(order-line-key)  equal
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

               if response = dfhresp(NOTFND)
                   continue
               else
                   if response not = dfhresp(NORMAL)
                       perform CICSError
                   else
                       if ol-o-id not = o-id or ol-d-id not = d-id
                               or ol-w-id not = w-id
                           continue
                       else

                           move ol-i-id to itemid(i)
                           move ol-supply-w-id to supware(i)
                           move ol-quantity to qty(i)
                           move ol-amount to amt(i)

                           if ol-delivery-d not = spaces
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

       cust-not-found.
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
      ***  $Workfile:   vsmords.cbl  $ end
      ***--------------------------------------------------------------*
