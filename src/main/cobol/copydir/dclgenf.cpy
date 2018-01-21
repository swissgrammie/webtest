      ******************************************************************
      * DCLGEN TABLE(TRT.CUSTTAX)                                      *
      *        LIBRARY(TRT085.DB2.ADDCUST(DCLGENF))                    *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HI-)                                              *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE CUSTTAX TABLE
           ( CUSTNO                         INTEGER NOT NULL,
             CUST_NAME                      CHARACTER(20),
             CUST_INVOICE_AMT               DECIMAL(7,2)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE TRT.CUSTTAX                        *
      ******************************************************************
       01 CUSTTAX-TABLE.
          10 CUST-NUM                  PIC 9(10).
          10 CUST-NAME                 PIC X(20).
          10 CUST-INVOICE-AMT          PIC S9(5)V99 USAGE COMP-3.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 7       *
      ******************************************************************