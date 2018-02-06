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

       01  BMSMENUI.
           02  FILLER PIC X(12).
           02  MENUTRNL  COMP PIC S9(4).
           02  MENUTRNF  PICTURE X.
           02  FILLER REDEFINES MENUTRNF.
               03  MENUTRNA  PICTURE X.
           02  MENUTRNI  PIC X(4).
           02  MENUWIDL  COMP PIC S9(4).
           02  MENUWIDF  PICTURE X.
           02  FILLER REDEFINES MENUWIDF.
               03  MENUWIDA  PICTURE X.
           02  MENUWIDI  PIC X(4).
           02  MENUDBML  COMP PIC S9(4).
           02  MENUDBMF  PICTURE X.
           02  FILLER REDEFINES MENUDBMF.
               03  MENUDBMA  PICTURE X.
           02  MENUDBMI  PIC X(1).
           02  MENUWCTL  COMP PIC S9(4).
           02  MENUWCTF  PICTURE X.
           02  FILLER REDEFINES MENUWCTF.
               03  MENUWCTA  PICTURE X.
           02  MENUWCTI  PIC X(2).
           02  MENUSIZL  COMP PIC S9(4).
           02  MENUSIZF  PICTURE X.
           02  FILLER REDEFINES MENUSIZF.
               03  MENUSIZA  PICTURE X.
           02  MENUSIZI  PIC X(1).
           02  MENUREML  COMP PIC S9(4).
           02  MENUREMF  PICTURE X.
           02  FILLER REDEFINES MENUREMF.
               03  MENUREMA  PICTURE X.
           02  MENUREMI  PIC X(1).
           02  MENULODL  COMP PIC S9(4).
           02  MENULODF  PICTURE X.
           02  FILLER REDEFINES MENULODF.
               03  MENULODA  PICTURE X.
           02  MENULODI  PIC X(1).
           02  MENUDBGL  COMP PIC S9(4).
           02  MENUDBGF  PICTURE X.
           02  FILLER REDEFINES MENUDBGF.
               03  MENUDBGA  PICTURE X.
           02  MENUDBGI  PIC X(1).
           02  MENUMSGL  COMP PIC S9(4).
           02  MENUMSGF  PICTURE X.
           02  FILLER REDEFINES MENUMSGF.
               03  MENUMSGA  PICTURE X.
           02  MENUMSGI  PIC X(79).
       01  BMSMENUO REDEFINES BMSMENUI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  MENUTRNO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  MENUWIDO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  MENUDBMO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  MENUWCTO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  MENUSIZO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  MENUREMO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  MENULODO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  MENUDBGO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  MENUMSGO  PIC X(79).
