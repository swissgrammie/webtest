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

       01  BMSDELVI.
           02  FILLER PIC X(12).
           02  DELVTRNL  COMP PIC S9(4).
           02  DELVTRNF  PICTURE X.
           02  FILLER REDEFINES DELVTRNF.
               03  DELVTRNA  PICTURE X.
           02  DELVTRNI  PIC X(4).
           02  DELVWIDL  COMP PIC S9(4).
           02  DELVWIDF  PICTURE X.
           02  FILLER REDEFINES DELVWIDF.
               03  DELVWIDA  PICTURE X.
           02  DELVWIDI  PIC X(4).
           02  DELVXIDL  COMP PIC S9(4).
           02  DELVXIDF  PICTURE X.
           02  FILLER REDEFINES DELVXIDF.
               03  DELVXIDA  PICTURE X.
           02  DELVXIDI  PIC X(2).
           02  DELVERRL  COMP PIC S9(4).
           02  DELVERRF  PICTURE X.
           02  FILLER REDEFINES DELVERRF.
               03  DELVERRA  PICTURE X.
           02  DELVERRI  PIC X(45).
           02  DELVMSGL  COMP PIC S9(4).
           02  DELVMSGF  PICTURE X.
           02  FILLER REDEFINES DELVMSGF.
               03  DELVMSGA  PICTURE X.
           02  DELVMSGI  PIC X(79).
       01  BMSDELVO REDEFINES BMSDELVI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  DELVTRNO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  DELVWIDO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  DELVXIDO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  DELVERRO  PIC X(45).
           02  FILLER PICTURE X(3).
           02  DELVMSGO  PIC X(79).
