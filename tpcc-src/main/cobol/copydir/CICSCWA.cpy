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
       01  tpcc-cwa.
      *> Eyecatcher
           03  cwa-eyecatcher                pic x(4).
             88  tpcc-eyecatcher             value 'TPCC'.
      *> Trace module available
           03  cwa-tpc-trace-module-name     pic x(8).
             88  trace-module-missing        value '=NOTRCE='.
      *> TPC module trace flags
           03  cwa-trace-options-array.
      *> F1 = New Order
               05  cwa-trace-sqlnord         pic x(1) value 'N'.
                 88  trace-sqlnord-cwa-88    value 'Y'.
               05  cwa-trace-vsmnord         pic x(1) value 'N'.
                 88  trace-vsmnord-cwa-88    value 'Y'.
      *> F2 = Payments
               05  cwa-trace-sqlpaym         pic x(1) value 'N'.
                 88  trace-sqlpaym-cwa-88    value 'Y'.
               05  cwa-trace-vsmpaym         pic x(1) value 'N'.
                 88  trace-vsmpaym-cwa-88    value 'Y'.
      *> F3 = Order Status
               05  cwa-trace-sqlords         pic x(1) value 'N'.
                 88  trace-sqlords-cwa-88    value 'Y'.
               05  cwa-trace-vsmords         pic x(1) value 'N'.
                 88  trace-vsmords-cwa-88    value 'Y'.
      *> F4 = Delivery
               05  cwa-trace-sqldelv         pic x(1) value 'N'.
                 88  trace-sqldelv-cwa-88    value 'Y'.
               05  cwa-trace-vsmdelv         pic x(1) value 'N'.
                 88  trace-vsmdelv-cwa-88    value 'Y'.
      *> F5 - Stock Level
               05  cwa-trace-sqlstkl         pic x(1) value 'N'.
                 88  trace-sqlstkl-cwa-88    value 'Y'.
               05  cwa-trace-vsmstkl         pic x(1) value 'N'.
                 88  trace-vsmstkl-cwa-88    value 'Y'.
      *> F7 = Database Load
               05  cwa-trace-sqlload         pic x(1) value 'N'.
                 88  trace-sqlload-cwa-88    value 'Y'.
               05  cwa-trace-vsmload         pic x(1) value 'N'.
                 88  trace-vsmload-cwa-88    value 'Y'.

      ***--------------------------------------------------------------*
      ***  $Workfile:   tpctrace.cpy  $ end
      ***--------------------------------------------------------------*

