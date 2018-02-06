       identification division.

       program-id. vsmdelv.

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
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
LJ     SOURCE-COMPUTER. JVM with debugging mode. | SETS DEBUGGING ON
       SPECIAL-NAMES.
LJ    * IMPLEMENTOR clause.
LJ     SYSERR IS OUTERR. | DISPLAY goes to SYSERR
LJ    * SYSOUT IS OUTERR.
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  ws-program-name                   pic x(8) value 'VSMDELV '.

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

       01  tpcc-log-rec                      pic x(80).

       01  log-rba                           pic s9(9) comp.

       01  dist-per-ware                     pic 9(2) value 10.

       01  ol-total                          pic s9(10)v99 comp-3.

       01  did                               pic 9(2).
       01  oid                               pic 9(9).

       copy cicserrd.

       copy tpctdata.

       LINKAGE SECTION.

       01 DFHCOMMAREA.

       copy cpydelv.

       PROCEDURE DIVISION.
       MAIN SECTION.
       main-para.
           move "YYYY-MM-DD-HH.MM.SS" to datetime

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
           move spaces to TPCC-LOG-REC
           string
               "W: " delimited size
               wid delimited size
               " CARRIER: " delimited size
               ocarrierid delimited size
           into TPCC-LOG-REC

      *    if tpc-trace-reqd
      *        set trace-vsmdelv to true
      *        move x'01' to tpc-trace-call-seq
      *        set trace-before-call to true
      *        set trace-vsm-write to true
      *        move 'Dg' to tpc-trace-info(1:2)
      *        move warehouse-key
      *          to tpc-trace-info(3:length of warehouse-key)
      *        move 6 to tpc-trace-data-length
      *        add length of warehouse-key to tpc-trace-data-length
      *        call 'TPCTRACE' using tpc-trace-data-block
      *    end-if
gg    *    exec cics
gg    *        write file('DELVLOG') from(tpcc-log-rec)
gg    *        ridfld(log-rba) rba
gg    *        resp(response)
gg    *    end-exec
      *    if tpc-trace-reqd
      *        set trace-vsmdelv to true
      *        move x'01' to tpc-trace-call-seq
      *        set trace-after-call to true
      *        move low-values to tpc-trace-data
      *        move 0 to tpc-trace-data-length
      *        call 'TPCTRACE' using tpc-trace-data-block
      *    end-if

gg    *
gg    *    if response not = dfhresp(NORMAL)
gg    *        perform CICSError
gg    *    end-if

           perform varying d-id from 1 by 1 until d-id > DIST-PER-WARE

               move d-id to did
               move d-id to no-d-id
               move w-id to no-w-id
               move 0 to no-o-id

               if tpc-trace-reqd
                   set trace-vsmdelv to true
                   move x'02' to tpc-trace-call-seq
                   set trace-before-call to true
                   set trace-vsm-start-br to true
                   move 'No' to tpc-trace-info(1:2)
                   move new-order-key
                     to tpc-trace-info(3:length of new-order-key)
                   move 6 to tpc-trace-data-length
                   add length of new-order-key to tpc-trace-data-length
                   call 'TPCTRACE' using tpc-trace-data-block
               end-if
               exec cics
                   startbr file('NEWORD')
                   ridfld(new-order-key)
                   gteq
                   resp(response)
               end-exec
               if tpc-trace-reqd
                   set trace-vsmdelv to true
                   move x'02' to tpc-trace-call-seq
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
                       set trace-vsmdelv to true
                       move x'03' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-vsm-read-next to true
                       move 'No' to tpc-trace-info(1:2)
                       move new-order-key
                         to tpc-trace-info(3:length of new-order-key)
                       move 6 to tpc-trace-data-length
                       add length of new-order-key
                         to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   exec cics
                       readnext file('NEWORD') into(no-record)
                       ridfld(new-order-key)
                       resp(response)
                   end-exec
               end-if
                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'03' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

               if response = dfhresp(NOTFND) or
                   (response = dfhresp(NORMAL)
                       and (no-d-id not = d-id
                                           or no-w-id not = w-id))
      *            *> no find
                   move spaces to TPCC-LOG-REC
                   string
                       "D: "             delimited by size
                       did               delimited by size
                       " no delivery"    delimited by size
                   into TPCC-LOG-REC
      *            if tpc-trace-reqd
      *                set trace-vsmdelv to true
      *                move x'04' to tpc-trace-call-seq
      *                set trace-before-call to true
      *                set trace-vsm-write to true
      *                move 'Dg' to tpc-trace-info(1:2)
      *                move new-order-key
      *                  to tpc-trace-info(3:length of new-order-key)
      *                move 6 to tpc-trace-data-length
      *                add length of new-order-key
      *                  to tpc-trace-data-length
      *                call 'TPCTRACE' using tpc-trace-data-block
      *            end-if
