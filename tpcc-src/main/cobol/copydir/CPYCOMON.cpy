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
      $XFD FILE="TPCCFIL.xml
           03  common-data.
               05  err                       pic x(80).
               05  msg                       pic x(80).
               05  result-code               pic s9(9) comp.
               05  tpc-trace-flag            pic x(1).
                   88  tpc-trace-not-eqd     value 'N'.
                   88  tpc-trace-reqd        value 'Y'.
               05  td-data                   pic x(120).
      ***--------------------------------------------------------------*
      ***  $Workfile:   cpycomon.cpy  $ end
      ***--------------------------------------------------------------*
