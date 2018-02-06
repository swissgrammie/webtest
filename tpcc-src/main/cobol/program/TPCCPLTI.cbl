       identification division.

       program-id. tpccplti.

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
      * Initialize CWA
      *=================================================================
       environment division.
       configuration section.
LJ     SOURCE-COMPUTER. JVM with debugging mode. | SETS DEBUGGING ON
       SPECIAL-NAMES.
LJ    * IMPLEMENTOR clause.
LJ     SYSERR IS OUTERR. | DISPLAY goes to SYSERR
LJ    * SYSOUT IS OUTERR.
       data division.

       working-storage section.
       01  ws-program-name                   pic x(8) value 'TPCCPLTI'.

       01  ws-cwa-ptr                        pointer.

       01  ws-tpc-trace-module               pic x(8)
           value 'TPCTRACE'.

       01  ws-tpc-trace-module-ep            pointer.

       01  ws-load-resp                      pic s9(8) comp value -1.

       01  ws-release-resp                   pic s9(8) comp value -1.

       linkage section.

       copy cicscwa.

       procedure division.
       main-paragraph.
      *  call "CBL_DEBUGBREAK"
      *> Get the address f the CWA and address it
             exec cics address cwa(ws-cwa-ptr)
             end-exec
            set address of tpcc-cwa to ws-cwa-ptr

      *> See if we can locate the TPC trace program
      *     exec cics load program(ws-tpc-trace-module)
      *                    entry(ws-tpc-trace-module-ep)
      *                    resp(ws-load-resp)
      *     end-exec

      *> If we found it, release it as we only need to know it exists
      *    if ws-load-resp = dfhresp(NORMAL)
      *        exec cics release program(ws-tpc-trace-module)
      *                    resp(ws-release-resp)
      *         end-exec
      *    end-if

      *> Set the eyecatcher
           set tpcc-eyecatcher to true

      *> set SQL trace module to space
           move spaces to cwa-tpc-trace-module-name

      *> set all the trace flags to 'N' (dont trace)
           move all 'N' to cwa-trace-options-array

      *> Tell everyone we've been here
           exec cics write operator
                text('TPCC CWA has been initialized')
           end-exec

      *> Check if trace module available and set appropriately
           if ws-load-resp = dfhresp(normal)
               move ws-tpc-trace-module to cwa-tpc-trace-module-name
               exec cics write operator
                    text('TPC Trace module available')
               end-exec
           else
               set trace-module-missing to true
               exec cics write operator
                    text('TPC Trace module not found')
               end-exec
               exec cics write operator
                    text('... TPC tracing not possible')
               end-exec
           end-if

           exec cics return
           end-exec

           exit program
           .

