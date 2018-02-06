       identification division.

       program-id. sqlload.

       author.    Heirloom Computing Inc.
       
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

      *=================================================================
      * Load TPCC tables
      *=================================================================
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
LJ     SOURCE-COMPUTER. JVM with debugging mode. | SETS DEBUGGING ON
       SPECIAL-NAMES.
LJ    * IMPLEMENTOR clause.
LJ     SYSERR IS OUTERR. | DISPLAY goes to SYSERR
LJ    * SYSOUT IS OUTERR.
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  ws-program-name                   pic x(8) value 'SQLLOAD '.

       01  L-MAXITEMS                        pic 9(9) comp
           value 100000.
       01  L-DIST-PER-WARE                   pic 9(9) comp value 10.
       01  L-CUST-PER-DIST                   pic 9(9) comp value 3000.
       01  L-ORD-PER-DIST                    pic 9(9) comp value 3000.
       01  L-UNDEL-ORD-BASE                  pic 9(9) comp value 2100.
       01  L-MIN-NAME                        pic 9(9) comp value 0.
       01  L-MAX-NAME                        pic 9(9) comp value 999.
       01  L-NAME-A                          pic 9(9) comp value 255.
       01  L-NAME-C                          pic 9(9) comp value 17.

       01  S-MAXITEMS                        pic 9(9) comp value 1000.
       01  S-DIST-PER-WARE                   pic 9(9) comp value 2.
       01  S-CUST-PER-DIST                   pic 9(9) comp value 300.
       01  S-ORD-PER-DIST                    pic 9(9) comp value 300.
       01  S-UNDEL-ORD-BASE                  pic 9(9) comp value 210.
       01  S-MIN-NAME                        pic 9(9) comp value 0.
       01  S-MAX-NAME                        pic 9(9) comp value 99.
       01  S-NAME-A                          pic 9(9) comp value 23.
       01  S-NAME-C                          pic 9(9) comp value 3.

       01  MAXITEMS                          pic 9(9) comp.
       01  DIST-PER-WARE                     pic 9(9) comp.
       01  CUST-PER-DIST                     pic 9(9) comp.
       01  ORD-PER-DIST                      pic 9(9) comp.
       01  UNDEL-ORD-BASE                    pic 9(9) comp.

       01  name-min                          pic 9(9) comp.
       01  name-max                          pic 9(9) comp.
       01  name-a                            pic 9(9) comp.
       01  name-c                            pic 9(9) comp.

       01  ws-time-start                     pic 9(8).
       01  ws-time-end                       pic 9(8).
       01  ws-file-name                      pic x(8).
       01  ws-timer-msg.
          03 ws-timer-start                  pic x(20)
             value 'Started at: hh:mm:ss'.
          03 filler                          pic x(2)
             value ', '.
          03 ws-timer-end                    pic x(18)
             value 'Ended at: hh:mm:ss'.

      * Global SQL Variables
           EXEC SQL INCLUDE SQLCA END-EXEC

           EXEC SQL BEGIN DECLARE SECTION END-EXEC
       01 tstamp           pic X(20).
       01 count-ware       pic S9(9) comp.
           EXEC SQL END DECLARE SECTION END-EXEC

           EXEC SQL INCLUDE TPCC END-EXEC

       01  ws-display.
           03 ws-row                         pic 9(4) comp value 0.
           03 ws-col                         pic 9(4) comp value 0.
           03 ws-cpos                        pic 9(4) comp.
           03 ws-num                         pic +9(9).
           03 ws-display-line                pic x(79).
           03 ws-d-tax                       pic -.9999.
           03 ws-w-tax                       pic -.9999.
           03 ws-i-price                     pic -999.99.
           03 ws-ol-amount                   pic -99999.99.
           03 ws-display-nbr                 pic z(5)9-.
           03 ws-display-nb2                 pic z(5)9-.
           03 ws-display-nb3                 pic z(5)9-.
           03 ws-display-nb4                 pic z(5)9-.

       01  i                                 pic s9(9) comp.

       01  current-tstamp.
           03  todaysdate                   pic 9(8).
           03  filler                        pic x(1) value space.
           03  time-in-secs                  pic 9(8).

       01  A                                 pic s9(9) comp.
       01  C                                 pic s9(9) comp.
       01  rand                              comp-2.
       01  rand-min                          pic s9(9) comp.
       01  rand-min1                         pic s9(9) comp.
       01  rand-max                          pic s9(9) comp.
       01  rand-max1                         pic s9(9) comp.
       01  rand-num                          pic s9(9) comp.
       01  rand-num1                         pic s9(9) comp.

       01  temp                              pic s9(9) comp.
       01  sub1                              pic s9(9) comp.
       01  sub2                              pic s9(9) comp.
       01  sub3                              pic s9(9) comp.

       01  name-num                          pic s9(9) comp.
       01  name-res                          pic x(15).

       01  CHARS                             pic x(62) value
       "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".
       01  DIGITS                            pic x(10) value
       "0123456789".
       01  str-min                           pic s9(9) comp.
       01  str-max                           pic s9(9) comp.
       01  str-ind                           pic s9(9) comp.
       01  str-len                           pic s9(9) comp.
       01  str-val                           pic x(500).

       01  adr-str1                          pic x(20).
       01  adr-str2                          pic X(20).
       01  adr-city                          pic X(20).
       01  adr-state                         pic X(2).
       01  adr-zip                           pic X(9).

       01 filler.
           03  NN.
               05 filler                     pic x(5) value "BAR".
               05 filler                     pic x(5) value "OUGHT".
               05 filler                     pic x(5) value "ABLE".
               05 filler                     pic x(5) value "PRI".
               05 filler                     pic x(5) value "PRES".
               05 filler                     pic x(5) value "ESE".
               05 filler                     pic x(5) value "ANTI".
               05 filler                     pic x(5) value "CALLY".
               05 filler                     pic x(5) value "ATION".
               05 filler                     pic x(5) value "EING".
           03 N redefines NN                 pic x(5) occurs 10.

       01  cust-temp                         pic s9(9) comp.

       01  filler.
           03  cust-perm                     pic s9(9) comp
                                               occurs 3000.

       01  sdatasiz                          pic s9(9) comp.
       01  idatasiz                          pic s9(9) comp.
       01  filler.
           03  orig                          pic s9(9) comp
                                               occurs 100000.
       01  posn                              pic s9(9) comp.

       linkage section.

       01 DFHCOMMAREA.

       copy tpccoptn.


       PROCEDURE DIVISION.
      *=================================================================
      *      MAIN ROUTINE
      * ARGUMENTS
      *      Warehouses n �Debug� �Help�
      *=================================================================
       MAIN SECTION.
       main-para.
           exec cics send control erase end-exec

      *    exec sql set log off end-exec

           if option-remove not = 0
               move 'Remove Database'  to ws-display-line
               perform display-line
               exec sql whenever sqlerror continue end-exec
               exec cics syncpoint end-exec
               exec sql whenever sqlerror go to sqlerror end-exec
           end-if

           if option-size = 0
               move 'Small Database'   to ws-display-line
               perform display-line
               move S-MAXITEMS to MAXITEMS
               move S-DIST-PER-WARE to DIST-PER-WARE
               move S-CUST-PER-DIST to CUST-PER-DIST
               move S-ORD-PER-DIST to ORD-PER-DIST
               move S-UNDEL-ORD-BASE to UNDEL-ORD-BASE
               move S-MIN-NAME to name-min
               move S-MAX-NAME to name-max
               move S-NAME-A to name-a
               move S-NAME-C to name-c
           else
               move 'Large Database'   to ws-display-line
               perform display-line
               move L-MAXITEMS to MAXITEMS
               move L-DIST-PER-WARE to DIST-PER-WARE
               move L-CUST-PER-DIST to CUST-PER-DIST
               move L-ORD-PER-DIST to ORD-PER-DIST
               move L-UNDEL-ORD-BASE to UNDEL-ORD-BASE
               move L-MIN-NAME to name-min
               move L-MAX-NAME to name-max
               move L-NAME-A to name-a
               move L-NAME-C to name-c
           end-if

           move option-count to count-ware

           if option-create not = 0
               move 'Create tables'   to ws-display-line
               perform display-line
      * create tables moved to separate script
               exec cics syncpoint end-exec

           end-if

           if option-erase not = 0
               move 'Erase existing data'   to ws-display-line
               perform display-line
               exec sql delete from order_line end-exec
               exec sql delete from new_order end-exec
               exec sql delete from orders end-exec
               exec sql delete from history end-exec
               exec sql delete from customer end-exec
               exec sql delete from district end-exec
               exec sql delete from stock end-exec
               exec sql delete from item end-exec
               exec sql delete from warehouse end-exec
               exec cics syncpoint end-exec
           end-if

           if option-load not = 0
      *        *> Initialize tstamp (for date columns)
      *        *> and seed random numbers from current time
               accept todaysdate from date yyyymmdd
               accept time-in-secs from time
      *        *> Note that XDB requires a - between date and time parts
      *        *> where ODBC specifies a space
               move spaces to tstamp
               string
      *            "{ts '"           delimited by size
                   todaysdate(1:4)  delimited by size
                   "-"               delimited by size
                   todaysdate(5:2)  delimited by size
                   "-"               delimited by size
                   todaysdate(7:2)  delimited by size
                   " "               delimited by size
                   time-in-secs(1:2) delimited by size
                   ":"               delimited by size
                   time-in-secs(3:2) delimited by size
                   ":"               delimited by size
                   time-in-secs(5:2) delimited by size
      *            "."               delimited by size
      *            time-in-secs(7:2) delimited by size
      *            "'}"              delimited by size
               into tstamp

               compute i = function random(time-in-secs)

               move 'TPCC Data Load Starting '   to ws-display-line
               perform display-line

               accept ws-time-start from time

               perform LoadItems
               perform LoadWare
               perform LoadCust
               perform LoadOrd

               EXEC CICS SYNCPOINT END-EXEC

               move 'TPCC Data Load Completed.'  to ws-display-line
               perform display-line
               accept ws-time-end from time
               move ws-time-start(1:2) to ws-timer-start(13:2)
               move ws-time-start(3:2) to ws-timer-start(16:2)
               move ws-time-start(5:2) to ws-timer-start(19:2)
               move ws-time-end(1:2) to ws-timer-end(11:2)
               move ws-time-end(3:2) to ws-timer-end(14:2)
               move ws-time-end(5:2) to ws-timer-end(17:2)
               move ws-timer-msg to ws-display-line
               perform display-line
           end-if

      *    exec sql set log on end-exec
           move 0 to return-code
           exec cics return end-exec.

      *=================================================================
      * Misc support routines
      *
      *=================================================================
       RandomNumber section.
       RandomNumber-para.
           compute rand = function random
           compute rand-num = (rand * (rand-max - rand-min))
               + rand-min
           exit.

       NURand section.
       NURand-para.
           perform RandomNumber
      *    *> computed using min, max
           move rand-num to rand-num1
           move rand-min to rand-min1
           move rand-max to rand-max1
           move 0 to rand-min
           move A to rand-max
           perform RandomNumber
      *    call "CBL_OR" using rand-num, rand-num1,
      *            by value length rand-num

      *    This is a bitwise or using standard integer arithmetic
      *    Done inline to try to minimise speed penalty
      *    Spec only uses this up to 100,000, so only need to do 17 bits

      *    If bit already set in destination, nothing more to do
           if function mod (rand-num1, 2) = 0
      *        Otherwise must set bit if it's set in source
               if function mod(rand-num, 2) not = 0
      *            Can or using add because there will be no carry
                   add 1 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 4) < 2
               if function mod(rand-num, 4) >= 2
                   add 2 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 8) < 4
               if function mod(rand-num, 8) >= 4
                   add 4 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 16) < 8
               if function mod(rand-num, 16) >= 8
                   add 8 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 32) < 16
               if function mod(rand-num, 32) >= 16
                   add 16 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 64) < 32
               if function mod(rand-num, 64) >= 32
                   add 32 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 128) < 64
               if function mod(rand-num, 128) >= 64
                   add 64 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 256) < 128
               if function mod(rand-num, 256) >= 128
                   add 128 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 512) < 256
               if function mod(rand-num, 512) >= 256
                   add 256 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 1024) < 512
               if function mod(rand-num, 1024) >= 512
                   add 512 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 2048) < 1024
               if function mod(rand-num, 2048) >= 1024
                   add 1024 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 4096) < 2048
               if function mod(rand-num, 4096) >= 2048
                   add 2048 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 8192) < 4096
               if function mod(rand-num, 8192) >= 4096
                   add 4096 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 16384) < 8192
               if function mod(rand-num, 16384) >= 8192
                   add 8192 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 32768) < 16384
               if function mod(rand-num, 32768) >= 16384
                   add 16384 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 65536) < 32768
               if function mod(rand-num, 65536) >= 32768
                   add 32768 to rand-num1
               end-if
           end-if

           if function mod (rand-num1, 131072) < 65536
               if function mod(rand-num, 131072) >= 65536
                   add 65536 to rand-num1
               end-if
           end-if

           add C to rand-num1
           compute temp = rand-max1 - rand-min1 + 1
           compute rand-num =
               function mod(rand-num1, temp)
                           + rand-min1

           exit.

       MakeAlphaString section.
       MakeAlphaString-para.
           move spaces to str-val
           move str-min to rand-min
           move str-max to rand-max
           perform RandomNumber
           move rand-num to str-len

           move 1 to rand-min
           move length CHARS to rand-max
           perform varying str-ind from 1 by 1 until str-ind > str-len
               perform RandomNumber
               move CHARS(rand-num:1) to str-val(str-ind:1)
           end-perform
           exit.

       MakeNumberString section.
       MakeNumberString-para.
           move spaces to str-val
           move str-min to rand-min
           move str-max to rand-max
           perform RandomNumber
           move rand-num to str-len

           move 0 to rand-min
           move 9 to rand-max
           perform varying str-ind from 1 by 1 until str-ind > str-len
               perform RandomNumber
               move DIGITS(rand-num + 1:1) to str-val(str-ind:1)
           end-perform
           exit.

      *=================================================================
      * ROUTINE NAME
      *      LoadItems
      * DESCRIPTION
      *      Loads the Item table
      * ARGUMENTS
      *      none
      *=================================================================
       LoadItems section.
       LoadItems-para.
           move 'Loading Item'         to ws-display-line
           perform display-line
           perform varying i from 1 by 1 until i > MAXITEMS
               move 0 to orig(i)
           end-perform

           perform varying i from 1 by 1 until i > MAXITEMS/10
               perform with test after until orig(posn) = 0
                   move 1 to rand-min
                   move MAXITEMS to rand-max
                   perform RandomNumber
                   move rand-num to posn
               end-perform
               move 1 to orig(posn)
           end-perform
           perform varying i-id from 1 by 1 until i-id > MAXITEMS
      *        *> Generate Item Data
               move 14 to str-min
               move 24 to str-max
               perform MakeAlphaString
               move str-val(1:length i-name) to i-name

               move 100 to rand-min
               move 10000 to rand-max
               perform RandomNumber
               compute i-price = rand-num/100.0

               move 26 to str-min
               move 50 to str-max
               perform MakeAlphaString
               move str-val(1:length i-data) to i-data
               move str-len to idatasiz

               if orig(i-id) not = 0
                   move 1 to rand-min
                   compute rand-max = idatasiz - 8
                   perform RandomNumber
                   move rand-num to posn
                   string
                       "original" delimited size
                   into i-data pointer posn
               end-if

               if option-debug not = 0
                   move i-id           to ws-display-nbr
                   move i-price        to ws-i-price
                   string  "IID = " ws-display-nbr ", Name= " i-name
                           ", Price = " ws-i-price
                     delimited by size into ws-display-line
                   perform display-line
               end-if
               EXEC SQL INSERT INTO
                   item (i_id, i_im_id, i_name, i_price, i_data)
                       values (:i-id, 0, :i-name, :i-price, :i-data)
               END-EXEC

               if function mod(i-id, 100) = 0
                   if not option-return-display-88
                       display "." with no advancing
                       if function mod(i-id, 5000) = 0
                           display " " i-id
                       end-if
                   else
                       perform display-dot
                       if function mod(i-id, 5000) = 0
                           move i-id to ws-num
                           perform display-number
                       end-if
                   end-if
                   exec cics syncpoint end-exec
               end-if
           end-perform
           EXEC CICS SYNCPOINT END-EXEC
           move 'Item Done.'           to ws-display-line
           perform display-line

           exit.

      *=================================================================
      * ROUTINE NAME
      *      LoadWare
      * DESCRIPTION
      *      Loads the Warehouse table
      *      Loads Stock, District as Warehouses are created
      * ARGUMENTS
      *      none
      *=================================================================
       LoadWare section.
       LoadWare-para.
