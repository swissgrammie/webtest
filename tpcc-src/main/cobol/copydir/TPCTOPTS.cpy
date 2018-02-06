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
       02  tpc-trace-options-array.
           03  tpc-trace-delv.
               05  tpc-trace-vsmdelv         pic x(1) value 'N'.
                 88  trace-vsmdelv-88        value 'Y'.
               05  tpc-trace-sqldelv         pic x(1) value 'N'.
                 88  trace-sqldelv-88        value 'Y'.
           03  tpc-trace-load.
               05  tpc-trace-vsmload         pic x(1) value 'N'.
                 88  trace-vsmload-88        value 'Y'.
               05  tpc-trace-sqlload         pic x(1) value 'N'.
                 88  trace-sqlload-88        value 'Y'.
           03  tpc-trace-nord.
               05  tpc-trace-vsmnord         pic x(1) value 'N'.
                 88  trace-vsmnord-88        value 'Y'.
               05  tpc-trace-sqlnord         pic x(1) value 'N'.
                 88  trace-sqlnord-88        value 'Y'.
           03  tpc-trace-ords.
               05  tpc-trace-vsmords         pic x(1) value 'N'.
                 88  trace-vsmords-88        value 'Y'.
               05  tpc-trace-sqlords         pic x(1) value 'N'.
                 88  trace-sqlords-88        value 'Y'.
           03  tpc-trace-paym.
               05  tpc-trace-vsmpaym         pic x(1) value 'N'.
                 88  trace-vsmpaym-88        value 'Y'.
               05  tpc-trace-sqlpaym         pic x(1) value 'N'.
                 88  trace-sqlpaym-88        value 'Y'.
           03  tpc-trace-stkl.
               05  tpc-trace-vsmstkl         pic x(1) value 'N'.
                 88  trace-vsmstkl-88        value 'Y'.
               05  tpc-trace-sqlstkl         pic x(1) value 'N'.
                 88  trace-sqlstkl-88        value 'Y'.

      ***--------------------------------------------------------------*
      ***  $Workfile:   tpctrace.cpy  $ end
      ***--------------------------------------------------------------*
