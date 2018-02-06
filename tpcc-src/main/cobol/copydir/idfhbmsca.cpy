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
       01      DFHBMSCA.
      *                                               X'1915'.
         02    DFHBMPEM-BIN  PICTURE 9(4) COMP VALUE IS 6421.                   
         02    FILLER REDEFINES DFHBMPEM-BIN.
           03  DFHBMPEM  PICTURE X.
           03  DFHBMPNL  PICTURE X.
      *                                               X'0C0D'.
         02    DFHBMPFF-BIN  PICTURE 9(4) COMP VALUE IS 3085.
         02    FILLER REDEFINES DFHBMPFF-BIN.
           03  DFHBMPFF  PICTURE X.
           03  DFHBMPCR  PICTURE X.
         02    DFHBMASK  PICTURE X   VALUE  IS  '0'.
         02    DFHBMUNP  PICTURE X   VALUE  IS  ' '.
         02    DFHBMUNN  PICTURE X   VALUE  IS  '&'.
         02    DFHBMPRO  PICTURE X   VALUE  IS  '-'.
         02    DFHBMBRY  PICTURE X   VALUE  IS  'H'.
         02    DFHBMDAR  PICTURE X   VALUE  IS  '<'.
         02    DFHBMFSE  PICTURE X   VALUE  IS  'A'.
         02    DFHBMPRF  PICTURE X   VALUE  IS  '/'.
         02    DFHBMASF  PICTURE X   VALUE  IS  '1'.
         02    DFHBMASB  PICTURE X   VALUE  IS  '8'.
      *                                               X'0E0F'.
         02    DFHBMPSO-BIN  PICTURE 9(4) COMP VALUE IS 3599.
         02    FILLER REDEFINES DFHBMPSO-BIN.
           03  DFHBMPSO  PICTURE X.
           03  DFHBMPSI  PICTURE X.
      *                                               X'0080'.
         02    DFHBMEOF-BIN  PICTURE 9(4) COMP VALUE IS 128.
         02    FILLER REDEFINES DFHBMEOF-BIN.
           03  FILLER    PICTURE X.
           03  DFHBMEOF  PICTURE X.
      *                                               X'0282'.
         02    DFHBMCUR-BIN  PICTURE 9(4) COMP VALUE IS 642.
         02    FILLER REDEFINES DFHBMCUR-BIN.
           03  DFHBMCUR  PICTURE X.
           03  DFHBMEC   PICTURE X.
      *                                               X'0082'.
         02    DFHBMFLG-BIN  PICTURE 9(4) COMP VALUE IS 130.
             88    DFHERASE VALUES ARE 128, 130.
             88    DFHCURSR VALUES ARE   2, 130.
         02    FILLER REDEFINES DFHBMFLG-BIN.
           03  FILLER    PICTURE X.
           03  DFHBMFLG  PICTURE X.
         02    DFHBMDET  PICTURE X   VALUE  IS  HIGH-VALUES.
         02    FILLER    PICTURE X.
      *                                               X'1F3F'.
         02    DFHSA-BIN  PICTURE 9(4) COMP VALUE IS 7999.
         02    FILLER REDEFINES DFHSA-BIN.
           03  DFHSA     PICTURE X.
           03  DFHERROR  PICTURE X.
      *                                               X'0042'.
         02    DFHCOLOR-BIN  PICTURE 9(4) COMP VALUE IS 66.
         02    FILLER REDEFINES DFHCOLOR-BIN.
           03  FILLER    PICTURE X.
           03  DFHCOLOR  PICTURE X.
      *                                               X'0043'.
         02    DFHPS-BIN  PICTURE 9(4) COMP VALUE IS 67.
         02    FILLER REDEFINES DFHPS-BIN.
           03  FILLER    PICTURE X.
           03  DFHPS     PICTURE X.
      *                                               X'0041'.
         02    DFHHLT-BIN  PICTURE 9(4) COMP VALUE IS 65.
         02    FILLER REDEFINES DFHHLT-BIN.
           03  FILLER    PICTURE X.
           03  DFHHLT    PICTURE X.
      *                                               X'00C0'.
         02    DFH3270-BIN   PICTURE 9(4) COMP VALUE IS 192.
         02    FILLER REDEFINES DFH3270-BIN.
           03  FILLER    PICTURE X.
           03  DFH3270   PICTURE X.
         02    DFHVAL    PICTURE X   VALUE  IS  'A'.
         02    DFHOUTLN  PICTURE X   VALUE  IS  'B'.
      *                                               X'0046'.
         02    DFHBKTRN-BIN  PICTURE 9(4) COMP VALUE IS 70.
         02    FILLER REDEFINES DFHBKTRN-BIN.
           03  FILLER    PICTURE X.
           03  DFHBKTRN  PICTURE X.
         02    DFHALL    PICTURE X   VALUE  IS  LOW-VALUES.
         02    DFHDFT    PICTURE X   VALUE  IS  HIGH-VALUES.
         02    DFHDFCOL  PICTURE X   VALUE  IS  LOW-VALUES.
         02    DFHBLUE   PICTURE X   VALUE  IS  '1'.
         02    DFHRED    PICTURE X   VALUE  IS  '2'.
         02    DFHPINK   PICTURE X   VALUE  IS  '3'.
         02    DFHGREEN  PICTURE X   VALUE  IS  '4'.
         02    DFHTURQ   PICTURE X   VALUE  IS  '5'.
         02    DFHYELLO  PICTURE X   VALUE  IS  '6'.
         02    DFHNEUTR  PICTURE X   VALUE  IS  '7'.
         02    DFHBASE   PICTURE X   VALUE  IS  LOW-VALUES.
         02    DFHDFHI   PICTURE X   VALUE  IS  LOW-VALUES.
         02    DFHBLINK  PICTURE X   VALUE  IS  '1'.
         02    DFHREVRS  PICTURE X   VALUE  IS  '2'.
         02    DFHUNDLN  PICTURE X   VALUE  IS  '4'.
      *                                               X'0402'.
         02    DFHMFIL-BIN  PICTURE 9(4) COMP VALUE IS 1026.
         02    FILLER REDEFINES DFHMFIL-BIN.
           03  DFHMFIL   PICTURE X.
           03  DFHMENT   PICTURE X.
      *                                               X'0601'.
         02    DFHMFE-BIN  PICTURE 9(4) COMP VALUE IS 1537.
         02    FILLER REDEFINES DFHMFE-BIN.
           03  DFHMFE    PICTURE X.
           03  DFHMT     PICTURE X.
      *                                               X'0503'.
         02    DFHMFT-BIN  PICTURE 9(4) COMP VALUE IS 1283.
         02    FILLER REDEFINES DFHMFT-BIN.
           03  DFHMFT    PICTURE X.
           03  DFHMET    PICTURE X.
      *                                               X'0007'.
         02    DFHMFET-BIN  PICTURE 9(4) COMP VALUE IS 7.
         02    FILLER REDEFINES DFHMFET-BIN.
           03  FILLER    PICTURE X.
           03  DFHMFET   PICTURE X.
         02    DFHUNNOD  PICTURE X   VALUE  IS  '('.
         02    DFHUNIMD  PICTURE X   VALUE  IS  'I'.
         02    DFHUNNUM  PICTURE X   VALUE  IS  'J'.
         02    DFHUNNUB  PICTURE X   VALUE  IS  'Q'.
         02    DFHUNINT  PICTURE X   VALUE  IS  'R'.
         02    DFHUNNON  PICTURE X   VALUE  IS  ')'.
         02    DFHPROTI  PICTURE X   VALUE  IS  'Y'.
         02    DFHPROTN  PICTURE X   VALUE  IS  '%'.
         02    DFHDFFR   PICTURE X   VALUE  IS  LOW-VALUES.
      *                                               X'0102'.
         02    DFHUNDER-BIN  PICTURE 9(4) COMP VALUE IS 258.
         02    FILLER REDEFINES DFHUNDER-BIN.
           03  DFHUNDER  PICTURE X.
           03  DFHRIGHT  PICTURE X.
      *                                               X'0408'.
         02    DFHOVER-BIN  PICTURE 9(4) COMP VALUE IS 1032.
         02    FILLER REDEFINES DFHOVER-BIN.
           03  DFHOVER   PICTURE X.
           03  DFHLEFT   PICTURE X.
      *                                               X'000F'.
         02    DFHBOX-BIN   PICTURE 9(4) COMP VALUE IS 15.
         02    FILLER REDEFINES DFHBOX-BIN.
           03  FILLER    PICTURE X.
           03  DFHBOX    PICTURE X.
      *                                               X'0001'.
         02    DFHSOSI-BIN  PICTURE 9(4) COMP VALUE IS 1.
         02    FILLER REDEFINES DFHSOSI-BIN.
           03  FILLER    PICTURE X.
           03  DFHSOSI   PICTURE X.
         02    DFHTRANS  PICTURE X   VALUE  IS  '0'.
         02    DFHOPAQ   PICTURE X   VALUE  IS  HIGH-VALUES.
      *----------------------------------------------------------------*
      * dfhbmsca.cpy end
      *----------------------------------------------------------------*