sc-a48     move 'Loading Warehouse'    to ws-display-line
sc-a48     perform display-line
           perform varying w-id from 1 by 1 until  w-id > count-ware
      *        *> Generate Warehouse Data
               move 6 to str-min
               move 10 to str-max
               perform MakeAlphaString
               move str-val(1:length w-name) to w-name

               perform MakeAddress
               move adr-str1 to w-street-1
               move adr-str2 to w-street-2
               move adr-city to w-city
               move adr-state to w-state
               move adr-zip to w-zip

               move 10 to rand-min
               move 20 to rand-max
               perform RandomNumber
               compute w-tax =  rand-num / 100.0

               move 300000.00 to w-ytd

               if option-debug not = 0
sc-a48*            display "WID = " w-id ", Name = "w-name
sc-a48*                    ", Tax = " w-tax
sc-a48             move w-id           to ws-display-nbr
sc-a48             move w-tax          to ws-w-tax
sc-a48             string  "WID = " ws-display-nbr ", Name = "w-name
sc-a48                     ", Tax = " ws-w-tax
sc-a48              delimited by size  into ws-display-line
               end-if
               EXEC SQL INSERT INTO
                   warehouse (w_id, w_name,
                       w_street_1, w_street_2,
                       w_city, w_state, w_zip,
                       w_tax, w_ytd)
                   values (:w-id, :w-name,
                       :w-street-1, :w-street-2, :w-city, :w-state,
                       :w-zip, :w-tax, :w-ytd)
               END-EXEC
      *        *> Make Rows associated with Warehouse
               perform Stock
               perform District
               EXEC CICS SYNCPOINT END-EXEC
           end-perform
           exit.

      *=================================================================
      * ROUTINE NAME
      *      LoadCust
      * DESCRIPTION
      *      Loads the Customer Table
      * ARGUMENTS
      *      none
      *=================================================================
       LoadCust section.
       LoadCust-para.
