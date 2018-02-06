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
       01  BMSPAYMI.
           02  FILLER PIC X(12).
           02  PAYMTRNL  COMP PIC S9(4).
           02  PAYMTRNF  PICTURE X.
           02  FILLER REDEFINES PAYMTRNF.
               03  PAYMTRNA  PICTURE X.
           02  PAYMTRNI  PIC X(4).
           02  PAYMHDTL  COMP PIC S9(4).
           02  PAYMHDTF  PICTURE X.
           02  FILLER REDEFINES PAYMHDTF.
               03  PAYMHDTA  PICTURE X.
           02  PAYMHDTI  PIC X(19).
           02  PAYMWIDL  COMP PIC S9(4).
           02  PAYMWIDF  PICTURE X.
           02  FILLER REDEFINES PAYMWIDF.
               03  PAYMWIDA  PICTURE X.
           02  PAYMWIDI  PIC X(4).
           02  PAYMDIDL  COMP PIC S9(4).
           02  PAYMDIDF  PICTURE X.
           02  FILLER REDEFINES PAYMDIDF.
               03  PAYMDIDA  PICTURE X.
           02  PAYMDIDI  PIC X(2).
           02  PAYMWS1L  COMP PIC S9(4).
           02  PAYMWS1F  PICTURE X.
           02  FILLER REDEFINES PAYMWS1F.
               03  PAYMWS1A  PICTURE X.
           02  PAYMWS1I  PIC X(20).
           02  PAYMDS1L  COMP PIC S9(4).
           02  PAYMDS1F  PICTURE X.
           02  FILLER REDEFINES PAYMDS1F.
               03  PAYMDS1A  PICTURE X.
           02  PAYMDS1I  PIC X(20).
           02  PAYMWS2L  COMP PIC S9(4).
           02  PAYMWS2F  PICTURE X.
           02  FILLER REDEFINES PAYMWS2F.
               03  PAYMWS2A  PICTURE X.
           02  PAYMWS2I  PIC X(20).
           02  PAYMDS2L  COMP PIC S9(4).
           02  PAYMDS2F  PICTURE X.
           02  FILLER REDEFINES PAYMDS2F.
               03  PAYMDS2A  PICTURE X.
           02  PAYMDS2I  PIC X(20).
           02  PAYMWCTL  COMP PIC S9(4).
           02  PAYMWCTF  PICTURE X.
           02  FILLER REDEFINES PAYMWCTF.
               03  PAYMWCTA  PICTURE X.
           02  PAYMWCTI  PIC X(20).
           02  PAYMWSTL  COMP PIC S9(4).
           02  PAYMWSTF  PICTURE X.
           02  FILLER REDEFINES PAYMWSTF.
               03  PAYMWSTA  PICTURE X.
           02  PAYMWSTI  PIC X(2).
           02  PAYMWZPL  COMP PIC S9(4).
           02  PAYMWZPF  PICTURE X.
           02  FILLER REDEFINES PAYMWZPF.
               03  PAYMWZPA  PICTURE X.
           02  PAYMWZPI  PIC X(9).
           02  PAYMDCTL  COMP PIC S9(4).
           02  PAYMDCTF  PICTURE X.
           02  FILLER REDEFINES PAYMDCTF.
               03  PAYMDCTA  PICTURE X.
           02  PAYMDCTI  PIC X(20).
           02  PAYMDSTL  COMP PIC S9(4).
           02  PAYMDSTF  PICTURE X.
           02  FILLER REDEFINES PAYMDSTF.
               03  PAYMDSTA  PICTURE X.
           02  PAYMDSTI  PIC X(2).
           02  PAYMDZPL  COMP PIC S9(4).
           02  PAYMDZPF  PICTURE X.
           02  FILLER REDEFINES PAYMDZPF.
               03  PAYMDZPA  PICTURE X.
           02  PAYMDZPI  PIC X(9).
           02  PAYMCIDL  COMP PIC S9(4).
           02  PAYMCIDF  PICTURE X.
           02  FILLER REDEFINES PAYMCIDF.
               03  PAYMCIDA  PICTURE X.
           02  PAYMCIDI  PIC X(4).
           02  PAYMCWIL  COMP PIC S9(4).
           02  PAYMCWIF  PICTURE X.
           02  FILLER REDEFINES PAYMCWIF.
               03  PAYMCWIA  PICTURE X.
           02  PAYMCWII  PIC X(4).
           02  PAYMCDIL  COMP PIC S9(4).
           02  PAYMCDIF  PICTURE X.
           02  FILLER REDEFINES PAYMCDIF.
               03  PAYMCDIA  PICTURE X.
           02  PAYMCDII  PIC X(2).
           02  PAYMFNML  COMP PIC S9(4).
           02  PAYMFNMF  PICTURE X.
           02  FILLER REDEFINES PAYMFNMF.
               03  PAYMFNMA  PICTURE X.
           02  PAYMFNMI  PIC X(16).
           02  PAYMMNML  COMP PIC S9(4).
           02  PAYMMNMF  PICTURE X.
           02  FILLER REDEFINES PAYMMNMF.
               03  PAYMMNMA  PICTURE X.
           02  PAYMMNMI  PIC X(2).
           02  PAYMLNML  COMP PIC S9(4).
           02  PAYMLNMF  PICTURE X.
           02  FILLER REDEFINES PAYMLNMF.
               03  PAYMLNMA  PICTURE X.
           02  PAYMLNMI  PIC X(16).
           02  PAYMSINL  COMP PIC S9(4).
           02  PAYMSINF  PICTURE X.
           02  FILLER REDEFINES PAYMSINF.
               03  PAYMSINA  PICTURE X.
           02  PAYMSINI  PIC X(10).
           02  PAYMCS1L  COMP PIC S9(4).
           02  PAYMCS1F  PICTURE X.
           02  FILLER REDEFINES PAYMCS1F.
               03  PAYMCS1A  PICTURE X.
           02  PAYMCS1I  PIC X(20).
           02  PAYMCRDL  COMP PIC S9(4).
           02  PAYMCRDF  PICTURE X.
           02  FILLER REDEFINES PAYMCRDF.
               03  PAYMCRDA  PICTURE X.
           02  PAYMCRDI  PIC X(2).
           02  PAYMCS2L  COMP PIC S9(4).
           02  PAYMCS2F  PICTURE X.
           02  FILLER REDEFINES PAYMCS2F.
               03  PAYMCS2A  PICTURE X.
           02  PAYMCS2I  PIC X(20).
           02  PAYMDSCL  COMP PIC S9(4).
           02  PAYMDSCF  PICTURE X.
           02  FILLER REDEFINES PAYMDSCF.
               03  PAYMDSCA  PICTURE X.
           02  PAYMDSCI  PIC X(2).
           02  PAYMCTYL  COMP PIC S9(4).
           02  PAYMCTYF  PICTURE X.
           02  FILLER REDEFINES PAYMCTYF.
               03  PAYMCTYA  PICTURE X.
           02  PAYMCTYI  PIC X(20).
           02  PAYMSTAL  COMP PIC S9(4).
           02  PAYMSTAF  PICTURE X.
           02  FILLER REDEFINES PAYMSTAF.
               03  PAYMSTAA  PICTURE X.
           02  PAYMSTAI  PIC X(2).
           02  PAYMZIPL  COMP PIC S9(4).
           02  PAYMZIPF  PICTURE X.
           02  FILLER REDEFINES PAYMZIPF.
               03  PAYMZIPA  PICTURE X.
           02  PAYMZIPI  PIC X(9).
           02  PAYMTELL  COMP PIC S9(4).
           02  PAYMTELF  PICTURE X.
           02  FILLER REDEFINES PAYMTELF.
               03  PAYMTELA  PICTURE X.
           02  PAYMTELI  PIC X(19).
           02  PAYMPAYL  COMP PIC S9(4).
           02  PAYMPAYF  PICTURE X.
           02  FILLER REDEFINES PAYMPAYF.
               03  PAYMPAYA  PICTURE X.
           02  PAYMPAYI  PIC X(7).
           02  PAYMBALL  COMP PIC S9(4).
           02  PAYMBALF  PICTURE X.
           02  FILLER REDEFINES PAYMBALF.
               03  PAYMBALA  PICTURE X.
           02  PAYMBALI  PIC X(14).
           02  PAYMCLML  COMP PIC S9(4).
           02  PAYMCLMF  PICTURE X.
           02  FILLER REDEFINES PAYMCLMF.
               03  PAYMCLMA  PICTURE X.
           02  PAYMCLMI  PIC X(2).
           02  PAYMCD1L  COMP PIC S9(4).
           02  PAYMCD1F  PICTURE X.
           02  FILLER REDEFINES PAYMCD1F.
               03  PAYMCD1A  PICTURE X.
           02  PAYMCD1I  PIC X(50).
           02  PAYMCD2L  COMP PIC S9(4).
           02  PAYMCD2F  PICTURE X.
           02  FILLER REDEFINES PAYMCD2F.
               03  PAYMCD2A  PICTURE X.
           02  PAYMCD2I  PIC X(50).
           02  PAYMCD3L  COMP PIC S9(4).
           02  PAYMCD3F  PICTURE X.
           02  FILLER REDEFINES PAYMCD3F.
               03  PAYMCD3A  PICTURE X.
           02  PAYMCD3I  PIC X(50).
           02  PAYMCD4L  COMP PIC S9(4).
           02  PAYMCD4F  PICTURE X.
           02  FILLER REDEFINES PAYMCD4F.
               03  PAYMCD4A  PICTURE X.
           02  PAYMCD4I  PIC X(50).
           02  PAYMMSGL  COMP PIC S9(4).
           02  PAYMMSGF  PICTURE X.
           02  FILLER REDEFINES PAYMMSGF.
               03  PAYMMSGA  PICTURE X.
           02  PAYMMSGI  PIC X(79).
       01  BMSPAYMO REDEFINES BMSPAYMI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  PAYMTRNO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  PAYMHDTO  PIC X(19).
           02  FILLER PICTURE X(3).
           02  PAYMWIDO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  PAYMDIDO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  PAYMWS1O  PIC X(20).
           02  FILLER PICTURE X(3).
           02  PAYMDS1O  PIC X(20).
           02  FILLER PICTURE X(3).
           02  PAYMWS2O  PIC X(20).
           02  FILLER PICTURE X(3).
           02  PAYMDS2O  PIC X(20).
           02  FILLER PICTURE X(3).
           02  PAYMWCTO  PIC X(20).
           02  FILLER PICTURE X(3).
           02  PAYMWSTO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  PAYMWZPO  PIC X(9).
           02  FILLER PICTURE X(3).
           02  PAYMDCTO  PIC X(20).
           02  FILLER PICTURE X(3).
           02  PAYMDSTO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  PAYMDZPO  PIC X(9).
           02  FILLER PICTURE X(3).
           02  PAYMCIDO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  PAYMCWIO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  PAYMCDIO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  PAYMFNMO  PIC X(16).
           02  FILLER PICTURE X(3).
           02  PAYMMNMO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  PAYMLNMO  PIC X(16).
           02  FILLER PICTURE X(3).
           02  PAYMSINO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  PAYMCS1O  PIC X(20).
           02  FILLER PICTURE X(3).
           02  PAYMCRDO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  PAYMCS2O  PIC X(20).
           02  FILLER PICTURE X(3).
           02  PAYMDSCO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  PAYMCTYO  PIC X(20).
           02  FILLER PICTURE X(3).
           02  PAYMSTAO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  PAYMZIPO  PIC X(9).
           02  FILLER PICTURE X(3).
           02  PAYMTELO  PIC X(19).
           02  FILLER PICTURE X(3).
           02  PAYMPAYO  PIC X(7).
           02  FILLER PICTURE X(3).
           02  PAYMBALO  PIC X(14).
           02  FILLER PICTURE X(3).
           02  PAYMCLMO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  PAYMCD1O  PIC X(50).
           02  FILLER PICTURE X(3).
           02  PAYMCD2O  PIC X(50).
           02  FILLER PICTURE X(3).
           02  PAYMCD3O  PIC X(50).
           02  FILLER PICTURE X(3).
           02  PAYMCD4O  PIC X(50).
           02  FILLER PICTURE X(3).
           02  PAYMMSGO  PIC X(79).
