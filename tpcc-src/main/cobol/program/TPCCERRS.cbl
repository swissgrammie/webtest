       identification division.

       program-id. tpccerrs.

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

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
LJ     SOURCE-COMPUTER. JVM with debugging mode. | SETS DEBUGGING ON
       SPECIAL-NAMES.
LJ    * IMPLEMENTOR clause.
LJ     SYSERR IS OUTERR. | DISPLAY goes to SYSERR
LJ    * SYSOUT IS OUTERR.
       data division.
       working-storage section.

       01  ws-length                         pic s9(4) comp.
       01  ws-flength                        pic S9(9) comp.
       01  ws-x                              pic S9(4) comp.
       01  ws-count                          pic S9(9) comp value 0.
       01  ws-entries                        pic S9(9) comp value 0.
       01  ws-td-q-name                      pic x(4) value 'TPCC'.
       01  ws-ts-q-name                      pic x(8) value 'TPCC'.
       01  ws-resp-readq-td                  pic s9(8) comp.
       01  ws-resp-writeq-ts                 pic s9(8) comp.
       01  ws-message-table.
           03  ws-entry                      occurs 100 times.
               05  ws-entry-text             pic x(120).
               05  ws-entry-repeats          pic 9(3).
       01  ws-current-text                   pic x(120).
       01  ws-current-repeats                pic 9(3).
       01  ws-write-msg.
           03  ws-write-msg-pt1.
               05  ws-write-msg-pt1a         pic x(4).
               05  ws-write-msg-pt1b         pic x(74).
           03  ws-write-msg-pt2.
               05  ws-write-msg-pt2a         pic x(4).
               05  ws-write-msg-pt2b         pic x(74).
       01  ws-repeat-message.
           03  filler                        pic x(20)
               value '     ***** repeated '.
           03  ws-repeat-message-count       pic zz9.
           03  filler                        pic x(12)
               value ' times *****'.
       01  ws-message.
           03  ws-message-tranid             pic x(4).
           03  filler                        pic x(11)
               value ' processed '.
           03  ws-message-count              pic z(2)9.
           03  filler                        pic x(10)
               value ' messages.'.

       linkage section.
       01  lk-text.
           03  pic x occurs 0 to 512 times depending on ws-length.

       procedure division.
       main-para.
           move spaces to ws-message-table
           move 0 to ws-count
      *
      * ElasticCOBOL warning message below "subscripts of reference 
      * modification ignored" should be investigated. change to simply 
      * move the constant 100.
           divide length of ws-entry (1) into length of ws-message-table
             giving ws-entries
           move 100 to ws-entries.
           perform until ws-resp-readq-td not = DFHRESP(NORMAL)
               exec cics readq td
                   queue(ws-td-q-name)
                   set(address of lk-text)
                   length(ws-length)
                   resp(ws-resp-readq-td)
               end-exec
               if ws-resp-readq-td = DFHRESP(NORMAL)
                   add 1 to ws-count
                   perform varying ws-x
                    from 1 by 1 until ws-x > ws-entries
                       if ws-entry-text(ws-x) not = lk-text(1:120)
                           if ws-entry(ws-x) = spaces
                               move lk-text(1:120)
                                           to ws-entry-text(ws-x)
                               move 0 to ws-entry-repeats(ws-x)
                               add 1 to ws-entries giving ws-x
                           end-if
                       else
                           add 1 to ws-entry-repeats(ws-x)
                           add 1 to ws-entries giving ws-x
                       end-if
                   end-perform
               end-if
           end-perform

           if ws-count < 5
               move 0 to ws-flength
           end-if


           perform varying ws-x
            from 1 by 1 until ws-x > ws-entries
               if ws-entry-text(ws-x) = space
                   add 1 to ws-entries giving ws-x
               else
                   move ws-entry-text(ws-x) to ws-current-text
                   move ws-entry-repeats(ws-x) to ws-current-repeats
                   move spaces to ws-write-msg
                   move ws-current-text(1:74) to ws-write-msg-pt1b
                   move ws-current-text(75:46) to ws-write-msg-pt2b
                   if ws-write-msg-pt2b = spaces
                      move '1/1' to ws-write-msg-pt1a
                   else
                      move '1/2' to ws-write-msg-pt1a
                      move '2/2' to ws-write-msg-pt2a
                   end-if
                   exec cics write operator
                       text(ws-write-msg-pt1)
                       textlength(length of ws-write-msg-pt1)
                   end-exec
                   exec cics writeq ts
                       queue(ws-ts-q-name)
                       from(ws-write-msg-pt1)
                       length(length of ws-write-msg-pt1)
                       resp(ws-resp-writeq-ts)
                   end-exec
                   if ws-write-msg-pt2b not = spaces
                       exec cics write operator
                           text(ws-write-msg-pt2)
                           textlength(length of ws-write-msg-pt2)
                       end-exec
                       exec cics writeq ts
                           queue(ws-ts-q-name)
                           from(ws-write-msg-pt2)
                           length(length of ws-write-msg-pt2)
                           resp(ws-resp-writeq-ts)
                       end-exec
                   end-if
                   if ws-entry-repeats(ws-x) not = 0
                       move ws-entry-repeats(ws-x)
                         to ws-repeat-message-count
                       move spaces to ws-write-msg-pt1
                       move ws-repeat-message to ws-write-msg-pt1b
                       exec cics write operator
                           text(ws-write-msg-pt1)
                           textlength(length of ws-write-msg-pt1)
                       end-exec
                       exec cics writeq ts
                           queue(ws-ts-q-name)
                           from(ws-write-msg-pt1)
                           length(length of ws-write-msg-pt1)
                           resp(ws-resp-writeq-ts)
                       end-exec
                   end-if
               end-if
           end-perform

           move ws-count to ws-message-count
           move eibtrnid to ws-message-tranid

           move spaces to ws-write-msg-pt1
           move ws-message to ws-write-msg-pt1b
           exec cics write operator
               text(ws-write-msg-pt1)
               textlength(length of ws-write-msg-pt1)
           end-exec
           exec cics writeq ts
               queue(ws-ts-q-name)
               from(ws-write-msg-pt1)
               length(length of ws-write-msg-pt1)
               resp(ws-resp-writeq-ts)
           end-exec
           if eibtrmid not = low-values
               exec cics send text | added text
                 from(ws-message)
                 erase
               end-exec
           end-if
           exec cics return end-exec
           stop run
           .
      ***--------------------------------------------------------------*
      ***  $workfile:   dfhzcamx.cbl  $ end
      ***--------------------------------------------------------------*