sc-a48     move 'Loading Customer'     to ws-display-line
sc-a48     perform display-line
           perform varying w-id from 1 by 1 until w-id > count-ware
               perform varying d-id from 1 by 1
                       until d-id > DIST-PER-WARE
                   perform Customer
               end-perform
           end-perform

      *   *> Just in case
           EXEC CICS SYNCPOINT END-EXEC
           exit.

      *=================================================================
      * ROUTINE NAME
      *      LoadOrd
      * DESCRIPTION
      *      Loads the Orders and Order-Line Tables
      * ARGUMENTS
      *      none
      *=================================================================
       LoadOrd section.
       LoadOrd-para.
           move 'Loading Orders'     to ws-display-line
           perform display-line
           perform varying w-id from 1 by 1 until w-id > count-ware
               perform varying d-id from 1 by 1
                       until d-id > DIST-PER-WARE
                   perform Orders
               end-perform
           end-perform

      *    *> Just in case
           EXEC CICS SYNCPOINT END-EXEC
           exit.

      *=================================================================
      * ROUTINE NAME
      *      Stock
      * DESCRIPTION
      *      Loads the Stock table
      * ARGUMENTS
      *      w-id - warehouse id
      *=================================================================
       Stock section.
       Stock-para.
sc-a48     move w-id                   to ws-display-nbr
sc-a48     string  "Loading Stock Wid = " ws-display-nbr
sc-a48       delimited by size         into ws-display-line
sc-a48     perform display-line
           move w-id to s-w-id

           perform varying i from 1 by 1 until i > MAXITEMS
               move 0 to orig(i)
           end-perform

           perform varying i from 1 by 1 until i > MAXITEMS/10
               perform with test after until orig(posn) = 0
                   move 1 to rand-min
                   move MAXITEMS to rand-max
                   perform RandomNumber
                   move rand-num to posn
               end-perform
               move 1 to orig(posn)
           end-perform

           perform varying s-i-id from 1 by 1 until s-i-id > MAXITEMS
      *        *> Generate Stock Data
               move 10 to rand-min
               move 100 to rand-max
               perform RandomNumber
               move rand-num to s-quantity

               move 24 to str-min
               move 24 to str-max
               perform MakeAlphaString
               move str-val(1:length s-dist-01) to s-dist-01
               perform MakeAlphaString
               move str-val(1:length s-dist-02) to s-dist-02
               perform MakeAlphaString
               move str-val(1:length s-dist-03) to s-dist-03
               perform MakeAlphaString
               move str-val(1:length s-dist-04) to s-dist-04
               perform MakeAlphaString
               move str-val(1:length s-dist-05) to s-dist-05
               perform MakeAlphaString
               move str-val(1:length s-dist-06) to s-dist-06
               perform MakeAlphaString
               move str-val(1:length s-dist-07) to s-dist-07
               perform MakeAlphaString
               move str-val(1:length s-dist-08) to s-dist-08
               perform MakeAlphaString
               move str-val(1:length s-dist-09) to s-dist-09
               perform MakeAlphaString
               move str-val(1:length s-dist-10) to s-dist-10

               move 26 to str-min
               move 50 to str-max
               perform MakeAlphaString
               move str-val(1:length s-data) to s-data
               move str-len to sdatasiz


               if orig(s-i-id) not = 0
                   move 1 to rand-min
                   compute rand-max =  sdatasiz - 8
                   perform RandomNumber
                   move rand-num to posn
                   move "original" to s-data(posn:posn + 8)
               end-if

               EXEC SQL INSERT INTO
                   stock (s_i_id, s_w_id, s_quantity,
                      s_dist_01, s_dist_02, s_dist_03, s_dist_04,
                      s_dist_05, s_dist_06, s_dist_07, s_dist_08,
                      s_dist_09, s_dist_10,
                      s_data, s_ytd, s_order_cnt, s_remote_cnt)
                   values (:s-i-id, :s-w-id, :s-quantity,
                      :s-dist-01, :s-dist-02, :s-dist-03, :s-dist-04,
                      :s-dist-05, :s-dist-06, :s-dist-07, :s-dist-08,
                      :s-dist-09, :s-dist-10,
                      :s-data, 0, 0, 0)
               END-EXEC

               if option-debug not = 0
