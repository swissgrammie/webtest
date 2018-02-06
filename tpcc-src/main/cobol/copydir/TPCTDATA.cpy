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
       01  tpc-trace-data-block.
      *> Module name generating the trace entry
           03  tpc-trace-module-id           pic x(1).
               88  trace-sqlbmsm             value x'd0'.
               88  trace-sqldelv             value x'd1'.
               88  trace-sqlload             value x'd2'.
               88  trace-sqlnord             value x'd3'.
               88  trace-sqlords             value x'd4'.
               88  trace-sqlpaym             value x'd5'.
               88  trace-sqlstkl             value x'd6'.
      *        88  trace-?                   value x'd7'.
               88  trace-vsmbmsm             value x'd8'.
               88  trace-vsmdelv             value x'd9'.
               88  trace-vsmload             value x'da'.
               88  trace-vsmnord             value x'db'.
               88  trace-vsmords             value x'dc'.
               88  trace-vsmpaym             value x'dd'.
               88  trace-vsmstkl             value x'de'.
      *        88  trace-?                   value x'df'
      *> Call sequence number in module
           03  tpc-trace-call-seq            pic x(1).
      *> Entry is before or after the call
           03  tpc-trace-call-type           pic x(1).
               88  trace-before-call         value x'03'.
               88  trace-after-call          value x'04'.
           03  tpc-trace-data-length         pic 9(4) comp.
           03  tpc-trace-data                pic x(128).
           03  filler redefines tpc-trace-data.
      *> First letter(s) of SQL function
      *> S(elect), I(insert)< U(pdate), D(elete)
               05  tpc-trace-sql-function    pic x(2).
                   88  trace-sql-select      value 'S '.
                   88  trace-sql-insert      value 'I '.
                   88  trace-sql-update      value 'U '.
                   88  trace-sql-delete      value 'D '.
                   88  trace-sql-csr-declare value 'CD'.
                   88  trace-sql-csr-open    value 'CO'.
                   88  trace-sql-csr-fetch   value 'CF'.
                   88  trace-sql-csr-close   value 'CC'.
      *> First letter(s) of EXEC CICS function
      *> R(read), RU (read update), W (write), RW (rewrite), D (delete)
               05  tpc-trace-vsm-function    pic x(2).
                   88  trace-vsm-read        value 'R '.
                   88  trace-vsm-read-next   value 'RN'.
                   88  trace-vsm-read-prev   value 'RP'.
                   88  trace-vsm-read-update value 'RU'.
                   88  trace-vsm-write       value 'W '.
                   88  trace-vsm-rewrite     value 'RW'.
                   88  trace-vsm-delete      value 'D '.
                   88  trace-vsm-start-br    value 'SB'.
                   88  trace-vsm-stop-br     value 'ZB'.
      *> Abbreviated table names
      *> Database/File names abbreeviated as follow:
      *        Ca - Customer Alt Index   No - New Order
      *        Cu - Customer             Or - Order
      *        Dg - Delivery Log         Oa - Order Alt Index
      *        Di - District             Ol - Order Line
      *        Hi - Historyer            St - Stock
      *        It - Item                 Wh - Warehouse
               05  tpc-trace-info            pic x(124).

      ***--------------------------------------------------------------*
      ***  $Workfile:   tpctdata.cpy  $ end
      ***--------------------------------------------------------------*

