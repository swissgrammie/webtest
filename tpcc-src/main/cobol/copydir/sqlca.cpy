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
 
      **************************************************************************
      * SQLSTATE is a five character error and warning state of the form SSCCC, 
      * usage of thi is preferred over the deprecated SQLCODE.
      *
      * Standard Values are listed below, but individual databases accessed
      * through JDBC each have their own values in addition to those below.
      *
      * CC	SSS	Condition
      **************************************************************************
      * 00		successful completion
      * 01		warning
      *		001	cursor operation conflict
      *		002	disconnect error
      *		003	null value eliminated in set function
      *		004	string data, right truncation
      *		005	insufficient item descriptor areas
      *		006	privilege not revoked
      *		007	privilege not granted
      *		008	implicit zero-bit padding
      *		009	search condition too long for information schema
      *		00A	query expression too long for information schema
      * 02		no data
      * 07		dynamic SQL error
      * 08		connection exception
      *		001	SQL-client unable to establish SQL-connection
      *		002	connection name in use
      *         003	connection does not exist
      *		004	SQL-server rejected establishment of SQL-connection
      *		006	connection failure
      *		007	transaction resolution unknown
      * 0A		feature not supported
      * 21		cardinality violation
      * 22		data exception
      * 23		integrity constraint violation
      * 24		invalid cursor state
      * 25		invalid transaction state
      * 26		invalid SQL statement name
      * 27		triggered data change violation
      * 28		invalid authorization specification
      * 2A		syntax error or access rule violation in direct SQL statement
      * 2B		dependent privilege descriptors still exit
      * 2C		invalid character set name
      * 2D		invalid transaction termination
      * 2E		invalid connection name
      * 33		invalid SQL descriptor name
      * 34		invalid cursor name
      * 35		invalid condition number
      * 37		syntax error or access rule violation in dynamic SQL statement
      * 3C		ambiguous cursor name
      * 3D		invalid catalog name
      * 3F		invalid schema name
      * 40		transaction rollback
      * 42		syntax error or access rule violation
      * 44		with check option violation
      * HZ		remote database access
      **************************************************************************
       01 SQLSTATE PIC XXXXX.
	 
      **************************************************************************
      * SQLCA -- SQL COMMUNICATIONS AREA                                       *      
      *
      * All communications from PERCobol to SQLCA are done by name, where
      * the name of the variable is, for example, SQLERRML OF SQLCA.  The
      * actual structure of the record is irrelevant to PERCobol as are
      * the usages of the numeric types.  A SQLCA with more fields may
      * be used, but these additional values at the end of the record are
      * not used at present.
      *
      * SQLCAID is always the same value, 'SQLCA', for compatibility.
      *
      * SQLCABC is the byte count for the SQLCA length, this is approximate
      * as different datatype settings will yield different values.  It is
      * present only for named compatibility.
      *
      * SQLCODE is 0 for success, <0 for error, >0 (100) for warning of no data.
      * Its use has been deprecated by ANSI in favor of SQLSTATE.
      *
      * SQLERRMC is the message characters, the text of the SQL exception.
      * PERCobol allows this to be set to any size; some exception text
      * may be unusually long and may be retrieved by increasing this size.
      *
      * SQLERRML is the length of the mesage, which may be longer than the
      * PIC X(n) value of SQLERRMC.  If SQLERRML is longer than SQLERRMC,
      * then it indicates the amount of truncation.
      **************************************************************************
         01 SQLCA.
           05 SQLCAID PIC X(8) VALUE "SQLCA".
           05 SQLCABC PIC S9(9) COMP VALUE 136.
           05 SQLCODE PIC S9(9) COMP.
           05 SQLERRM.
             49 SQLERRML PIC S9(4) COMP.
             49 SQLERRMC PIC X(270). | LJ was x(70)
           05 SQLERRP PIC X(8) VALUE "PRC04000".	     
           05 SQLERRD OCCURS 6 TIMES PIC S9(9) COMP.
           05 SQLWARN.
             49 SQLWARN0 PIC X VALUE SPACES.
             49 SQLWARN1 PIC X VALUE SPACES.
             49 SQLWARN2 PIC X VALUE SPACES.
             49 SQLWARN3 PIC X VALUE SPACES.
             49 SQLWARN4 PIC X VALUE SPACES.
             49 SQLWARN5 PIC X VALUE SPACES.
             49 SQLWARN6 PIC X VALUE SPACES.
             49 SQLWARN7 PIC X VALUE SPACES.
             49 SQLWARN8 PIC X VALUE SPACES.
             49 SQLWARN9 PIC X VALUE SPACES.
             49 SQLWARNA PIC X VALUE SPACES.
	     