sc-a48*            display "SID = " s-i-id ", WID = " s-w-id
sc-a48*                 ", Quan = " s-quantity
sc-a48             move s-i-id         to ws-display-nbr
sc-a48             move s-w-id         to ws-display-nb2
sc-a48             move s-quantity     to ws-display-nb3
sc-a48             string  "SID = " ws-display-nbr ", WID = "
sc-a48                  ws-display-nb2 ", Quan = " ws-display-nb3
sc-a48              delimited by size  into ws-display-line
sc-a48             perform display-line
               end-if

               if function mod(s-i-id, 100) = 0
                   exec cics syncpoint end-exec
                   if not option-return-display-88
                       display "." with no advancing
                       if function mod(s-i-id, 5000) = 0
                           display " " s-i-id
                       end-if
                   else
                       perform display-dot
                       if function mod(s-i-id, 5000) = 0
                           move s-i-id to ws-num
                           perform display-number
                       end-if
                   end-if
               end-if
           end-perform

           EXEC CICS SYNCPOINT END-EXEC
sc-a48*    display " Stock Done."
sc-a48     move ' Stock Done.'         to ws-display-line
sc-a48     perform display-line
           exit.

      *=================================================================
      * ROUTINE NAME
      *      District
      * DESCRIPTION
      *      Loads the District table
      * ARGUMENTS
      *      w-id - warehouse id
      *=================================================================
       District section.
       District-para.