gg    **gg          exec cics
gg    **gg            write file('DELVLOG') from(tpcc-log-rec)
gg    **gg             ridfld(log-rba) rba
gg    **gg             resp(response)
gg    **gg         end-exec
      *            if tpc-trace-reqd
      *                set trace-vsmdelv to true
      *                move x'04' to tpc-trace-call-seq
      *                set trace-after-call to true
      *                move low-values to tpc-trace-data
      *                move 0 to tpc-trace-data-length
      *                call 'TPCTRACE' using tpc-trace-data-block
      *            end-if
gg    **gg
gg    **gg         if response not = dfhresp(NORMAL)
gg    **gg             perform CICSError
gg    **gg         end-if

                   move 1 to return-code

                   exec cics
                       syncpoint
                       resp(response)
                   end-exec

                   if response not = dfhresp(NORMAL)
                       perform CICSError
                   end-if
               else
                   if response not = dfhresp(normal)
                       perform CICSError
                   end-if

                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'05' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-vsm-stop-br to true
                       move 'No' to tpc-trace-info(1:2)
                       move 6 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   exec cics
                       endbr file('NEWORD')
                       resp(response)
                   end-exec
                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'05' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if response not = dfhresp(NORMAL)
                       perform CICSError
                   end-if

                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'06' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-vsm-read-update to true
                       move 'No' to tpc-trace-info(1:2)
                       move new-order-key
                         to tpc-trace-info(3:length of new-order-key)
                       move 6 to tpc-trace-data-length
                       add length of new-order-key
                         to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   exec cics
                       read file('NEWORD') into(no-record)
                       ridfld(new-order-key)
                       update
                       resp(response)
                   end-exec
                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'06' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if response not = dfhresp(NORMAL)
                       perform CICSError
                   end-if

                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'07' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-vsm-delete to true
                       move 'No' to tpc-trace-info(1:2)
                       move new-order-key
                         to tpc-trace-info(3:length of new-order-key)
                       move 6 to tpc-trace-data-length
                       add length of new-order-key
                         to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   exec cics
                       delete file('NEWORD')
                       resp(response)
                   end-exec
                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'07' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if response not = dfhresp(NORMAL)
                       perform CICSError
                   end-if

                   move no-o-id to o-id
                   move d-id to o-d-id
                   move w-id to o-w-id
                   move o-id to o-id

                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'08' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-vsm-read-update to true
                       move 'Or' to tpc-trace-info(1:2)
                       move order-key
                         to tpc-trace-info(3:length of order-key)
                       move 6 to tpc-trace-data-length
                       add length of order-key
                         to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   exec cics
                       read file('ORD') into(o-record)
                       ridfld(order-key)
                       update
                       resp(response)
                   end-exec
                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'08' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if response not = dfhresp(NORMAL)
                       perform CICSError
                   end-if

                   move o-c-id to c-id

                   move ocarrierid to o-carrier-id

                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'09' to tpc-trace-call-seq
                       set trace-before-call to true
                       set trace-vsm-rewrite to true
                       move 'Or' to tpc-trace-info(1:2)
                       move order-key
                         to tpc-trace-info(3:length of order-key)
                       move 6 to tpc-trace-data-length
                       add length of order-key
                         to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if
                   exec cics
                       rewrite file('ORD') from(o-record)
                       resp(response)
                   end-exec
                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'09' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if response not = dfhresp(NORMAL)
                       perform CICSError
                   end-if

                   move no-o-id to ol-o-id
                   move d-id to ol-d-id
                   move w-id to ol-w-id
                   move 0 to ol-total

                   move 0 to ol-number
                   perform  with test after until
                           (response = dfhresp(NOTFND))
                           or
                           (ol-d-id not = d-id
                                   or ol-w-id not = w-id
                                   or ol-o-id not = no-o-id)

      *                step through order lines until we get a no find
      *                we can't use a browse here because we need to
      *                update each order line, but we can
      *                predict the key sequence
                       add 1 to ol-number
                       if tpc-trace-reqd
                           set trace-vsmdelv to true
                           move x'0A' to tpc-trace-call-seq
                           set trace-before-call to true
                           set trace-vsm-read-update to true
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
                           ridfld(order-line-key) equal
                           update
                           resp(response)
                       end-exec
                       if tpc-trace-reqd
                           set trace-vsmdelv to true
                           move x'0A' to tpc-trace-call-seq
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
                           end-if
                           add ol-amount to ol-total
                           move datetime to ol-delivery-d
                           if tpc-trace-reqd
                               set trace-vsmdelv to true
                               move x'0B' to tpc-trace-call-seq
                               set trace-before-call to true
                               set trace-vsm-rewrite to true
                                   move 'Ol' to tpc-trace-info(1:2)
                               move order-line-key
                           to tpc-trace-info(3:length of order-line-key)
                               move 6 to tpc-trace-data-length
                               add length of order-line-key
                                 to tpc-trace-data-length
                              call 'TPCTRACE' using tpc-trace-data-block
                           end-if
                           exec cics
                               rewrite file('ORDLINE')
                               from(ol-record)
                               resp(response)
                           end-exec
                           if tpc-trace-reqd
                               set trace-vsmdelv to true
                               move x'0B' to tpc-trace-call-seq
                               set trace-after-call to true
                               move low-values to tpc-trace-data
                               move 0 to tpc-trace-data-length
                              call 'TPCTRACE' using tpc-trace-data-block
                           end-if

                           if response not = dfhresp(NORMAL)
                               perform CICSError
                           end-if
                       end-if
                   end-perform

                   move d-id to c-d-id
                   move w-id to c-w-id

                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'0C' to tpc-trace-call-seq
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
                       set trace-vsmdelv to true
                       move x'0C' to tpc-trace-call-seq
                       set trace-after-call to true
                       move low-values to tpc-trace-data
                       move 0 to tpc-trace-data-length
                       call 'TPCTRACE' using tpc-trace-data-block
                   end-if

                   if response not = dfhresp(NORMAL)
                       perform CICSError
                   end-if

                   add ol-total to c-balance

                   if tpc-trace-reqd
                       set trace-vsmdelv to true
                       move x'0D' to tpc-trace-call-seq
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
                       set trace-vsmdelv to true
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

                   move d-id to did
                   move no-o-id to oid

                   move spaces to TPCC-LOG-REC
                   string
                       "D: "         delimited by size
                       did           delimited by size
                       ", O: "       delimited by size
                       oid           delimited by size
                       ", time: "    delimited by size
                       datetime      delimited by size
                   into TPCC-LOG-REC
      *            if tpc-trace-reqd
      *                set trace-vsmdelv to true
      *                move x'0E' to tpc-trace-call-seq
      *                set trace-before-call to true
      *                set trace-vsm-read-update to true
      *                move 'Dg' to tpc-trace-info(1:2)
      *                move customer-key
      *                  to tpc-trace-info(3:length of customer-key)
      *                move 6 to tpc-trace-data-length
      *                add length of customer-key
      *                  to tpc-trace-data-length
      *                call 'TPCTRACE' using tpc-trace-data-block
      *            end-if
      *
      **gg         write TPCC-LOG-REC
gg    **gg         exec cics
gg    **gg             write file('DELVLOG') from(tpcc-log-rec)
gg    **gg             ridfld(log-rba) rba
gg    **gg             resp(response)
gg    **gg         end-exec
      *            if tpc-trace-reqd
      *                set trace-vsmdelv to true
      *                move x'0E' to tpc-trace-call-seq
      *                set trace-after-call to true
      *                move low-values to tpc-trace-data
      *                move 0 to tpc-trace-data-length
      *                call 'TPCTRACE' using tpc-trace-data-block
      *            end-if
gg    **gg
gg    **gg         if response not = dfhresp(NORMAL)
gg    **gg             perform CICSError
gg    **gg        end-if

               end-if
           end-perform

           exec cics
               syncpoint
               resp(response)
           end-exec

           if response not = dfhresp(NORMAL)
               perform CICSError
           end-if

           move "Delivery processing compete" to msg

           exec cics return end-exec.

       CICSError section.

       copy CICSERR.

           exec cics syncpoint rollback end-exec

           exec cics return end-exec.
           .


