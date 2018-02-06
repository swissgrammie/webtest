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

      * SQL data for WAREHOUSE
           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  w-id                              pic s9(9) comp.
       01  w-name                            pic x(10).
       01  w-street-1                        pic x(20).
       01  w-street-2                        pic x(20).
       01  w-city                            pic x(20).
       01  w-state                           pic x(2).
       01  w-zip                             pic x(9).
       01  w-tax                             pic sV9999 comp-3.
       01  w-ytd                             pic s9(10)v99 comp-3.
           EXEC SQL END DECLARE SECTION END-EXEC

      * SQL data for ITEM
           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  i-id                              pic s9(9) comp.
       01  i-im-id                           pic s9(9) comp.
       01  i-name                            pic x(24).
       01  i-price                           pic s999v99 comp-3.
       01  i-data                            pic x(50).
           EXEC SQL END DECLARE SECTION END-EXEC

      * SQL data for STOCK
           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  s-i-id                            pic s9(9) comp.
       01  s-w-id                            pic s9(9) comp.
       01  s-quantity                        pic s9(4) comp-3.
       01  s-dist-01                         pic x(24).
       01  s-dist-02                         pic x(24).
       01  s-dist-03                         pic x(24).
       01  s-dist-04                         pic x(24).
       01  s-dist-05                         pic x(24).
       01  s-dist-06                         pic x(24).
       01  s-dist-07                         pic x(24).
       01  s-dist-08                         pic x(24).
       01  s-dist-09                         pic x(24).
       01  s-dist-10                         pic x(24).
       01  s-data                            pic x(50).
           EXEC SQL END DECLARE SECTION END-EXEC

      * SQL data for ORDER
           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  o-id                              pic s9(9) comp.
       01  o-d-id                            pic s9(9) comp.
       01  o-w-id                            pic s9(9) comp.
       01  o-c-id                            pic s9(9) comp.
       01  o-carrier-id                      pic s9(9) comp.
       01  o-ol-cnt                          pic s9(9) comp.
       01  o-all-local                       pic s9(9) comp.
       01  ol-o-id                           pic s9(9) comp.
       01  ol-d-id                           pic s9(9) comp.
       01  ol-w-id                           pic s9(9) comp.
       01  ol-number                         pic s9(9) comp.
       01  ol-i-id                           pic s9(9) comp.
       01  ol-supply-w-id                    pic s9(9) comp.
       01  ol-quantity                       pic s9(9) comp.
       01  ol-amount                         pic s9(9) comp.
       01  ol-dist-info                      pic x(24).
       01  ol-total                          pic s9(10)v99 comp-3.
           EXEC SQL END DECLARE SECTION END-EXEC

      * SQL data for DISTRICT
           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  d-id                              pic s9(9) comp.
       01  d-w-id                            pic s9(9) comp.
       01  d-name                            pic x(10).
       01  d-street-1                        pic x(20).
       01  d-street-2                        pic x(20).
       01  d-city                            pic x(20).
       01  d-state                           pic x(2).
       01  d-zip                             pic x(9).
       01  d-tax                             pic sV9999 comp-3.
       01  d-ytd                             pic s9(10)v99 comp-3.
       01  d-next-o-id                       pic s9(9) comp.
           EXEC SQL END DECLARE SECTION END-EXEC

      * SQL data for CUSTOMER
           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  c-id                              pic s9(9) comp.
       01  c-d-id                            pic s9(9) comp.
       01  c-w-id                            pic s9(9) comp.
       01  c-first                           pic x(16).
       01  c-middle                          pic x(2).
       01  c-last                            pic x(16).
       01  c-street-1                        pic x(20).
       01  c-street-2                        pic x(20).
       01  c-city                            pic x(20).
       01  c-state                           pic x(2).
       01  c-zip                             pic x(9).
       01  c-phone                           pic x(16).
       01  c-since                           pic x(20).
       01  c-credit                          pic x(2).
       01  c-credit-lim                      pic s9(10)v99 comp-3.
       01  c-discount                        pic sv9999 comp-3.
       01  c-balance                         pic s9(10)v99 comp-3.
       01  c-ytd-payment                     pic s9(10)v99 comp-3.
       01  c-payment-cnt                     pic s9(9) comp.
       01  c-data.
         49  c-data-len                      pic s9(4) comp.
         49  c-data-data                     pic x(500).
       01  c-new-data.
         49  c-new-data-len                  pic s9(4) comp.
         49  c-new-data-data                 pic x(500).
       01  h-amount                          pic s9(4)v99 comp-3.
       01  h-data                            pic x(24).
           EXEC SQL END DECLARE SECTION END-EXEC

      * SQL data for NEW_ORDER
           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  no-o-id                           pic s9(9) comp.
       01  no-d-id                           pic s9(9) comp.
       01  no-w-id                           pic s9(9) comp.
           EXEC SQL END DECLARE SECTION END-EXEC

      * SQL data for DELVLOG
           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  d-log                             pic x(80).
           EXEC SQL END DECLARE SECTION END-EXEC

      * SQL display copy of SQLCODE
           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01  CSQLCODE                          PIC +9(9).
           EXEC SQL END DECLARE SECTION END-EXEC

      ***--------------------------------------------------------------*
      ***  $Workfile:   tpcc.cpy  $ end
      ***--------------------------------------------------------------*