sc-a48     move 'Loading District'     to ws-display-line
sc-a48     perform display-line
           move w-id to d-w-id
           move 30000.0 to d-ytd
           move 3001 to d-next-o-id
           perform varying d-id from 1 by 1 until d-id > DIST-PER-WARE
      *        *> Generate District Data
               move 6 to str-min
               move 10 to str-max
               perform MakeAlphaString
               move str-val(1:length d-name) to d-name

               perform MakeAddress
               move adr-str1 to d-street-1
               move adr-str2 to d-street-2
               move adr-city to d-city
               move adr-state to d-state
               move adr-zip  to d-zip

               move 10 to rand-min
               move 20 to rand-max
               perform RandomNumber
               compute d-tax = rand-num / 100.0;

               EXEC SQL INSERT INTO
                   district (d_id, d_w_id, d_name,
                         d_street_1, d_street_2, d_city, d_state, d_zip,
                         d_tax, d_ytd, d_next_o_id)
                   values (:d-id, :d-w-id, :d-name,
                    :d-street-1, :d-street-2, :d-city, :d-state, :d-zip,
                    :d-tax, :d-ytd, :d-next-o-id)
               END-EXEC

               if option-debug not = 0
sc-a48*            display "DID = " d-id
sc-a48*                 ", WID = " d-w-id
sc-a48*                 ", Name = " d-name
sc-a48*                 ", Tax = " d-tax
sc-a48             move d-id           to ws-display-nbr
sc-a48             move d-w-id         to ws-display-nb2
sc-a48             move d-tax          to ws-d-tax
sc-a48             string  "DID = " ws-display-nbr
sc-a48                  ", WID = " ws-display-nb2
sc-a48                  ", Name = " d-name
sc-a48                  ", Tax = " ws-d-tax
sc-a48               delimited by size into ws-display-line
sc-a48             perform display-line
sc-a48         end-if

           end-perform

           EXEC CICS SYNCPOINT END-EXEC

           exit.


      *=================================================================
      * ROUTINE NAME
      *      Customer
      * DESCRIPTION
      *      Loads Customer Table
      *      Also inserts corresponding history record
      * ARGUMENTS
      *      id   - customer id
      *      d-id - district id
      *      w-id - warehouse id
      *=================================================================
       Customer section.
       Customer-para.
