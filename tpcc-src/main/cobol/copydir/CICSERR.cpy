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
           move EIBRESP to cresponse
           move EIBRESP2 to cresponse2
           evaluate EIBRESP
               when 0
                   move "NORMAL" to err-name
               when 1
                   move "ERROR" to err-name
               when 2
                   move "RDATT" to err-name
               when 3
                   move "WRBRK" to err-name
               when 4
                   move "EOF" to err-name
               when 5
                   move "EODS" to err-name
               when 6
                   move "EOC" to err-name
               when 7
                   move "INBFMH" to err-name
               when 8
                   move "ENDINPT" to err-name
               when 9
                   move "NONVAL" to err-name
               when 10
                   move "NOSTART" to err-name
               when 11
                   move "TERMIDERR" to err-name
               when 12
                   move "FILENOTFOUND" to err-name
               when 13
                   move "NOTFND" to err-name
               when 14
                   move "DUPREC" to err-name
               when 15
                   move "DUPKEY" to err-name
               when 16
                   move "INVREQ" to err-name
               when 17
                   move "IOERR" to err-name
               when 18
                   move "NOSPACE" to err-name
               when 19
                   move "NOTOPEN" to err-name
               when 20
                   move "ENDFILE" to err-name
               when 21
                   move "ILLOGIC" to err-name
               when 22
                   move "LENGERR" to err-name
               when 23
                   move "QZERO" to err-name
               when 24
                   move "SIGNAL" to err-name
               when 25
                   move "QBUSY" to err-name
               when 26
                   move "ITEMERR" to err-name
               when 27
                   move "PGMIDERR" to err-name
               when 28
                   move "TRANSIDERR" to err-name
               when 29
                   move "ENDDATA" to err-name
               when 31
                   move "EXPIRED" to err-name
               when 32
                   move "RETPAGE" to err-name
               when 33
                   move "RTEFAIL" to err-name
               when 34
                   move "RTESOME" to err-name
               when 35
                   move "TSIOERR" to err-name
               when 36
                   move "MAPFAIL" to err-name
               when 37
                   move "INVERRTERM" to err-name
               when 38
                   move "INVMPSZ" to err-name
               when 39
                   move "IGREQID" to err-name
               when 40
                   move "OVERFLOW" to err-name
               when 41
                   move "INVLDC" to err-name
               when 42
                   move "NOSTG" to err-name
               when 43
                   move "JIDERR" to err-name
               when 44
                   move "QIDERR" to err-name
               when 45
                   move "NOJBUFSP" to err-name
               when 46
                   move "DSSTAT" to err-name
               when 47
                   move "SELNERR" to err-name
               when 48
                   move "FUNCERR" to err-name
               when 49
                   move "UNEXPIN" to err-name
               when 50
                   move "NOPASSBKRD" to err-name
               when 51
                   move "NOPASSBKWR" to err-name
               when 53
                   move "SYSIDERR" to err-name
               when 54
                   move "ISCINVREQ" to err-name
               when 55
                   move "ENQBUSY" to err-name
               when 56
                   move "ENVDEFERR" to err-name
               when 57
                   move "IGREQCD" to err-name
               when 58
                   move "SESSIONERR" to err-name
               when 59
                   move "SYSBUSY" to err-name
               when 60
                   move "SESSBUSY" to err-name
               when 61
                   move "NOTALLOC" to err-name
               when 62
                   move "CBIDERR" to err-name
               when 63
                   move "INVEXITREQ" to err-name
               when 64
                   move "INVPARTNSET" to err-name
               when 65
                   move "INVPARTN" to err-name
               when 66
                   move "PARTNFAIL" to err-name
               when 69
                   move "USERIDERR" to err-name
               when 70
                   move "NOTAUTH" to err-name
               when 72
                   move "SUPPRESSED" to err-name
               when 80
                   move "NOSPOOL" to err-name
               when 81
                   move "TERMERR" to err-name
               when 82
                   move "ROLLEDBACK" to err-name
               when 83
                   move "END" to err-name
               when 84
                   move "DISABLED" to err-name
               when 85
                   move "ALLOCERR" to err-name
               when 86
                   move "STRELERR" to err-name
               when 87
                   move "OPENERR" to err-name
               when 88
                   move "SPOLBUSY" to err-name
               when 89
                   move "SPOLERR" to err-name
               when 90
                   move "NODEIDERR" to err-name
               when 91
                   move "TASKIDERR" to err-name
               when 92
                   move "TCIDERR" to err-name
               when 93
                   move "DSNNOTFOUND" to err-name
               when 94
                   move "LOADING" to err-name
               when 95
                   move "MODELIDERR" to err-name
               when 96
                   move "OUTDESCRERR" to err-name
               when 97
                   move "PARTNERIDERR" to err-name
               when 98
                   move "PROFILEIDERR" to err-name
               when 99
                   move "NETNAMERR" to err-name
               when 100
                   move "LOCKED" to err-name
               when 101
                   move "RECORDBUSY" to err-name
               when 102
                   move "UOWNOTFOUND" to err-name
               when 103
                   move "UOWLNOTFOUND" to err-name
               when 104
                   move "LINKABEND" to err-name
               when 105
                   move "CHANGED" to err-name
               when 106
                   move "PROCESSBUSY" to err-name
               when 107
                   move "ACTIVITYBUSY" to err-name
               when 108
                   move "PROCESSERR" to err-name
               when 109
                   move "ACTIVITYERR" to err-name
               when 110
                   move "CONTAINERERR" to err-name
               when 111
                   move "EVENTERR" to err-name
               when 112
                   move "TOKENERR" to err-name
               when 113
                   move "NOTFINISHED" to err-name
               when 114
                   move "POOLERR" to err-name
               when 115
                   move "TIMERERR" to err-name
               when 116
                   move "SYMBOLERR" to err-name
               when 117
                   move "TEMPLATERR" to err-name
               when 121
                   move "RESUNAVAIL" to err-name
           end-evaluate

           string
               'CICS Error - EIBRESP=' delimited size
               cresponse delimited size
               ' RESP2=' delimited by size
               cresponse2 delimited size
               ' RSRCE=' delimited by size
               eibrsrce delimited size
               ' (' delimited size
               err-name delimited by ' '
           into err 

           evaluate eibfn
               when x"0202"
                   move "ADDRESS" to err-fn
               when x"0204"
                   move "HANDLE_CONDITION" to err-fn
               when x"0206"
                   move "HANDLE_AID" to err-fn
               when x"0208"
                   move "ASSIGN" to err-fn
               when x"020A"
                   move "IGNORE_CONDITION" to err-fn
               when x"020C"
                   move "PUSH_HANDLE" to err-fn
               when x"020E"
                   move "POP_HANDLE" to err-fn
               when x"0210"
                   move "ADDRESS_SET" to err-fn
               when x"0402"
                   move "RECEIVE" to err-fn
               when x"0404"
                   move "SEND" to err-fn
               when x"0406"
                   move "CONVERSE" to err-fn
               when x"0408"
                   move "ISSUE_EODS" to err-fn
               when x"040A"
                   move "ISSUE_COPY" to err-fn
               when x"040C"
                   move "WAIT_TERMINAL" to err-fn
               when x"040E"
                   move "ISSUE_LOAD" to err-fn
               when x"0410"
                   move "WAIT_SIGNAL" to err-fn
               when x"0412"
                   move "ISSUE_RESET" to err-fn
               when x"0414"
                   move "ISSUE_DISCONNECT" to err-fn
               when x"0416"
                   move "ISSUE_ENDOUTPUT" to err-fn
               when x"0418"
                   move "ISSUE_ERASEAUP" to err-fn
               when x"041A"
                   move "ISSUE_ENDFILE" to err-fn
               when x"041C"
                   move "ISSUE_PRINT" to err-fn
               when x"041E"
                   move "ISSUE_SIGNAL" to err-fn
               when x"0420"
                   move "ALLOCATE" to err-fn
               when x"0422"
                   move "FREE" to err-fn
               when x"0424"
                   move "POINT" to err-fn
               when x"0426"
                   move "BUILD_ATTACH" to err-fn
               when x"0428"
                   move "EXTRACT_ATTACH" to err-fn
               when x"042A"
                   move "EXTRACT_TCT" to err-fn
               when x"042C"
                   move "WAIT_CONVID" to err-fn
               when x"042E"
                   move "EXTRACT_PROCESS" to err-fn
               when x"0430"
                   move "ISSUE_ABEND" to err-fn
               when x"0432"
                   move "CONNECT_PROCESS" to err-fn
               when x"0434"
                   move "ISSUE_CONFIRMATION" to err-fn
               when x"0436"
                   move "ISSUE_ERROR" to err-fn
               when x"0438"
                   move "ISSUE_PREPARE" to err-fn
               when x"043A"
                   move "ISSUE_PASS" to err-fn
               when x"043C"
                   move "EXTRACT_LOGONMSG" to err-fn
               when x"043E"
                   move "EXTRACT_ATTRIBUTES" to err-fn
               when x"0602"
                   move "READ" to err-fn
               when x"0604"
                   move "WRITE" to err-fn
               when x"0606"
                   move "REWRITE" to err-fn
               when x"0608"
                   move "DELETE" to err-fn
               when x"060A"
                   move "UNLOCK" to err-fn
               when x"060C"
                   move "STARTBR" to err-fn
               when x"060E"
                   move "READNEXT" to err-fn
               when x"0610"
                   move "READPREV" to err-fn
               when x"0612"
                   move "ENDBR" to err-fn
               when x"0614"
                   move "RESETBR" to err-fn
               when x"0802"
                   move "WRITEQ_TD" to err-fn
               when x"0804"
                   move "READQ_TD" to err-fn
               when x"0806"
                   move "DELETEQ_TD" to err-fn
               when x"0A02"
                   move "WRITEQ_TS" to err-fn
               when x"0A04"
                   move "READQ_TS" to err-fn
               when x"0A06"
                   move "DELETEQ_TS" to err-fn
               when x"0C02"
                   move "GETMAIN" to err-fn
               when x"0C04"
                   move "FREEMAIN" to err-fn
               when x"0E02"
                   move "LINK" to err-fn
               when x"0E04"
                   move "XCTL" to err-fn
               when x"0E06"
                   move "LOAD" to err-fn
               when x"0E08"
                   move "RETURN" to err-fn
               when x"0E0A"
                   move "RELEASE" to err-fn
               when x"0E0C"
                   move "ABEND" to err-fn
               when x"0E0E"
                   move "HANDLE_ABEND" to err-fn
               when x"1002"
                   move "ASKTIME" to err-fn
               when x"1004"
                   move "DELAY" to err-fn
               when x"1006"
                   move "POST" to err-fn
               when x"1008"
                   move "START" to err-fn
               when x"1008"
                   move "START_ATTACH" to err-fn
               when x"1008"
                   move "START_BREXIT" to err-fn
               when x"100A"
                   move "RETRIEVE" to err-fn
               when x"100C"
                   move "CANCEL" to err-fn
               when x"1202"
                   move "WAIT_EVENT" to err-fn
               when x"1204"
                   move "ENQ" to err-fn
               when x"1206"
                   move "DEQ" to err-fn
               when x"1208"
                   move "SUSPEND" to err-fn
               when x"1402"
                   move "WRITE_JOURNALNUM" to err-fn
               when x"1404"
                   move "WAIT_JOURNALNUM" to err-fn
               when x"1406"
                   move "WRITE_JOURNALNAME" to err-fn
               when x"1408"
                   move "WAIT_JOURNALNAME" to err-fn
               when x"1602"
                   move "SYNCPOINT" to err-fn
               when x"1802"
                   move "RECEIVE_MAP" to err-fn
               when x"1804"
                   move "SEND_MAP" to err-fn
               when x"1806"
                   move "SEND_TEXT" to err-fn
               when x"1808"
                   move "SEND_PAGE" to err-fn
               when x"180A"
                   move "PURGE_MESSAGE" to err-fn
               when x"180C"
                   move "ROUTE" to err-fn
               when x"180E"
                   move "RECEIVE_PARTN" to err-fn
               when x"1810"
                   move "SEND_PARTNSET" to err-fn
               when x"1812"
                   move "SEND_CONTROL" to err-fn
               when x"1C02"
                   move "DUMP" to err-fn
               when x"1E02"
                   move "ISSUE_ADD" to err-fn
               when x"1E04"
                   move "ISSUE_ERASE" to err-fn
               when x"1E06"
                   move "ISSUE_REPLACE" to err-fn
               when x"1E08"
                   move "ISSUE_ABORT" to err-fn
               when x"1E0A"
                   move "ISSUE_QUERY" to err-fn
               when x"1E0C"
                   move "ISSUE_END" to err-fn
               when x"1E0E"
                   move "ISSUE_RECEIVE" to err-fn
               when x"1E10"
                   move "ISSUE_NOTE" to err-fn
               when x"1E12"
                   move "ISSUE_WAIT" to err-fn
               when x"1E14"
                   move "ISSUE_SEND" to err-fn
               when x"2002"
                   move "BIF_DEEDIT" to err-fn
               when x"2004"
                   move "DEFINE_COUNTER" to err-fn
               when x"2006"
                   move "GET_COUNTER" to err-fn
               when x"2008"
                   move "UPDATE_COUNTER" to err-fn
               when x"200A"
                   move "DELETE_COUNTER" to err-fn
               when x"200C"
                   move "REWIND_COUNTER" to err-fn
               when x"200E"
                   move "QUERY_COUNTER" to err-fn
               when x"2014"
                   move "DEFINE_DCOUNTER" to err-fn
               when x"2016"
                   move "GET_DCOUNTER" to err-fn
               when x"2018"
                   move "UPDATE_DCOUNTER" to err-fn
               when x"201A"
                   move "DELETE_DCOUNTER" to err-fn
               when x"201C"
                   move "REWIND_DCOUNTER" to err-fn
               when x"201E"
                   move "QUERY_DCOUNTER" to err-fn
               when x"3402"
                   move "DEFINE_ACTIVITY" to err-fn
               when x"3404"
                   move "DEFINE_PROCESS" to err-fn
               when x"3406"
                   move "RUN_ACTIVITY" to err-fn
               when x"3408"
                   move "RUN_ACQPROCESS" to err-fn
               when x"340E"
                   move "ACQUIRE_PROCESS" to err-fn
               when x"3410"
                   move "ACQUIRE_ACTIVITYID" to err-fn
               when x"3412"
                   move "DELETE_CONTAINER" to err-fn
               when x"3414"
                   move "GET_CONTAINER" to err-fn
               when x"3416"
                   move "PUT_CONTAINER" to err-fn
               when x"3418"
                   move "RESET_ACTIVITY" to err-fn
               when x"341A"
                   move "CHECK_ACTIVITY" to err-fn
               when x"341C"
                   move "CANCEL_ACTIVITY" to err-fn
               when x"341E"
                   move "CANCEL_ACQPROCESS" to err-fn
               when x"3420"
                   move "SUSPEND_ACTIVITY" to err-fn
               when x"3422"
                   move "SUSPEND_ACQPROCESS" to err-fn
               when x"3424"
                   move "RESUME_ACTIVITY" to err-fn
               when x"3426"
                   move "RESUME_ACQPROCESS" to err-fn
               when x"3428"
                   move "DELETE_ACTIVITY" to err-fn
               when x"342A"
                   move "LINK_ACQPROCESS" to err-fn
               when x"342C"
                   move "LINK_ACTIVITY" to err-fn
               when x"342E"
                   move "CANCEL_ACQACTIVITY" to err-fn
               when x"3430"
                   move "RUN_ACQACTIVITY" to err-fn
               when x"3432"
                   move "LINK_ACQACTIVITY" to err-fn
               when x"3434"
                   move "SUSPEND_ACQACTIVITY" to err-fn
               when x"3436"
                   move "RESUME_ACQACTIVITY" to err-fn
               when x"3438"
                   move "CHECK_ACQPROCESS" to err-fn
               when x"343A"
                   move "CHECK_ACQACTIVITY" to err-fn
               when x"343C"
                   move "RESET_ACQPROCESS" to err-fn
               when x"3602"
                   move "DEFINE_COMPOSITE_EVENT" to err-fn
               when x"3602"
                   move "DEFINE_INPUT_EVENT" to err-fn
               when x"3604"
                   move "DELETE_EVENT" to err-fn
               when x"3608"
                   move "ADD_SUBEVENT" to err-fn
               when x"360A"
                   move "REMOVE_SUBEVENT" to err-fn
               when x"360E"
                   move "TEST_EVENT" to err-fn
               when x"3610"
                   move "RETRIEVE_REATTACH_EVENT" to err-fn
               when x"3612"
                   move "RETRIEVE_SUBEVENT" to err-fn
               when x"3614"
                   move "DEFINE_TIMER" to err-fn
               when x"3616"
                   move "DELETE_TIMER" to err-fn
               when x"3618"
                   move "CHECK_TIMER" to err-fn
               when x"361A"
                   move "FORCE_TIMER" to err-fn
               when x"3802"
                   move "WEB_RECEIVE" to err-fn
               when x"3804"
                   move "WEB_END" to err-fn
               when x"3806"
                   move "WEB_READ" to err-fn
               when x"3808"
                   move "WEB_STARTBROWSE" to err-fn
               when x"380A"
                   move "WEB_READNEXT" to err-fn
               when x"380C"
                   move "WEB_ENDBROWSE_HTTPHEADER" to err-fn
               when x"380E"
                   move "WEB_WRITE" to err-fn
               when x"3810"
                   move "WEB_EXTRACT" to err-fn
               when x"3814"
                   move "WEB_RETRIEVE" to err-fn
               when x"3C02"
                   move "DOCUMENT_CREATE" to err-fn
               when x"3C04"
                   move "DOCUMENT_INSERT" to err-fn
               when x"3C06"
                   move "DOCUMENT_RETRIEVE" to err-fn
               when x"3C08"
                   move "DOCUMENT_SET" to err-fn
               when x"3E0E"
                   move "EXTRACT_TCPIP" to err-fn
               when x"3E10"
                   move "EXTRACT_CERTIFICATE" to err-fn
               when x"4802"
                   move "ENTER_TRACENUM" to err-fn
               when x"4804"
                   move "MONITOR" to err-fn
               when x"4A02"
                   move "ASKTIME_ABSTIME" to err-fn
               when x"4A04"
                   move "FORMATTIME" to err-fn
               when x"5602"
                   move "SPOOLOPEN" to err-fn
               when x"5604"
                   move "SPOOLREAD" to err-fn
               when x"5606"
                   move "SPOOLWRITE" to err-fn
               when x"5610"
                   move "SPOOLCLOSE" to err-fn
               when x"5E06"
                   move "CHANGE_TASK" to err-fn
               when x"5E22"
                   move "WAIT_EXTERNAL" to err-fn
               when x"5E32"
                   move "WAITCICS" to err-fn
               when x"6A02"
                   move "QUERY_SECURITY" to err-fn
               when x"6C02"
                   move "WRITE_OPERATOR" to err-fn
               when x"6C12"
                   move "ISSUE_DFHWTO" to err-fn
               when x"7402"
                   move "SIGNON" to err-fn
               when x"7404"
                   move "SIGNOFF" to err-fn
               when x"7406"
                   move "VERIFY_PASSWORD" to err-fn
               when x"7408"
                   move "CHANGE_PASSWORD" to err-fn
               when x"7E02"
                   move "DUMP_TRANSACTION" to err-fn
           end-evaluate

           string
               'TRMID=' delimited size
               eibtrmid delimited by size
               ' TRNID=' delimited size
               eibtrnid delimited by size
               ' RESP=' delimited by size
               cresponse delimited size
               ' (' delimited size
               err-name delimited by ' '
               ') RESP2=' delimited by size
               cresponse2 delimited size
               ' RSRCE=' delimited by size
               eibrsrce delimited by ' '
               ' FN=' delimited by size
               err-fn delimited ' '
           into td-data

           perform 6 times
           exec cics writeq td
               queue('TPCC')
               from(td-data)
               length(length of td-data)
               resp(response)
           end-exec
                          end-perform




      ***--------------------------------------------------------------*
      ***  $Workfile:   cicserr.cpy  $ end
      ***--------------------------------------------------------------*
