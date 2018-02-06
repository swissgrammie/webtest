       identification division.

       program-id. tpccbmsm.

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

       environment division.

       configuration section.
LJ     SOURCE-COMPUTER. JVM with debugging mode. | SETS DEBUGGING ON
       special-names.
           class spacedigit is "0" thru "9" space
           class spacedigitdot is "0" thru "9" "." space
LJ    * IMPLEMENTOR clause.
LJ         SYSERR IS OUTERR. | DISPLAY goes to SYSERR

       data division.

       working-storage section.
        COPY DFHAID. 

       01  ws-program-name                   pic x(8) value 'TPCCBMSM'.

      ***--------------------------------------------------------------*
      *** Delivery                                                     *
      ***--------------------------------------------------------------*
       01 filler.
       copy cpydelv.
       copy bmsdelv.
       01  redefines BMSDELVI.
           03                                pic x(12).
           03                                pic x(3).
           03  ws-delv-tran                  pic x(4).
           03                                pic x(3).
           03  ws-delv-wid                   pic x(4).
           03                                pic x(2).
           03  ws-delv-xid-attr              pic x(1).
           03  ws-delv-xid                   pic x(2).
           03                                pic x(3).
           03  ws-delv-exec-status           pic x(45).
           03                                pic x(3).
           03  ws-delv-message               pic x(79).
      ***--------------------------------------------------------------*
      *** Menu                                                         *
      ***--------------------------------------------------------------*
        
       copy BMSMENU.
      ***--------------------------------------------------------------*
      *** New Order                                                    *
      ***--------------------------------------------------------------*
       01 filler.
       copy cpynord.
       copy BMSNORD.
       01  redefines BMSNORDI.
           03                                pic x(12).
           03                                pic x(3).
           03  ws-nord-tran                  pic x(4).
           03                                pic x(3).
           03  ws-nord-wid                   pic x(4).
           03                                pic x(2).
           03  ws-nord-did-attr              pic x(1).
           03  ws-nord-did                   pic x(2).
           03                                pic x(3).
           03  ws-nord-date                  pic x(19).
           03                                pic x(2).
           03  ws-nord-cid-attr              pic x(1).
           03  ws-nord-cid                   pic x(4).
           03                                pic x(3).
           03  ws-nord-last-name             pic x(16).
           03                                pic x(3).
           03  ws-nord-credit                pic x(2).
           03                                pic x(3).
           03  ws-nord-discount              pic x(5).
           03                                pic x(3).
           03  ws-nord-order-id              pic x(8).
           03                                pic x(3).
           03  ws-nord-order-lines           pic x(2).
           03                                pic x(3).
           03  ws-nord-w-tax                 pic x(5).
           03                                pic x(3).
           03  ws-nord-d-tax                 pic x(5).
           03  occurs 15 times.
               05                            pic x(2).
               05  ws-nord-ship-wid-attr     pic x(1).
               05  ws-nord-ship-wid          pic x(4).
               05                            pic x(2).
               05  ws-nord-item-id-attr      pic x(1).
               05  ws-nord-item-id           pic x(6).
               05                            pic x(3).
               05  ws-nord-item-name         pic x(24).
               05                            pic x(2).
               05  ws-nord-qty-attr          pic x(1).
               05  ws-nord-qty               pic x(2).
               05                            pic x(3).
               05  ws-nord-stock             pic x(3).
               05                            pic x(3).
               05  ws-nord-bsg               pic x(1).
               05                            pic x(3).
               05  ws-nord-price             pic x(6).
               05                            pic x(3).
               05  ws-nord-amount            pic x(7).
           03                                pic x(3).
           03  ws-nord-error                 pic x(45).
           03                                pic x(3).
           03  ws-nord-total                 pic x(8).
           03                                pic x(3).
           03  ws-nord-message               pic x(79).
      ***--------------------------------------------------------------*
      *** Order Status                                                 *
      ***--------------------------------------------------------------*
       01 filler.
       copy cpyords.
       copy BMSORDS.
       01  redefines BMSORDSI.
           03                                pic x(12).
           03                                pic x(3).
           03  ws-ords-tran                  pic x(4).
           03                                pic x(3).
           03  ws-ords-wid                   pic x(4).
           03                                pic x(2).
           03  ws-ords-did-attr              pic x(1).
           03  ws-ords-did                   pic x(2).
           03                                pic x(2).
           03  ws-ords-cid-attr              pic x(1).
           03  ws-ords-cid                   pic x(4).
           03                                pic x(3).
           03  ws-ords-first-name            pic x(16).
           03                                pic x(3).
           03  ws-ords-middle-name           pic x(2).
           03                                pic x(2).
           03  ws-ords-last-nm-attr          pic x(1).
           03  ws-ords-last-nm               pic x(16).
           03                                pic x(3).
           03  ws-ords-ballance              pic x(9).
           03                                pic x(3).
           03  ws-ords-oid                   pic x(8).
           03                                pic x(3).
           03  ws-ords-entry-date            pic x(19).
           03                                pic x(3).
           03  ws-ords-carrier-id            pic x(2).
           03  occurs 15 times.
               05                            pic x(3).
               05  ws-ords-s-wid             pic x(4).
               05                            pic x(3).
               05  ws-ords-item-id           pic x(6).
               05                            pic x(3).
               05  ws-ords-quantity          pic x(2).
               05                            pic x(3).
               05  ws-ords-amount            pic x(9).
               05                            pic x(3).
               05  ws-ords-delivery          pic x(10).
           03                                pic x(3).
           03  ws-ords-message               pic x(79).
      ***--------------------------------------------------------------*
      *** Payment                                                      *
      ***--------------------------------------------------------------*
       01 filler.
       copy cpypaym.
       copy BMSPAYM.
       01  redefines BMSPAYMI.
           03                                pic x(12).
           03                                pic x(3).
           03  ws-paym-tran                  pic x(4).
           03                                pic x(3).
           03  ws-paym-date                  pic x(19).
           03                                pic x(3).
           03  ws-paym-wid                   pic x(4).
           03                                pic x(2).
           03  ws-paym-did-attr              pic x(1).
           03  ws-paym-did                   pic x(2).
           03                                pic x(3).
           03  ws-paym-w-street1             pic x(20).
           03                                pic x(3).
           03  ws-paym-d-street1             pic x(20).
           03                                pic x(3).
           03  ws-paym-w-street2             pic x(20).
           03                                pic x(3).
           03  ws-paym-d-street2             pic x(20).
           03                                pic x(3).
           03  ws-paym-w-city                pic x(20).
           03                                pic x(3).
           03  ws-paym-w-state               pic x(2).
           03                                pic x(3).
           03  ws-paym-w-zip                 pic x(9).
           03                                pic x(3).
           03  ws-paym-d-city                pic x(20).
           03                                pic x(3).
           03  ws-paym-d-state               pic x(2).
           03                                pic x(3).
           03  ws-paym-d-zip                 pic x(9).
           03                                pic x(2).
           03  ws-paym-cid-attr              pic x(1).
           03  ws-paym-cid                   pic x(4).
           03                                pic x(2).
           03  ws-paym-c-wid-attr            pic x(1).
           03  ws-paym-c-wid                 pic x(4).
           03                                pic x(2).
           03  ws-paym-c-did-attr            pic x(1).
           03  ws-paym-c-did                 pic x(2).
           03                                pic x(3).
           03  ws-paym-first-name            pic x(16).
           03                                pic x(3).
           03  ws-paym-middle-name           pic x(2).
           03                                pic x(2).
           03  ws-paym-last-nm-attr          pic x(1).
           03  ws-paym-last-nm               pic x(16).
           03                                pic x(3).
           03  ws-paym-c-since               pic x(10).
           03                                pic x(3).
           03  ws-paym-c-street1             pic x(20).
           03                                pic x(3).
           03  ws-paym-c-credit              pic x(2).
           03                                pic x(3).
           03  ws-paym-c-street2             pic x(20).
           03                                pic x(3).
           03  ws-paym-c-discount            pic x(2).
           03                                pic x(3).
           03  ws-paym-c-city                pic x(20).
           03                                pic x(3).
           03  ws-paym-c-state               pic x(2).
           03                                pic x(3).
           03  ws-paym-c-zip                 pic x(9).
           03                                pic x(3).
           03  ws-paym-c-phone               pic x(19).
           03                                pic x(2).
           03  ws-paym-payment-attr          pic x(1).
           03  ws-paym-payment               pic x(7).
           03                                pic x(3).
           03  ws-paym-c-ballance            pic x(14).
           03                                pic x(3).
           03  ws-paym-c-credit-limit        pic x(2).
           03  occurs 4 times.
               05                            pic x(3).
               05  ws-paym-c-data            pic x(50).
           03                                pic x(3).
           03  ws-paym-message               pic x(79).
      ***--------------------------------------------------------------*
      *** Stock Level                                                  *
      ***--------------------------------------------------------------*
       01 filler.
       copy cpystkl.
       copy BMSSTKL.
       01  redefines BMSSTKLI.
           03                                pic x(12).
           03                                pic x(3).
           03  ws-stkl-tran                  pic x(4).
           03                                pic x(3).
           03  ws-stkl-wid                   pic x(4).
           03                                pic x(2).
           03  ws-stkl-did-attr              pic x(1).
           03  ws-stkl-did                   pic x(2).
           03                                pic x(2).
           03  ws-stkl-threshold-attr        pic x(1).
           03  ws-stkl-threshold             pic x(2).
           03                                pic x(3).
           03  ws-stkl-stock-count           pic x(3).
           03                                pic x(3).
           03  ws-stkl-message               pic x(79).
      ***--------------------------------------------------------------*
      *** Working Items                                                *
      ***--------------------------------------------------------------*

       01 filler.

       copy tpccoptn.

       copy tpctopts.

       01  ws-cwa-ptr                        pointer.

       01  ws-end-msg                        pic x(30)
           value '     TPC-C session terminated.'.
       01  ws-work.
           03  ws-x                          pic s9(9)  comp.
           03  ws-z                          pic s9(9)  comp.
           03  ws-result-code                pic s9(9) comp.
           03  ws-numeric                    pic s9(9)  comp.
           03  ws-numeric-disp.
               05 ws-numeric-digit           pic 9 occurs 8 times.
           03  ws-numeric-z9                 pic z9.
           03  ws-attr-askip                 pic x value '0'.
           03  ws-attr-mdt                   pic x value 'A'.
           03  ws-numeric-zzzz9m             pic zzzz9-.

           03  ws-swap-flag                  pic s9(9) comp.
           03  ws-swap-area                  pic x(53).
           03  ws-sub1                       pic 9(2).
           03  ws-sub2                       pic 9(2).
           03  ws-perform-cnt                pic 9(2).

       01  ws-commarea.
           03  ws-map                        pic x(8).
           03  ws-wid                        pic 9(4) blank when zero.
           03  ws-cid                        pic 9(4) blank when zero.
           03  ws-did                        pic 9(2) blank when zero.
           03  ws-xid                        pic 9(2) blank when zero.
           03  ws-wct                        pic 9(2) blank when zero.
           03  ws-dbms                       pic x(1).
               88 ws-use-db-88              value 'D'.
               88 ws-use-vsam-files-88       value 'V'.
           03  ws-siz                        pic x(1).
               88 ws-load-large-88           value 'L'.
               88 ws-load-small-88           value 'S'.
           03  ws-rem                        pic x(1).
               88 ws-load-remove-88          value 'Y'.
           03  ws-lod                        pic x(1).
               88 ws-load-yes-88             value 'Y'.
           03  ws-dbg                        pic x(1).
               88 ws-load-debug-88           value 'Y'.

       01  result-code                       pic s9(5) comp.
       01  m-err                             pic x(80).

       linkage section.
       01  dfhcommarea.
           03                                pic x
               occurs 0 to 32700 times depending on eibcalen.

            copy cicscwa.

      ***--------------------------------------------------------------*
      *** CICS Stuff                                                   *
      ***--------------------------------------------------------------*
       procedure division.
       main-para.
           perform tpcc-mainline
           exec cics return
               transid(eibtrnid)
               commarea(ws-commarea)
           end-exec
           stop run
           .
      ***--------------------------------------------------------------*
       tpcc-mainline section.
       tpcc-mainline-para.
      *     call 'CBL_DEBUGBREAK'
           if eibcalen = length of ws-commarea
               move dfhcommarea to ws-commarea
               perform sql-trace-settings
               if eibaid not = DFHCLEAR  
      *            *> Clear Key
      *             display "CLEAR Key Hit" upon syserr
                   perform cics-receive-map
               end-if
      *         display eibaid upon syserr
               evaluate eibaid
                    
                   when DFHPF12
      *                *> PF 12 Key
      *                 display "PF12 hit" upon syserr
                       exec cics syncpoint end-exec
                       move eibtrnid to ws-end-msg(1:4)
                       exec cics send text | added text
                           from(ws-end-msg)
                           erase
                       end-exec
                       exec cics return end-exec
                   when DFHPF1  
      *                display "PF1 hit"  upon syserr
                       perform cics-send-nord
                   when DFHPF2
      *               display "PF2 hit" upon syserr
                       perform cics-send-paym
                   when DFHPF3
      *                 display "PF3 hit" upon syserr
                       perform cics-send-ords
                   when  DFHPF4
      *                 display "PF4 hit" upon syserr
                       perform cics-send-delv
                   when  DFHPF5
      *                display "PF5 hit" upon syserr
                       perform cics-send-stkl
                   when DFHPF6
      *                 display "PF6 hit" upon syserr
                       exec cics syncpoint end-exec
                       perform cics-send-menu
                   when DFHPF7
      *                 display "PF7 hit" upon syserr
                       if ws-map = 'BMSMENU'
                           perform process-db-load
                       else
                           perform cics-send-menu
                       end-if
                   when dfhenter
      *            *> Enter Key
                       evaluate ws-map
                           when 'BMSDELV'
                               perform process-delivery
                               perform cics-send-delv
                           when 'BMSSTKL'
                               perform process-stock-level
                               perform cics-send-stkl
                           when 'BMSNORD'
                               perform process-new-order
                               perform cics-send-nord
                           when 'BMSPAYM'
                               perform process-payment
                               perform cics-send-paym
                           when 'BMSORDS'
                               perform process-order-status
                               perform cics-send-ords
                           when other
                               perform cics-send-menu
                       end-evaluate
                   when dfhclear
      *            *> Clear Key
                       move 'Display reset by clear key'
                         to DELVMSGO
                       perform cics-send-approprate
                   when other
                       move 'Unexpected 3270 attention key'                       
      *                 move eibaid
                         to DELVMSGO
                       perform cics-send-approprate
               end-evaluate
           else
               perform sql-trace-settings
               move 1 to ws-wid
               move 0 to ws-xid
               move 0 to ws-cid
               move 0 to ws-did
               perform cics-send-menu
           end-if
           exit
           .
      ***--------------------------------------------------------------*
       sql-trace-settings section.
       sql-trace-settings-para.
           move all 'N' to tpc-trace-options-array
           exec cics address cwa(ws-cwa-ptr)
           end-exec
           set address of tpcc-cwa to ws-cwa-ptr
           if tpcc-eyecatcher and
              cwa-tpc-trace-module-name = 'TPCTRACE'
               if trace-sqldelv-cwa-88
                   set trace-sqldelv-88 to true
               end-if
               if trace-vsmdelv-cwa-88
                   set trace-vsmdelv-88 to true
               end-if
               if trace-sqlload-cwa-88
                   set trace-sqlload-88 to true
               end-if
               if trace-vsmload-cwa-88
                   set trace-vsmload-88 to true
               end-if
               if trace-sqlnord-cwa-88
                   set trace-sqlnord-88 to true
               end-if
               if trace-vsmnord-cwa-88
                   set trace-vsmnord-88 to true
               end-if
               if trace-sqlords-cwa-88
                   set trace-sqlords-88 to true
               end-if
               if trace-vsmords-cwa-88
                   set trace-vsmords-88 to true
               end-if
               if trace-sqlpaym-cwa-88
                   set trace-sqlpaym-88 to true
               end-if
               if trace-vsmpaym-cwa-88
                   set trace-vsmpaym-88 to true
               end-if
               if trace-sqlstkl-cwa-88
                   set trace-sqlstkl-88 to true
               end-if
               if trace-vsmstkl-cwa-88
                   set trace-vsmstkl-88 to true
               end-if
           end-if
           .
      ***--------------------------------------------------------------*
       cics-receive-map section.
       cics-receive-map-para.
           evaluate ws-map
               when 'BMSDELV'
                   exec cics receive map(ws-map)
                       into(BMSDELVI)
                       nohandle
                   end-exec
                   if eibresp = dfhresp(normal)
                       if DELVXIDI not = low-values
                           move DELVXIDI to ws-numeric-disp
                           perform edit-to-number
                           move ws-numeric to ws-xid
                       end-if
                   end-if
               when 'BMSMENU'
                   exec cics receive map(ws-map)
                       into(BMSMENUI)
                       nohandle
                   end-exec
                   if eibresp = dfhresp(normal)
                       if MENUWIDI not = low-values
                           move MENUWIDI to ws-numeric-disp
                           perform edit-to-number
                           move ws-numeric to ws-wid
                       end-if
                       if MENUDBMI not = low-values
                           if MENUDBMI = 'd' or 'D'
                               move 'D' to ws-dbms
                           else
                               move 'V' to ws-dbms
                           end-if
                       end-if
                       if MENUWCTI not = low-values
                           move MENUWCTI to ws-numeric-disp
                           perform edit-to-number
                           move ws-numeric to ws-wct
                       end-if
                       if MENUSIZI not = low-values
                           if MENUSIZI = 'l' or 'L'
                               move 'L' to ws-siz
                           else
                               move 'S' to ws-siz
                           end-if
                       end-if
                       if MENUREMI not = low-values
                           if MENUREMI = 'y' or 'Y'
                               move 'Y' to ws-rem
                           else
                               move 'N' to ws-rem
                           end-if
                       end-if
                       if MENULODI not = low-values
                           if MENULODI = 'y' or 'Y'
                               move 'Y' to ws-lod
                           else
                               move 'N' to ws-lod
                           end-if
                       end-if
                       if MENUDBGI not = low-values
                           if MENUDBGI = 'y' or 'Y'
                               move 'Y' to ws-dbg
                           else
                               move 'N' to ws-dbg
                           end-if
                       end-if
                   end-if
               when 'BMSNORD'
                   exec cics receive map(ws-map)
                       into(BMSNORDI)
                       nohandle
                   end-exec
                   if eibresp = dfhresp(normal)
                       if NORDDIDI not = low-values
                           move NORDDIDI to ws-numeric-disp
                           perform edit-to-number
                           move ws-numeric to ws-did
                       end-if
                       if NORDCIDI not = low-values
                           move NORDCIDI to ws-numeric-disp
                           perform edit-to-number
                           move ws-numeric to ws-cid
                       end-if
                   end-if
               when 'BMSORDS'
                   exec cics receive map(ws-map)
                       into(BMSORDSI)
                       nohandle
                   end-exec
                   if eibresp = dfhresp(normal)
                       if ORDSDIDI not = low-values
                           move ORDSDIDI  to ws-numeric-disp
                           perform edit-to-number
                           move ws-numeric to ws-did
                       end-if
                       if ORDSCIDI not = low-values
                           move ORDSCIDI to ws-numeric-disp
                           perform edit-to-number
                           move ws-numeric to ws-cid
                       end-if
                   end-if
               when 'BMSPAYM'
                   exec cics receive map(ws-map)
                       into(BMSPAYMI)
                       nohandle
                   end-exec
                   if eibresp = dfhresp(normal)
                       if PAYMDIDI not = low-values
                           move PAYMDIDI to ws-numeric-disp
                           perform edit-to-number
                           move ws-numeric to ws-did
                       end-if
                       if PAYMCIDI not = low-values
                           move PAYMCIDI to ws-numeric-disp
                           perform edit-to-number
                           move ws-numeric to ws-cid
                       end-if
                   end-if
               when 'BMSSTKL'
                   exec cics receive map(ws-map)
                       into(BMSSTKLI)
                       nohandle
                   end-exec
                   if eibresp = dfhresp(normal)
                       if STKLDIDI not = low-values
                           move STKLDIDI to ws-numeric-disp
                           perform edit-to-number
                           move ws-numeric to ws-did
                       end-if
                   end-if
           end-evaluate
           exit
           .
      ***--------------------------------------------------------------*
       edit-to-number section.
       edit-to-number-para.
           move 0 to ws-numeric
           perform varying ws-z from 1 by 1
               until ws-z > length of ws-numeric-disp
               if ws-numeric-digit(ws-z) is numeric
                   compute ws-numeric
                      = (ws-numeric * 10)
                     + ws-numeric-digit(ws-z)
               end-if
           end-perform
           exit
           .
      ***--------------------------------------------------------------*
       cics-send-approprate section.
       cics-send-approprate-para.
           evaluate ws-map
               when 'BMSDELV'
                   perform cics-send-delv
               when 'BMSNORD'
                   perform cics-send-nord
               when 'BMSORDS'
                   perform cics-send-ords
               when 'BMSPAYM'
                   perform cics-send-paym
               when 'BMSSTKL'
                   perform cics-send-stkl
               when other
                   perform cics-send-menu
           end-evaluate
           exit
           .
      ***--------------------------------------------------------------*
       cics-send-delv section.
       cics-send-delv-para.
           move ws-wid to DELVWIDO
           move ws-xid  to DELVXIDO
           move 'BMSDELV' to ws-map
           exec cics send map(ws-map) from(BMSDELVO) erase end-exec
           exit
           .
      ***--------------------------------------------------------------*
       cics-send-menu section.
       cics-send-menu-para.
           move DELVMSGO to MENUMSGO
           move ws-wid to MENUWIDO

           if ws-dbms not = 'D' and ws-dbms not = 'V'
               move 'D' to ws-dbms
           end-if
           move ws-dbms to MENUDBMO

           if ws-wct(1:) < '01'
               move 1 to ws-wct
           end-if
           if ws-wct > '10'
               move 10 to ws-wct
           end-if
           move ws-wct to MENUWCTO

           if ws-siz not = 'L'
               move 'S' to ws-siz
           end-if
           move ws-siz to MENUSIZO

           if ws-rem not = 'Y'
               move 'N' to ws-rem
           end-if
           move ws-rem to MENUREMO

           if ws-lod not = 'Y'
               move 'N' to ws-lod
           end-if
           move ws-lod to MENULODO

           if ws-dbg not = 'Y'
               move 'N' to ws-dbg
           end-if
           move ws-dbg to MENUDBGO

           move 'BMSMENU' to ws-map

           exec cics send map(ws-map) from(BMSMENUO) erase end-exec
           exit
           .
      ***--------------------------------------------------------------*
       cics-send-nord section.
       cics-send-nord-para.
           move DELVMSGO to NORDMSGO
           move ws-wid to NORDWIDO
           move ws-did to NORDDIDO
           move ws-cid to NORDCIDO
           move 'BMSNORD' to ws-map
           exec cics send map(ws-map) from(BMSNORDO) erase end-exec
           exit
           .
      ***--------------------------------------------------------------*
       cics-send-ords section.
       cics-send-ords-para.
           move DELVMSGO to ORDSMSGO
           move ws-wid to ORDSWIDO
           move ws-did to ORDSDIDO
           move ws-cid to ORDSCIDO
           move 'BMSORDS' to ws-map
           exec cics send map(ws-map) from(BMSORDSO) erase end-exec
           exit
           .
      ***--------------------------------------------------------------*
       cics-send-paym section.
       cics-send-paym-para.
           move DELVMSGO to PAYMMSGO
           move ws-wid to PAYMWIDO
           move ws-did to PAYMDIDO
           move ws-cid to PAYMCIDO
           move 'BMSPAYM' to ws-map
           exec cics send map(ws-map) from(BMSPAYMO) erase end-exec
           exit
           .
      ***--------------------------------------------------------------*
       cics-send-stkl section.
       cics-send-stkl-para.
           move DELVMSGO to STKLMSGO
           move ws-wid to STKLWIDO
           move ws-did to STKLDIDO
           move 'BMSSTKL' to ws-map
           exec cics send map(ws-map) from(BMSSTKLO) erase end-exec
           exit
           .
      ***--------------------------------------------------------------*
      *** Database Load                                                *
      ***--------------------------------------------------------------*
       process-db-load section.
       process-db-load-para.
           move low-values to option-array
           set option-return-display-88 to true
           if ws-load-large-88
               move 1 to option-size
           end-if
           if ws-load-remove-88
               move 0 to option-remove
               move 1 to option-erase
           end-if
           if ws-load-yes-88
               move 0 to option-create
               move 1 to option-load
           end-if
           if ws-load-debug-88
               move 1 to option-debug
           end-if
           move ws-wct to option-count
           evaluate true
               when ws-wct = 0
                   move 'Load: Invalid warehouse count'
                     to DELVMSGO
                   perform cics-send-menu
               when option-erase = 0 and option-load = 0
                   move 'Specify either Load or Erase as Y'
                     to DELVMSGO
                   perform cics-send-menu
               when other
                   move tpc-trace-sqlload
                     to tpc-trace-flag in option-array
                   if ws-use-db-88
                       move tpc-trace-sqlload
                         to tpc-trace-flag in option-array
                       exec cics link
                           program('SQLLOAD')
                           commarea(option-array)
                       end-exec
                       move result-code of option-array
                         to ws-result-code
                   else
                       move tpc-trace-vsmload
                         to tpc-trace-flag in option-array
                       exec cics link
                           program('VSMLOAD')
                           commarea(option-array)
                       end-exec
                       move result-code of option-array
                         to ws-result-code
                   end-if
                   if ws-result-code not = 0
                       move ws-result-code to ws-numeric-zzzz9m
                       string ' RC=' ws-numeric-zzzz9m
                         delimited by size
                         into option-line (24) (71:10)
                       if option-line (24) (1:1) = low-values
                           move spaces to option-line (24) (1:1)
                       end-if
                   end-if
           end-evaluate
           .
       process-db-load-x.
           exit
           .
      ***--------------------------------------------------------------*
      *** Stock Level                                                  *
      ***--------------------------------------------------------------*
       process-stock-level section.
       process-stock-level-para.
           move ws-attr-mdt to ws-stkl-did-attr
           move ws-attr-mdt to ws-stkl-threshold-attr
           initialize stock-level-data
           move ws-wid to wid of stock-level-data
           if ws-wid = 0
               move 'Invalid Warehouse ID' to DELVMSGO
               go to process-stock-level-x
           end-if
           move ws-did to did of stock-level-data
           if ws-did = 0
               move 'Invalid District ID'  to DELVMSGO
               go to process-stock-level-x
           end-if
           if ws-stkl-threshold = low-values
               move 'Stock threshold not entered' to DELVMSGO
               go to process-stock-level-x
           else
               move ws-stkl-threshold to ws-numeric-disp
               perform edit-to-number
               move ws-numeric to threshold of stock-level-data
               if ws-numeric = 0
                   move 'Stock threshold invalid' to DELVMSGO
                   go to process-stock-level-x
               end-if
           end-if
           if ws-use-db-88
               move tpc-trace-sqlstkl
                 to tpc-trace-flag in stock-level-data
               exec cics link
                   program('SQLSTKL')
                   commarea(stock-level-data)
               end-exec
               move result-code in stock-level-data to ws-result-code
           else
               move tpc-trace-vsmstkl
                 to tpc-trace-flag in stock-level-data
               exec cics link
                   program('VSMSTKL')
                   commarea(stock-level-data)
               end-exec
               move result-code in stock-level-data to ws-result-code
           end-if
           move ws-attr-askip to ws-stkl-did-attr
           move ws-attr-askip to ws-stkl-threshold-attr
           move threshold of stock-level-data to ws-stkl-threshold
           move stockcount of stock-level-data to ws-stkl-stock-count
           move err of stock-level-data to DELVMSGO
           if ws-result-code not = 0
               move ws-result-code to ws-numeric-zzzz9m
               string ws-numeric-zzzz9m
                 delimited by size
                 into DELVMSGO(74:6)
           end-if
           .
       process-stock-level-x.
           exit
           .
      ***--------------------------------------------------------------*
      *** Delivery                                                     *
      ***--------------------------------------------------------------*
       process-delivery section.
       process-delivery-para.
           move ws-attr-mdt to ws-delv-xid-attr
           initialize delivery-data
           move ws-wid to wid of delivery-data
           if ws-wid = 0
               move 'Invalid Warehouse ID' to DELVMSGO
               go to process-delivery-x
           end-if
           move ws-xid to ocarrierid of delivery-data
           if ws-xid = 0
               move 'Invalid Carrier Number' to DELVMSGO
               go to process-delivery-x
           end-if
           if ws-use-db-88
               move tpc-trace-sqldelv
                 to tpc-trace-flag in delivery-data
               exec cics link
                   program('SQLDELV')
                   commarea(delivery-data)
               end-exec
               move result-code in delivery-data to ws-result-code
           else
               move tpc-trace-vsmdelv
                 to tpc-trace-flag in delivery-data
               exec cics link
                   program('VSMDELV')
                   commarea(delivery-data)
               end-exec
               move result-code in delivery-data to ws-result-code
           end-if
           move ws-attr-askip to ws-delv-xid-attr
           move wid of delivery-data to ws-delv-wid
           move ocarrierid of delivery-data to ws-delv-xid
           move msg of delivery-data to ws-delv-exec-status
           move err of delivery-data to DELVMSGO
           if ws-result-code not = 0
               move ws-result-code to ws-numeric-zzzz9m
               string ws-numeric-zzzz9m
                 delimited by size
                 into DELVMSGO(74:6)
           end-if
           .
       process-delivery-x.
           exit
           .
      ***--------------------------------------------------------------*
      *** Order Status                                                 *
      ***--------------------------------------------------------------*
       process-order-status section.
       process-order-status-para.
           move ws-attr-mdt to ws-ords-did-attr
           move ws-attr-mdt to ws-ords-cid-attr
           move ws-attr-mdt to ws-ords-last-nm-attr
           initialize order-status-data
           move ws-wid to wid of order-status-data
           if ws-wid = 0
               move 'Invalid Warehouse ID' to DELVMSGO
               go to process-order-status-x
           end-if
           move ws-did to did of order-status-data
           if ws-did = 0
               move 'Invalid District ID' to DELVMSGO
               go to process-order-status-x
           end-if
           move ws-cid to cid of order-status-data
           if ws-cid = 0
               move 'Invalid Customer ID' to DELVMSGO
               go to process-order-status-x
           end-if
           if ws-ords-last-nm = low-values
               move spaces to clast of order-status-data
           else
               move ws-ords-last-nm to clast of order-status-data
           end-if
           if ws-use-db-88
               move tpc-trace-sqlords
                 to tpc-trace-flag in order-status-data
               exec cics link
                   program('SQLORDS')
                   commarea(order-status-data)
               end-exec
               move result-code in order-status-data to ws-result-code
           else
               move tpc-trace-vsmords
                 to tpc-trace-flag in order-status-data
               exec cics link
                   program('VSMORDS')
                   commarea(order-status-data)
               end-exec
               move result-code in order-status-data to ws-result-code
           end-if
           move ws-attr-askip to ws-ords-did-attr
           move ws-attr-askip to ws-ords-cid-attr
           move ws-attr-askip to ws-ords-last-nm-attr

           move cid of order-status-data to ws-cid
           move cfirst of order-status-data to ws-ords-first-name
           move cmiddle of order-status-data to ws-ords-middle-name
           move clast of order-status-data to ws-ords-last-nm
           move cbalance of order-status-data to ws-ords-ballance
           move oid of order-status-data to ws-ords-oid
           move oentryd of order-status-data to ws-ords-entry-date
           move ocarrierid of order-status-data to ws-ords-carrier-id
           perform varying ws-x from 1 by 1 until ws-x > 15
             or supware of order-status-data (ws-x) = 0
               move supware of order-status-data (ws-x)
                 to ws-ords-s-wid (ws-x)
               move itemid of order-status-data (ws-x)
                 to ws-ords-item-id (ws-x)
               move qty of order-status-data (ws-x)
                 to ws-ords-quantity (ws-x)
               move amt of order-status-data (ws-x)
                 to ws-ords-amount (ws-x)
               move deldate of order-status-data (ws-x)
                 to ws-ords-delivery (ws-x)
           end-perform
           move err of order-status-data to DELVMSGO
           if ws-result-code not = 0
               move ws-result-code to ws-numeric-zzzz9m
               string ws-numeric-zzzz9m
                 delimited by size
                 into DELVMSGO(74:6)
           end-if
           .
       process-order-status-x.
           exit
           .
      ***--------------------------------------------------------------*
      *** Payment                                                      *
      ***--------------------------------------------------------------*
       process-payment section.
       process-payment-para.
           move ws-attr-mdt to ws-paym-did-attr
           move ws-attr-mdt to ws-paym-cid-attr
           move ws-attr-mdt to ws-paym-c-wid-attr
           move ws-attr-mdt to ws-paym-c-did-attr
           move ws-attr-mdt to ws-paym-last-nm-attr
           move ws-attr-mdt to ws-paym-payment-attr
           initialize payment-data
           move ws-wid to wid of payment-data
           if ws-wid = 0
               move 'Invalid Warehouse ID' to DELVMSGO
               go to process-payment-x
           end-if
           move ws-did to did of payment-data
           if ws-did = 0
               move 'Invalid District ID' to DELVMSGO
               go to process-payment-x
           end-if
           move ws-cid to cid of payment-data
           if ws-cid = 0
               move 'Invalid Customer ID' to DELVMSGO
               go to process-payment-x
           end-if
           if ws-paym-c-wid = low-values
               move 'Customer Warehouse ID not entered' to DELVMSGO
               go to process-payment-x
           else
               move ws-paym-c-wid to ws-numeric-disp
               perform edit-to-number
               move ws-numeric to cwid of payment-data
               if ws-numeric = 0
                   move 'Customer Warehouse ID invalid' to DELVMSGO
                   go to process-payment-x
               end-if
           end-if
           if ws-paym-c-did = low-values
               move 'Customer District ID not entered' to DELVMSGO
               go to process-payment-x
           else
               move ws-paym-c-did to ws-numeric-disp
               perform edit-to-number
               move ws-numeric to cdid of payment-data
               if ws-numeric = 0
                   move 'Customer district ID invalid' to DELVMSGO
                   go to process-payment-x
               end-if
           end-if
           if ws-paym-payment = low-values
               move 'Payment amount not entered' to DELVMSGO
               go to process-payment-x
           else
               move ws-paym-payment to ws-numeric-disp
               perform edit-to-number
               move ws-numeric to hamount of payment-data
               if ws-numeric = 0
                   move 'Payment amount invalid' to DELVMSGO
                   go to process-payment-x
               end-if
           end-if
           if ws-paym-last-nm = low-values
               move spaces to clast of payment-data
           else
               move ws-paym-last-nm to clast of payment-data
           end-if
           if ws-use-db-88
               move tpc-trace-sqlpaym
                 to tpc-trace-flag in payment-data
               exec cics link
                   program('SQLPAYM')
                   commarea(payment-data)
               end-exec
               move result-code in payment-data to ws-result-code
           else
               move tpc-trace-vsmpaym
                 to tpc-trace-flag in payment-data
               exec cics link
                   program('VSMPAYM')
                   commarea(payment-data)
               end-exec
               move result-code in payment-data to ws-result-code
           end-if
           move ws-attr-askip to ws-paym-did-attr
           move ws-attr-askip to ws-paym-cid-attr
           move ws-attr-askip to ws-paym-c-wid-attr
           move ws-attr-askip to ws-paym-c-did-attr
           move ws-attr-askip to ws-paym-last-nm-attr
           move ws-attr-askip to ws-paym-payment-attr
           move hdate of payment-data to ws-paym-date
           move wid of payment-data to ws-wid
           move did of payment-data to ws-did
           move cid of payment-data to ws-cid
           move cwid of payment-data to ws-paym-c-wid
           move cdid of payment-data to ws-paym-c-did
           move wstreet1 of payment-data to ws-paym-w-street1
           move wstreet2 of payment-data to ws-paym-w-street2
           move wcity of payment-data to ws-paym-w-city
           move wstate of payment-data to ws-paym-w-state
           move wzip of payment-data to ws-paym-d-zip
           move dstreet1 of payment-data to ws-paym-d-street1
           move dstreet2 of payment-data to ws-paym-d-street2
           move dcity of payment-data to ws-paym-d-city
           move dstate of payment-data to ws-paym-d-state
           move dzip of payment-data  to ws-paym-d-zip
           move cfirst of payment-data to ws-paym-first-name
           move cmiddle of payment-data to ws-paym-middle-name
           move clast of payment-data to ws-paym-last-nm
           move cstreet1 of payment-data to ws-paym-c-street1
           move cstreet2 of payment-data to ws-paym-c-street2
           move ccity of payment-data to ws-paym-c-city
           move cstate of payment-data to ws-paym-c-state
           move czip of payment-data to ws-paym-c-zip
           move cphone of payment-data to ws-paym-c-phone
           move csince of payment-data to ws-paym-c-since
           move ccredit of payment-data to ws-paym-c-credit
           move ccreditlim of payment-data to ws-paym-c-credit-limit
           move cdiscount of payment-data to ws-paym-c-discount
           move cbalance of payment-data to ws-paym-c-ballance
           perform varying ws-x from 1 by 1 until ws-x > 4
               move cdataline of payment-data (ws-x)
                 to ws-paym-c-data (ws-x)
           end-perform
           move hamount of payment-data to ws-paym-payment
           move err of payment-data to DELVMSGO
           if ws-result-code not = 0
               move ws-result-code to ws-numeric-zzzz9m
               string ws-numeric-zzzz9m
                 delimited by size
                 into DELVMSGO(74:6)
           end-if
           .
       process-payment-x.
           exit
           .
      ***--------------------------------------------------------------*
      *** New Order                                                    *
      ***--------------------------------------------------------------*
       process-new-order section.
       process-new-order-para.
           move ws-attr-mdt to ws-nord-did-attr
           move ws-attr-mdt to ws-nord-cid-attr
           perform varying ws-x from 1 by 1 until ws-x > 15
               move ws-attr-mdt to ws-nord-ship-wid-attr (ws-x)
               move ws-attr-mdt to ws-nord-item-id-attr (ws-x)
               move ws-attr-mdt to ws-nord-qty-attr (ws-x)
           end-perform
           initialize new-order-data
           if ws-wid = 0
               move 'Invalid Warehouse ID' to DELVMSGO
               go to process-new-order-x
           end-if
           move ws-wid to wid of new-order-data
           if ws-did = 0
               move 'Invalid District ID' to DELVMSGO
               go to process-new-order-x
           end-if
           move ws-did to did of new-order-data
           if ws-cid = 0
               move 'Invalid Customer ID' to DELVMSGO
               go to process-new-order-x
           end-if
           move ws-cid to cid of new-order-data
           move spaces to DELVMSGO
           perform varying ws-x from 1 by 1 until ws-x > 15
                   or ws-nord-ship-wid(ws-x) = low-values
               move ws-x to olno (ws-x)
               move ws-x to ws-numeric-z9
               move ws-nord-ship-wid(ws-x) to ws-numeric-disp
               perform edit-to-number
               move ws-numeric to supware of new-order-data(ws-x)
               if ws-numeric = 0
                   string 'Invalid ship warehouse ID on line '
                          ws-numeric-z9 delimited by size
                          into DELVMSGO
                   go to process-new-order-x
               end-if
               move ws-nord-item-id (ws-x) to ws-numeric-disp
               perform edit-to-number
               move ws-numeric to itemid of new-order-data(ws-x)
               if ws-numeric = 0
                   string 'Invalid item ID on line '
                          ws-numeric-z9 delimited by size
                          into DELVMSGO
                   go to process-new-order-x
               end-if
               move ws-nord-qty (ws-x) to ws-numeric-disp
               perform edit-to-number
               move ws-numeric to qty of new-order-data(ws-x)
               if ws-numeric = 0
                   string 'Invalid quantity on line '
                          ws-numeric-z9 delimited by size
                          into DELVMSGO
                   go to process-new-order-x
               end-if
           end-perform

           if ws-x = 1
               move 'No valid items entered' to DELVMSGO
               go to process-new-order-x
           end-if

      * Sort into key oder to avoild deadly embrace situations
           move 1 to ws-swap-flag
           perform until ws-swap-flag = 0
               move 0 to ws-sub1
               move 0 to ws-swap-flag
               perform varying ws-perform-cnt
                 from 1 by 1 until ws-perform-cnt > 14
                  add 1 to ws-sub1
                  add 1 to ws-sub1 giving ws-sub2
                  if no-item-key (ws-sub1) = zeros
                     move 15 to ws-perform-cnt
                  else
                     if no-item-key (ws-sub2) < no-item-key (ws-sub1)
                          and no-item-key (ws-sub2) not = zeros
                        move no-item-data (ws-sub1) to ws-swap-area
                        move no-item-data (ws-sub2)
                          to no-item-data (ws-sub1)
                        move ws-swap-area to no-item-data (ws-sub2)
                        add 1 to ws-swap-flag
                     end-if
                  end-if
               end-perform
           end-perform

           if ws-use-db-88
               move tpc-trace-sqlnord
                 to tpc-trace-flag in new-order-data
               exec cics link
                   program('SQLNORD')
                   commarea(new-order-data)
               end-exec
               move result-code in new-order-data to ws-result-code
           else
               move tpc-trace-vsmnord
                 to tpc-trace-flag in new-order-data
               exec cics link
                   program('VSMNORD')
                   commarea(new-order-data)
               end-exec
               move result-code in new-order-data to ws-result-code
           end-if

      * Put data back into original (olno) order
           move 1 to ws-swap-flag
           perform until ws-swap-flag = 0
               move 0 to ws-sub1
               move 0 to ws-swap-flag
               perform varying ws-perform-cnt
                 from 1 by 1 until ws-perform-cnt > 14
                  add 1 to ws-sub1
                  add 1 to ws-sub1 giving ws-sub2
                  if olno (ws-sub1) = zeros
                     move 15 to ws-perform-cnt
                  else
                     if olno (ws-sub2) < olno (ws-sub1)
                          and  no-item-key (ws-sub2) not = zeros
                        move no-item-data (ws-sub1) to ws-swap-area
                        move no-item-data (ws-sub2)
                          to no-item-data (ws-sub1)
                        move ws-swap-area to no-item-data (ws-sub2)
                        add 1 to ws-swap-flag
                     end-if
                  end-if
               end-perform
           end-perform

           move ws-attr-askip to ws-nord-did-attr
           move ws-attr-askip to ws-nord-cid-attr
           perform varying ws-x from 1 by 1 until ws-x > 15
               move ws-attr-askip to ws-nord-ship-wid-attr (ws-x)
               move ws-attr-askip to ws-nord-item-id-attr (ws-x)
               move ws-attr-askip to ws-nord-qty-attr (ws-x)
               move low-values to ws-nord-ship-wid (ws-x)
               move low-values to ws-nord-item-id (ws-x)
               move low-values to ws-nord-qty (ws-x)
           end-perform
           move wid of new-order-data to ws-wid
           move did of new-order-data to ws-did
           move cid of new-order-data to ws-cid
           move clast of new-order-data to ws-nord-last-name
           move ccredit of new-order-data to ws-nord-credit
           move cdiscount of new-order-data to ws-nord-discount
           move wtax of new-order-data to ws-nord-w-tax
           move dtax of new-order-data to ws-nord-d-tax
           move oolcnt of new-order-data to ws-nord-order-lines
           move oid of new-order-data to ws-nord-order-id
           move oentrydt of new-order-data to ws-nord-date
           perform varying ws-x from 1 by 1 until ws-x > 15
                   or ws-x > oolcnt of new-order-data
               if supware of new-order-data(ws-x) not = 0
                   move supware of new-order-data(ws-x)
                     to ws-nord-ship-wid (ws-x)
                   move itemid of new-order-data(ws-x)
                     to ws-nord-item-id (ws-x)
                   move iname of new-order-data(ws-x)
                     to ws-nord-item-name (ws-x)
                   move qty of new-order-data(ws-x)
                     to ws-nord-qty (ws-x)
                   move stock of new-order-data(ws-x)
                     to ws-nord-stock (ws-x)
                   move bg of new-order-data(ws-x)
                     to ws-nord-bsg (ws-x)
                   move price of new-order-data(ws-x)
                     to ws-nord-price (ws-x)
                   move amt of new-order-data(ws-x)
                     to ws-nord-amount (ws-x)
               end-if
           end-perform
           move total of new-order-data to ws-nord-total
           move err of new-order-data to ws-nord-error
           move err of new-order-data to ws-nord-message
           move msg of new-order-data to ws-nord-error
           if ws-result-code not = 0
               move err of new-order-data to DELVMSGO
           end-if
           exit
           .
       process-new-order-x.
           .
      ***--------------------------------------------------------------*
      ***  $Workfile:   tpccbmsm.cbl  $ end
      ***--------------------------------------------------------------*
