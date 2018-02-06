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
       02  option-array.
           03  option-count                  pic s9(9) comp.
           03  option-debug                  pic s9(9) comp.
           03  option-remove                 pic s9(9) comp.
           03  option-erase                  pic s9(9) comp.
           03  option-create                 pic s9(9) comp.
           03  option-load                   pic s9(9) comp.
           03  option-size                   pic s9(9) comp.
           03  option-display                pic s9(9) comp.
               88  option-return-display-88  value -1.
           03  option-data.
               05  option-line               pic x(80) occurs 24 times.
       copy cpycomon.
      ***--------------------------------------------------------------*
      ***  $Workfile:   tpccoptn.cpy  $ end
      ***--------------------------------------------------------------*
