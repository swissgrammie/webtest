       01  SHOWEMI.
           02  FILLER PIC X(12).
           02  DATEL  COMP PIC S9(4).
           02  DATEF  PICTURE X.
           02  FILLER REDEFINES DATEF.
               03  DATEA  PICTURE X.
           02  DATEI  PIC X(10).
           02  TIMEL  COMP PIC S9(4).
           02  TIMEF  PICTURE X.
           02  FILLER REDEFINES TIMEF.
               03  TIMEA  PICTURE X.
           02  TIMEI  PIC X(10).
           02  CNUML  COMP PIC S9(4).
           02  CNUMF  PICTURE X.
           02  FILLER REDEFINES CNUMF.
               03  CNUMA  PICTURE X.
           02  CNUMI  PIC X(10).
           02  NAMEL  COMP PIC S9(4).
           02  NAMEF  PICTURE X.
           02  FILLER REDEFINES NAMEF.
               03  NAMEA  PICTURE X.
           02  NAMEI  PIC X(20).
           02  INVAMTL  COMP PIC S9(4).
           02  INVAMTF  PICTURE X.
           02  FILLER REDEFINES INVAMTF.
               03  INVAMTA  PICTURE X.
           02  INVAMTI  PIC ZZ,ZZZ.ZZ.
           02  MESSL  COMP PIC S9(4).
           02  MESSF  PICTURE X.
           02  FILLER REDEFINES MESSF.
               03  MESSA  PICTURE X.
           02  MESSI  PIC X(40).
       01  SHOWEMO REDEFINES SHOWEMI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  DATEO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  TIMEO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  CNUMO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  NAMEO  PIC X(20).
           02  FILLER PICTURE X(3).
           02  INVAMTO  PIC ZZ,ZZZ.ZZ.
           02  FILLER PICTURE X(3).
           02  MESSO  PIC X(40).