sc-a48     move d-id                   to ws-display-nbr
sc-a48     move w-id                   to ws-display-nb2
sc-a48     string  "Loading Customer for D= " ws-display-nbr
sc-a48             ", WID = " ws-display-nb2
sc-a48             delimited by size   into ws-display-line
sc-a48     perform display-line

           perform varying c-id from 1 by 1 until c-id > CUST-PER-DIST
      *        *> Generate Customer Data
               move d-id to c-d-id
               move w-id to c-w-id

               move 8 to str-min
               move 16 to str-max
               perform MakeAlphaString
               move str-val(1: length c-first) to c-first
               move "OE" to c-middle
               if c-id <= 1000
                   compute name-num = c-id
                   perform Lastname
                   move name-res to c-last
               else
                   move name-min to rand-min
                   move name-max to rand-max
                   move name-A to A
                   move name-C to C
                   perform NURand
                   move rand-num to name-num
                   perform Lastname
                   move name-res to c-last
               end-if

               perform MakeAddress
               move adr-str1 to c-street-1
               move adr-str2 to c-street-2
               move adr-city to c-city
               move adr-state to c-state
               move adr-zip to  c-zip

               move 16 to str-min
               move 16 to str-max
               perform MakeNumberString
               move str-val(1: length c-phone) to c-phone

               move 0 to rand-min
               move 1 to rand-max
               perform RandomNumber
               if rand-num not = 0
                   move "GC" to c-credit
               else
                   move "BC" to c-credit
               end-if

               move 50000 to c-credit-lim

               move 0 to rand-min
               move 50 to rand-max
               perform RandomNumber
               compute c-discount = rand-num /100.0

               move -10.0 to c-balance

               move 300 to str-min
               move 500 to str-max
               perform MakeAlphaString
gg-01 *        move str-val(1:length c-data) to c-data
gg-01          move length c-data-data to c-data-len
gg-01          move str-val(1:length c-data-data) to c-data-data

               EXEC SQL INSERT INTO
                 customer (c_id, c_d_id, c_w_id,
                           c_first, c_middle, c_last,
                           c_street_1, c_street_2, c_city, c_state,
                           c_zip, c_phone, c_since, c_credit,
                           c_credit_lim, c_discount, c_balance, c_data,
                           c_ytd_payment, c_payment_cnt, c_delivery_cnt)
                 values (:c-id, :c-d-id, :c-w-id,
                           :c-first, :c-middle, :c-last,
                           :c-street-1, :c-street-2, :c-city, :c-state,
                           :c-zip, :c-phone, :tstamp, :c-credit,
                           :c-credit-lim, :c-discount, :c-balance,
                           :c-data, 10.0, 1, 0)
               END-EXEC

               move 10.0 to h-amount

               move 12 to str-min
               move 24 to str-max
               perform MakeAlphaString
               move str-val(1: length h-data) to h-data

               EXEC SQL INSERT INTO
                   history (h_c_id, h_c_d_id, h_c_w_id,
                           h_w_id, h_d_id, h_date, h_amount, h_data)
                   values (:c-id, :c-d-id, :c-w-id,
                           :c-w-id, :c-d-id, :tstamp, :h-amount,
                           :h-data)
               END-EXEC

               if option-debug not = 0
sc-a48*            display "CID = " c-id ", LST = "c-last
sc-a48*                    ", P# = " c-phone
sc-a48             move c-id           to ws-display-nbr
sc-a48             string  "CID = " ws-display-nbr ", LST = "c-last
sc-a48                     ", P# = " c-phone
sc-a48              delimited by size  into ws-display-line
sc-a48             perform display-line
               end-if
               if function mod(c-id, 100) = 0
                   exec cics syncpoint end-exec
                   if not option-return-display-88
                       display "." with no advancing
                       if function mod(c-id, 1000) = 0
                           display " " c-id
                       end-if
                   else
                       perform display-dot
                       if function mod(c-id, 5000) = 0
                           move c-id to ws-num
                           perform display-number
                       end-if
                   end-if
               end-if
           end-perform

sc-a48*    display "Customer Done."
sc-a48     move 'Customer Done.'       to ws-display-line
sc-a48     perform display-line

           exit.

      *=================================================================
      * ROUTINE NAME
      *      Orders
      * DESCRIPTION
      *      Loads the Orders table
      *      Also loads the Order-Line table on the fly
      * ARGUMENTS
      *      w-id - warehouse id
      *=================================================================
       Orders section.
       Orders-para.
