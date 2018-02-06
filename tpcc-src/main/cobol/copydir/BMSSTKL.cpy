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
       01  BMSSTKLI.
           02  FILLER PIC X(12).
           02  STKLTRNL  COMP PIC S9(4).
           02  STKLTRNF  PICTURE X.
           02  FILLER REDEFINES STKLTRNF.
               03  STKLTRNA  PICTURE X.
           02  STKLTRNI  PIC X(4).
           02  STKLWIDL  COMP PIC S9(4).
           02  STKLWIDF  PICTURE X.
           02  FILLER REDEFINES STKLWIDF.
               03  STKLWIDA  PICTURE X.
           02  STKLWIDI  PIC X(4).
           02  STKLDIDL  COMP PIC S9(4).
           02  STKLDIDF  PICTURE X.
           02  FILLER REDEFINES STKLDIDF.
               03  STKLDIDA  PICTURE X.
           02  STKLDIDI  PIC X(2).
           02  STKLTRHL  COMP PIC S9(4).
           02  STKLTRHF  PICTURE X.
           02  FILLER REDEFINES STKLTRHF.
               03  STKLTRHA  PICTURE X.
           02  STKLTRHI  PIC X(2).
           02  STKLSTKL  COMP PIC S9(4).
           02  STKLSTKF  PICTURE X.
           02  FILLER REDEFINES STKLSTKF.
               03  STKLSTKA  PICTURE X.
           02  STKLSTKI  PIC X(3).
           02  STKLMSGL  COMP PIC S9(4).
           02  STKLMSGF  PICTURE X.
           02  FILLER REDEFINES STKLMSGF.
               03  STKLMSGA  PICTURE X.
           02  STKLMSGI  PIC X(79).
       01  BMSSTKLO REDEFINES BMSSTKLI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  STKLTRNO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  STKLWIDO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  STKLDIDO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  STKLTRHO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  STKLSTKO  PIC X(3).
           02  FILLER PICTURE X(3).
           02  STKLMSGO  PIC X(79).
