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
       01  response                          pic s9(9) comp.
       01  cresponse                         pic 9(3).
       01  cresponse2                        pic 9(3).
       01  err-name                          pic x(24).
       01  err-fn                            pic x(24).
       01  err-rsrce                         pic x(24).
LJ     01 CICSERR-MSG.
LJ        05 CICSERR-PGM        PIC X(9).
LJ        05 CICSERR-MSG-LAST   PIC X(51).
      ***--------------------------------------------------------------*
      ***  $Workfile:   cicserrp.cpy  $ end
      ***--------------------------------------------------------------*