sc-a48     move c-id           to ws-display-nbr
sc-a48     move d-id                   to ws-display-nbr
sc-a48     move w-id                   to ws-display-nb2
sc-a48     string  "Loading Orders for D = " ws-display-nbr
sc-a48             ", W = " ws-display-nb2
sc-a48       delimited by size         into ws-display-line
sc-a48     perform display-line
           move d-id to o-d-id
           move w-id to o-w-id

      *    *>initialize permutation of customer numbers
           perform varying i from 1 by 1 until i > ORD-PER-DIST
               move i to cust-perm(i)
           end-perform
      *    *> random shuffle
           perform varying i from 1 by 1 until i > ORD-PER-DIST
               move i to rand-min
               move ORD-PER-DIST to rand-max
               perform RandomNumber
               move cust-perm(i) to cust-temp
               move cust-perm(rand-num) to cust-perm(i)
               move cust-temp to cust-perm(rand-num)
           end-perform

           perform varying o-id from 1 by 1 until o-id > ORD-PER-DIST

      *        *> Generate Order Data
               move cust-perm(o-id) to o-c-id

               move 1 to rand-min
               move 10 to rand-max
               perform RandomNumber
               move rand-num to o-carrier-id

               move 5 to rand-min
               move 15 to rand-max
               perform RandomNumber
               move rand-num to o-ol-cnt

               if o-id > UNDEL-ORD-BASE
      *            *> the last 900 orders have not been delivered)

                   EXEC SQL INSERT INTO
                       orders  (o_id, o_c_id, o_d_id, o_w_id,
                         o_entry_d, o_carrier_id, o_ol_cnt, o_all_local)
                       values (:o-id, :o-c-id, :o-d-id, :o-w-id,
                           :tstamp, NULL, :o-ol-cnt, 1)
                   END-EXEC
                   EXEC SQL INSERT INTO
                       new_order (no_o_id, no_d_id, no_w_id)
                       values (:o-id, :o-d-id, :o-w-id)
                   END-EXEC

               else
      *            EXEC SQL INSERT INTO
      *                new_order (no_o_id, no_d_id, no_w_id)
      *                values (:o-id, :o-d-id, :o-w-id)
      *            END-EXEC


                   EXEC SQL INSERT INTO
                       orders (o_id, o_c_id, o_d_id, o_w_id,
                         o_entry_d, o_carrier_id, o_ol_cnt, o_all_local)
                       values (:o-id, :o-c-id, :o-d-id, :o-w-id,
                         :tstamp, :o-carrier-id, :o-ol-cnt, 1)
                   END-EXEC
               end-if

               if option-debug not = 0
sc-a48*            display "OID = " o-id
sc-a48*                    ", CID = " o-c-id
sc-a48*                    ", DID = " o-d-id
sc-a48*                    ", WID = " o-w-id
sc-a48             move o-id           to ws-display-nbr
sc-a48             move o-c-id         to ws-display-nb2
sc-a48             move o-d-id         to ws-display-nb3
sc-a48             move o-w-id         to ws-display-nb4
sc-a48             string  "OID = " ws-display-nbr
sc-a48                     ", CID = " ws-display-nb2
sc-a48                     ", DID = " ws-display-nb3
sc-a48                     ", WID = " ws-display-nb4
sc-a48               delimited by size into ws-display-line
sc-a48             perform display-line
               end-if

               perform varying ol-number from 1 by 1
                       until ol-number > o-ol-cnt
      *            *> Generate Order Line Data */
                   move 1 to rand-min
                   move MAXITEMS to rand-max
                   perform RandomNumber
                   move rand-num to ol-i-id

                   move o-w-id to ol-supply-w-id
                   move 5 to ol-quantity
                   move 0.0 to ol-amount

                   move 24 to str-min
                   move 24 to str-max
                   perform MakeAlphaString
                   move str-val(1:length ol-dist-info) to ol-dist-info

                   if o-id > UNDEL-ORD-BASE
                       move 10 to rand-min
                       move 10000 to rand-max
                       perform RandomNumber
                       compute ol-amount = rand-num / 100
                       EXEC SQL INSERT INTO
                           order_line (ol_o_id, ol_d_id, ol_w_id,
                           ol_number, ol_i_id, ol_supply_w_id,
                           ol_quantity, ol_amount, ol_dist_info,
                           ol_delivery_d)
                           values (:o-id, :o-d-id, :o-w-id, :ol-number,
                           :ol-i-id, :ol-supply-w-id, :ol-quantity,
                           :ol-amount, :ol-dist-info, NULL)
                       END-EXEC
                   else
                       EXEC SQL INSERT INTO
                           order_line (ol_o_id, ol_d_id, ol_w_id,
                           ol_number, ol_i_id, ol_supply_w_id,
                           ol_quantity, ol_amount, ol_dist_info,
                           ol_delivery_d)
                           values (:o-id, :o-d-id, :o-w-id, :ol-number,
                           :ol-i-id, :ol-supply-w-id, :ol-quantity,
                           :ol-amount, :ol-dist-info, :tstamp)
                       END-EXEC
                   end-if

                   if option-debug not = 0
sc-a48*                display "OL = " ol-number
sc-a48*                        ", IID = " ol-i-id
sc-a48*                        ", QUAN = " ol-quantity
sc-a48*                        ", AMT = " ol-amount
sc-a48                 move ol-number  to ws-display-nbr
sc-a48                 move ol-i-id    to ws-display-nb2
sc-a48                 move ol-quantity to ws-display-nb3
sc-a48                 move ol-amount   to ws-ol-amount
sc-a48                 string  "OL = " ws-display-nbr
sc-a48                         ", IID = " ws-display-nb2
sc-a48                         ", QUAN = " ws-display-nb3
sc-a48                         ", AMT = " ws-ol-amount
sc-a48                  delimited by size into ws-display-line
sc-a48                 perform display-line
                   end-if
               end-perform

               if function mod(o-id, 10) = 0
                   exec cics syncpoint end-exec
                   if not option-return-display-88
                       if function mod(o-id, 100) = 0
                           display "." with no advancing
                       end-if
                       if function mod(o-id, 500) = 0
                           display " " o-id
                       end-if
                   else
                       perform display-dot
                       if function mod(o-id, 500) = 0
                           move o-id to ws-num
                           perform display-number
                       end-if
                   end-if
               end-if
           end-perform

           EXEC CICS SYNCPOINT END-EXEC

