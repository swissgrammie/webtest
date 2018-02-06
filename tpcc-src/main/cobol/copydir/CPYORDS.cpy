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
       02  order-status-data.
           03  wid                           pic 9(4).
           03  did                           pic 9(2).
           03  cid                           pic 9(4).
           03  cfirst                        pic x(16).
           03  cmiddle                       pic x(2).
           03  clast                         pic x(16).
           03  cbalance                      pic -99999.99.
           03  oid                           pic 9(8).
           03  oentryd                       pic x(10).
           03  ocarrierid                    pic 9(2).
           03  oline occurs 15.
               05 supware                    pic 9(4).
               05 itemid                     pic 9(6).
               05 qty                        pic 9(2).
               05 amt                        pic $99999.99
                                                 blank when zero.
               05 deldate                    pic x(10).
       copy cpycomon.

      ***--------------------------------------------------------------*
      ***  $Workfile:   cpyords.cpy  $ end
      ***--------------------------------------------------------------*
