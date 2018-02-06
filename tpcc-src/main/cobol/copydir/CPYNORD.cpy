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
       
       02  new-order-data.
           03  wid                           pic 9(4).
           03  did                           pic 9(2).
           03  cid                           pic 9(4).
           03  clast                         pic x(16).
           03  ccredit                       pic x(2).
           03  cdiscount                     pic 99.99.
           03  wtax                          pic 99.99.
           03  dtax                          pic 99.99.
           03  oolcnt                        pic 9(2).
           03  oid                           pic 9(8).
           03  oentrydt                      pic x(19).
           03  no-item-data occurs 15.
               05  olno                      pic 9(2).
               05  no-item-key.
                   07 supware                pic 9(4).
                   07 itemid                 pic 9(6).
               05 iname                      pic x(24).
               05 qty                        pic 9(2).
               05 stock                      pic 9(3).
               05 bg                         pic x(1).
               05 price                      pic 999.99.
               05 amt                        pic 9999.99.
           03 total                          pic 99999.99.
       copy cpycomon.

      ***--------------------------------------------------------------*
      ***  $Workfile:   cpynord.cpy  $ end
      ***--------------------------------------------------------------*