sc-a48*    display "Orders Done."
sc-a48     move 'Orders Done.'         to ws-display-line
sc-a48     perform display-line
           exit.

      *=================================================================
      * ROUTINE NAME
      *      MakeAddress()
      * DESCRIPTION
      *      Build an Address
      * ARGUMENTS
      *=================================================================
       MakeAddress section.
       MakeAddress-para.
           move 10 to str-min
           move 20 to str-max
           perform MakeAlphaString
           move str-val(1:length adr-str1) to adr-str1
           perform MakeAlphaString
           move str-val(1:length adr-str2) to adr-str2
           perform MakeAlphaString
           move str-val(1:length adr-city) to adr-city
           move 2 to str-min
           move 2 to str-max
           perform MakeAlphaString
           move str-val(1:length adr-state) to adr-state
           move 9 to str-min
           move 9 to str-max
           perform MakeNumberString
           move str-val(1:length adr-zip) to adr-zip
           exit.

      *=================================================================
      * ROUTINE NAME
      *      Lastname
      * DESCRIPTION
      *      TPC-C Lastname Function.
      * ARGUMENTS
      *      num  - non-uniform random number
      *      name - last name string
      *=================================================================
       Lastname section.
       Lastname-para.
           move spaces to name-res
gg-01      compute sub1 = function
gg-01        mod((function integer (name-num / 100)), 10) + 1
gg-01      compute sub2 = function
gg-01        mod((function integer (name-num / 10)), 10) + 1
gg-01      compute sub3 = function
gg-01        mod((function integer (name-num / 1)), 10) + 1
           string
               N(sub1)  delimited by space
               N(sub2)  delimited by space
               N(sub3)  delimited by space
           into name-res
           exit.
      *=================================================================
      * ROUTINE NAME
      *      SQLError()
      * DESCRIPTION
      *      Handles an error from a SQL call.
      * ARGUMENTS
      *=================================================================
       SQLError section.
       SQLError-para.
           move sqlcode to csqlcode
sc-a48     string "SQL Error " sqlstate " " csqlcode 
sc-a48       delimited by size         into ws-display-line
sc-a48     perform display-line
mnh        string "SQL Error " sqlerrmc
mnh          delimited by size         into ws-display-line
mnh        perform display-line
mnh        exec java
mnh          System.out.println("SQL Error " + 
mnh             wrk.sqlerrmc_OF_sqlerrm_OF_sqlca);
mnh          System.err.println("SQL Error " + 
mnh             wrk.sqlerrmc_OF_sqlerrm_OF_sqlca);
mnh        end-exec.

           EXEC SQL WHENEVER SQLERROR CONTINUE END-EXEC
           EXEC CICS SYNCPOINT ROLLBACK END-EXEC

      *    exec sql set log on end-exec

           move -1 to return-code
           exec cics return end-exec.

       display-line section.
       display-line-para.
sc-a48     add 1                   to ws-row
sc-a48     if ws-row > 23
sc-a48         move 0              to ws-row
               exec cics send control erase end-exec
sc-a48     end-if
           move 1 to ws-col
           compute ws-cpos = (ws-row * 80) + 1
           move length of ws-display-line to ws-col
           perform until ws-display-line(ws-col:1) not = space
               subtract 1 from ws-col
           end-perform
           add 1 to ws-col
           compute ws-cpos = (ws-row * 80) + 1
           exec cics send control cursor(ws-cpos) end-exec
           add ws-col to ws-cpos
           exec cics
               send text
               from(ws-display-line)
               length(ws-col)
           end-exec
           move spaces                 to ws-display-line
sc-a48     add 1                   to ws-row
sc-a48     if ws-row > 23
sc-a48         move 0              to ws-row
               exec cics send control erase end-exec
sc-a48     end-if
           move 1 to ws-col
           compute ws-cpos = (ws-row * 80) + 1
           exit.

       display-dot section.
       display-dot-para.
           move '.' to ws-display-line(1:1)
           exec cics send control cursor(ws-cpos) end-exec
           exec cics
               send text
               from(ws-display-line)
               length(1)
           end-exec
           add 1 to ws-cpos
           exit.

       display-number section.
       display-number-para.
           string
               " "             delimited by size
               ws-num            delimited by size
           into ws-display-line
           exec cics send control cursor(ws-cpos) end-exec
           exec cics
               send text
               from(ws-display-line)
               length(11)
           end-exec
sc-a48     add 1                   to ws-row
sc-a48     if ws-row > 23
sc-a48         move 0              to ws-row
               exec cics send control erase end-exec
sc-a48     end-if
           move 1 to ws-col
           compute ws-cpos = (ws-row * 80) + 1
           exit.

      ***--------------------------------------------------------------*
      ***  $Workfile:   sqlload.cbl  $ end
      ***--------------------------------------------------------------*
