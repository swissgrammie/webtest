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
       02  payment-data.
           03  hdate                         pic x(19).
           03  wid                           pic 9(4).
           03  did                           pic 9(2).
           03  cid                           pic 9(4).
           03  cwid                          pic 9(4).
           03  cdid                          pic 9(2).
           03  wstreet1                      pic x(20).
           03  wstreet2                      pic x(20).
           03  wcity                         pic x(20).
           03  wstate                        pic x(2).
           03  wzip                          pic x(9).
           03  dstreet1                      pic x(20).
           03  dstreet2                      pic x(20).
           03  dcity                         pic x(20).
           03  dstate                        pic x(2).
           03  dzip                          pic x(9).
           03  cfirst                        pic x(16).
           03  cmiddle                       pic x(2).
           03  clast                         pic x(16).
           03  cstreet1                      pic x(20).
           03  cstreet2                      pic x(20).
           03  ccity                         pic x(20).
           03  cstate                        pic x(2).
           03  czip                          pic x(9).
           03  cphone                        pic x(19).
           03  csince                        pic x(10).
           03  ccredit                       pic x(2).
           03  ccreditlim                    pic 9999999999.99.
           03  cdiscount                     pic 99.99.
           03  cbalance                      pic -9999999999.99.
           03  cdata.
               05 cdataline                  pic x(50) occurs 4.
           03  hamount                       pic 9999.99.
       copy cpycomon.

      ***--------------------------------------------------------------*
      ***  $Workfile:   cpypaym.cpy  $ end
      ***--------------------------------------------------------------*
