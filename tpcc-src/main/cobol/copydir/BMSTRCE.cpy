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
       01  BMSTRCEI.
           02  FILLER PIC X(12).
           02  TRCRTNL  COMP PIC S9(4).
           02  TRCRTNF  PICTURE X.
           02  FILLER REDEFINES TRCRTNF.
               03  TRCRTNA  PICTURE X.
           02  TRCRTNI  PIC X(4).
           02  TRCMODL  COMP PIC S9(4).
           02  TRCMODF  PICTURE X.
           02  FILLER REDEFINES TRCMODF.
               03  TRCMODA  PICTURE X.
           02  TRCMODI  PIC X(13).
           02  TRCF1SCL  COMP PIC S9(4).
           02  TRCF1SCF  PICTURE X.
           02  FILLER REDEFINES TRCF1SCF.
               03  TRCF1SCA  PICTURE X.
           02  TRCF1SCI  PIC X(1).
           02  TRCF1SNL  COMP PIC S9(4).
           02  TRCF1SNF  PICTURE X.
           02  FILLER REDEFINES TRCF1SNF.
               03  TRCF1SNA  PICTURE X.
           02  TRCF1SNI  PIC X(1).
           02  TRCF1SML  COMP PIC S9(4).
           02  TRCF1SMF  PICTURE X.
           02  FILLER REDEFINES TRCF1SMF.
               03  TRCF1SMA  PICTURE X.
           02  TRCF1SMI  PIC X(35).
           02  TRCF1VCL  COMP PIC S9(4).
           02  TRCF1VCF  PICTURE X.
           02  FILLER REDEFINES TRCF1VCF.
               03  TRCF1VCA  PICTURE X.
           02  TRCF1VCI  PIC X(1).
           02  TRCF1VNL  COMP PIC S9(4).
           02  TRCF1VNF  PICTURE X.
           02  FILLER REDEFINES TRCF1VNF.
               03  TRCF1VNA  PICTURE X.
           02  TRCF1VNI  PIC X(1).
           02  TRCF1VML  COMP PIC S9(4).
           02  TRCF1VMF  PICTURE X.
           02  FILLER REDEFINES TRCF1VMF.
               03  TRCF1VMA  PICTURE X.
           02  TRCF1VMI  PIC X(35).
           02  TRCF2SCL  COMP PIC S9(4).
           02  TRCF2SCF  PICTURE X.
           02  FILLER REDEFINES TRCF2SCF.
               03  TRCF2SCA  PICTURE X.
           02  TRCF2SCI  PIC X(1).
           02  TRCF2SNL  COMP PIC S9(4).
           02  TRCF2SNF  PICTURE X.
           02  FILLER REDEFINES TRCF2SNF.
               03  TRCF2SNA  PICTURE X.
           02  TRCF2SNI  PIC X(1).
           02  TRCF2SML  COMP PIC S9(4).
           02  TRCF2SMF  PICTURE X.
           02  FILLER REDEFINES TRCF2SMF.
               03  TRCF2SMA  PICTURE X.
           02  TRCF2SMI  PIC X(35).
           02  TRCF2VCL  COMP PIC S9(4).
           02  TRCF2VCF  PICTURE X.
           02  FILLER REDEFINES TRCF2VCF.
               03  TRCF2VCA  PICTURE X.
           02  TRCF2VCI  PIC X(1).
           02  TRCF2VNL  COMP PIC S9(4).
           02  TRCF2VNF  PICTURE X.
           02  FILLER REDEFINES TRCF2VNF.
               03  TRCF2VNA  PICTURE X.
           02  TRCF2VNI  PIC X(1).
           02  TRCF2VML  COMP PIC S9(4).
           02  TRCF2VMF  PICTURE X.
           02  FILLER REDEFINES TRCF2VMF.
               03  TRCF2VMA  PICTURE X.
           02  TRCF2VMI  PIC X(35).
           02  TRCF3SCL  COMP PIC S9(4).
           02  TRCF3SCF  PICTURE X.
           02  FILLER REDEFINES TRCF3SCF.
               03  TRCF3SCA  PICTURE X.
           02  TRCF3SCI  PIC X(1).
           02  TRCF3SNL  COMP PIC S9(4).
           02  TRCF3SNF  PICTURE X.
           02  FILLER REDEFINES TRCF3SNF.
               03  TRCF3SNA  PICTURE X.
           02  TRCF3SNI  PIC X(1).
           02  TRCF3SML  COMP PIC S9(4).
           02  TRCF3SMF  PICTURE X.
           02  FILLER REDEFINES TRCF3SMF.
               03  TRCF3SMA  PICTURE X.
           02  TRCF3SMI  PIC X(35).
           02  TRCF3VCL  COMP PIC S9(4).
           02  TRCF3VCF  PICTURE X.
           02  FILLER REDEFINES TRCF3VCF.
               03  TRCF3VCA  PICTURE X.
           02  TRCF3VCI  PIC X(1).
           02  TRCF3VNL  COMP PIC S9(4).
           02  TRCF3VNF  PICTURE X.
           02  FILLER REDEFINES TRCF3VNF.
               03  TRCF3VNA  PICTURE X.
           02  TRCF3VNI  PIC X(1).
           02  TRCF3VML  COMP PIC S9(4).
           02  TRCF3VMF  PICTURE X.
           02  FILLER REDEFINES TRCF3VMF.
               03  TRCF3VMA  PICTURE X.
           02  TRCF3VMI  PIC X(35).
           02  TRCF4SCL  COMP PIC S9(4).
           02  TRCF4SCF  PICTURE X.
           02  FILLER REDEFINES TRCF4SCF.
               03  TRCF4SCA  PICTURE X.
           02  TRCF4SCI  PIC X(1).
           02  TRCF4SNL  COMP PIC S9(4).
           02  TRCF4SNF  PICTURE X.
           02  FILLER REDEFINES TRCF4SNF.
               03  TRCF4SNA  PICTURE X.
           02  TRCF4SNI  PIC X(1).
           02  TRCF4SML  COMP PIC S9(4).
           02  TRCF4SMF  PICTURE X.
           02  FILLER REDEFINES TRCF4SMF.
               03  TRCF4SMA  PICTURE X.
           02  TRCF4SMI  PIC X(35).
           02  TRCF4VCL  COMP PIC S9(4).
           02  TRCF4VCF  PICTURE X.
           02  FILLER REDEFINES TRCF4VCF.
               03  TRCF4VCA  PICTURE X.
           02  TRCF4VCI  PIC X(1).
           02  TRCF4VNL  COMP PIC S9(4).
           02  TRCF4VNF  PICTURE X.
           02  FILLER REDEFINES TRCF4VNF.
               03  TRCF4VNA  PICTURE X.
           02  TRCF4VNI  PIC X(1).
           02  TRCF4VML  COMP PIC S9(4).
           02  TRCF4VMF  PICTURE X.
           02  FILLER REDEFINES TRCF4VMF.
               03  TRCF4VMA  PICTURE X.
           02  TRCF4VMI  PIC X(35).
           02  TRCF5SCL  COMP PIC S9(4).
           02  TRCF5SCF  PICTURE X.
           02  FILLER REDEFINES TRCF5SCF.
               03  TRCF5SCA  PICTURE X.
           02  TRCF5SCI  PIC X(1).
           02  TRCF5SNL  COMP PIC S9(4).
           02  TRCF5SNF  PICTURE X.
           02  FILLER REDEFINES TRCF5SNF.
               03  TRCF5SNA  PICTURE X.
           02  TRCF5SNI  PIC X(1).
           02  TRCF5SML  COMP PIC S9(4).
           02  TRCF5SMF  PICTURE X.
           02  FILLER REDEFINES TRCF5SMF.
               03  TRCF5SMA  PICTURE X.
           02  TRCF5SMI  PIC X(35).
           02  TRCF5VCL  COMP PIC S9(4).
           02  TRCF5VCF  PICTURE X.
           02  FILLER REDEFINES TRCF5VCF.
               03  TRCF5VCA  PICTURE X.
           02  TRCF5VCI  PIC X(1).
           02  TRCF5VNL  COMP PIC S9(4).
           02  TRCF5VNF  PICTURE X.
           02  FILLER REDEFINES TRCF5VNF.
               03  TRCF5VNA  PICTURE X.
           02  TRCF5VNI  PIC X(1).
           02  TRCF5VML  COMP PIC S9(4).
           02  TRCF5VMF  PICTURE X.
           02  FILLER REDEFINES TRCF5VMF.
               03  TRCF5VMA  PICTURE X.
           02  TRCF5VMI  PIC X(35).
           02  TRCNOL  COMP PIC S9(4).
           02  TRCNOF  PICTURE X.
           02  FILLER REDEFINES TRCNOF.
               03  TRCNOA  PICTURE X.
           02  TRCNOI  PIC X(52).
           02  TRCMSGL  COMP PIC S9(4).
           02  TRCMSGF  PICTURE X.
           02  FILLER REDEFINES TRCMSGF.
               03  TRCMSGA  PICTURE X.
           02  TRCMSGI  PIC X(79).
       01  BMSTRCEO REDEFINES BMSTRCEI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  TRCRTNO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  TRCMODO  PIC X(13).
           02  FILLER PICTURE X(3).
           02  TRCF1SCO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF1SNO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF1SMO  PIC X(35).
           02  FILLER PICTURE X(3).
           02  TRCF1VCO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF1VNO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF1VMO  PIC X(35).
           02  FILLER PICTURE X(3).
           02  TRCF2SCO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF2SNO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF2SMO  PIC X(35).
           02  FILLER PICTURE X(3).
           02  TRCF2VCO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF2VNO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF2VMO  PIC X(35).
           02  FILLER PICTURE X(3).
           02  TRCF3SCO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF3SNO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF3SMO  PIC X(35).
           02  FILLER PICTURE X(3).
           02  TRCF3VCO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF3VNO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF3VMO  PIC X(35).
           02  FILLER PICTURE X(3).
           02  TRCF4SCO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF4SNO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF4SMO  PIC X(35).
           02  FILLER PICTURE X(3).
           02  TRCF4VCO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF4VNO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF4VMO  PIC X(35).
           02  FILLER PICTURE X(3).
           02  TRCF5SCO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF5SNO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF5SMO  PIC X(35).
           02  FILLER PICTURE X(3).
           02  TRCF5VCO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF5VNO  PIC X(1).
           02  FILLER PICTURE X(3).
           02  TRCF5VMO  PIC X(35).
           02  FILLER PICTURE X(3).
           02  TRCNOO  PIC X(52).
           02  FILLER PICTURE X(3).
           02  TRCMSGO  PIC X(79).
