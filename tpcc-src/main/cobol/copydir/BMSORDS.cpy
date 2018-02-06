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
       01  BMSORDSI.
           02  FILLER PIC X(12).
           02  ORDSTRNL  COMP PIC S9(4).
           02  ORDSTRNF  PICTURE X.
           02  FILLER REDEFINES ORDSTRNF.
               03  ORDSTRNA  PICTURE X.
           02  ORDSTRNI  PIC X(4).
           02  ORDSWIDL  COMP PIC S9(4).
           02  ORDSWIDF  PICTURE X.
           02  FILLER REDEFINES ORDSWIDF.
               03  ORDSWIDA  PICTURE X.
           02  ORDSWIDI  PIC X(4).
           02  ORDSDIDL  COMP PIC S9(4).
           02  ORDSDIDF  PICTURE X.
           02  FILLER REDEFINES ORDSDIDF.
               03  ORDSDIDA  PICTURE X.
           02  ORDSDIDI  PIC X(2).
           02  ORDSCIDL  COMP PIC S9(4).
           02  ORDSCIDF  PICTURE X.
           02  FILLER REDEFINES ORDSCIDF.
               03  ORDSCIDA  PICTURE X.
           02  ORDSCIDI  PIC X(4).
           02  ORDSFNML  COMP PIC S9(4).
           02  ORDSFNMF  PICTURE X.
           02  FILLER REDEFINES ORDSFNMF.
               03  ORDSFNMA  PICTURE X.
           02  ORDSFNMI  PIC X(16).
           02  ORDSMNML  COMP PIC S9(4).
           02  ORDSMNMF  PICTURE X.
           02  FILLER REDEFINES ORDSMNMF.
               03  ORDSMNMA  PICTURE X.
           02  ORDSMNMI  PIC X(2).
           02  ORDSLNML  COMP PIC S9(4).
           02  ORDSLNMF  PICTURE X.
           02  FILLER REDEFINES ORDSLNMF.
               03  ORDSLNMA  PICTURE X.
           02  ORDSLNMI  PIC X(16).
           02  ORDSBALL  COMP PIC S9(4).
           02  ORDSBALF  PICTURE X.
           02  FILLER REDEFINES ORDSBALF.
               03  ORDSBALA  PICTURE X.
           02  ORDSBALI  PIC X(9).
           02  ORDSOIDL  COMP PIC S9(4).
           02  ORDSOIDF  PICTURE X.
           02  FILLER REDEFINES ORDSOIDF.
               03  ORDSOIDA  PICTURE X.
           02  ORDSOIDI  PIC X(8).
           02  ORDSEDTL  COMP PIC S9(4).
           02  ORDSEDTF  PICTURE X.
           02  FILLER REDEFINES ORDSEDTF.
               03  ORDSEDTA  PICTURE X.
           02  ORDSEDTI  PIC X(19).
           02  ORDSXIDL  COMP PIC S9(4).
           02  ORDSXIDF  PICTURE X.
           02  FILLER REDEFINES ORDSXIDF.
               03  ORDSXIDA  PICTURE X.
           02  ORDSXIDI  PIC X(2).
           02  ORDSSWHL  COMP PIC S9(4).
           02  ORDSSWHF  PICTURE X.
           02  FILLER REDEFINES ORDSSWHF.
               03  ORDSSWHA  PICTURE X.
           02  ORDSSWHI  PIC X(4).
           02  ORDSITML  COMP PIC S9(4).
           02  ORDSITMF  PICTURE X.
           02  FILLER REDEFINES ORDSITMF.
               03  ORDSITMA  PICTURE X.
           02  ORDSITMI  PIC X(6).
           02  ORDSQTYL  COMP PIC S9(4).
           02  ORDSQTYF  PICTURE X.
           02  FILLER REDEFINES ORDSQTYF.
               03  ORDSQTYA  PICTURE X.
           02  ORDSQTYI  PIC X(2).
           02  ORDSAMTL  COMP PIC S9(4).
           02  ORDSAMTF  PICTURE X.
           02  FILLER REDEFINES ORDSAMTF.
               03  ORDSAMTA  PICTURE X.
           02  ORDSAMTI  PIC X(9).
           02  ORDSDDTL  COMP PIC S9(4).
           02  ORDSDDTF  PICTURE X.
           02  FILLER REDEFINES ORDSDDTF.
               03  ORDSDDTA  PICTURE X.
           02  ORDSDDTI  PIC X(10).
           02  ORDS091L  COMP PIC S9(4).
           02  ORDS091F  PICTURE X.
           02  FILLER REDEFINES ORDS091F.
               03  ORDS091A  PICTURE X.
           02  ORDS091I  PIC X(4).
           02  ORDS092L  COMP PIC S9(4).
           02  ORDS092F  PICTURE X.
           02  FILLER REDEFINES ORDS092F.
               03  ORDS092A  PICTURE X.
           02  ORDS092I  PIC X(6).
           02  ORDS093L  COMP PIC S9(4).
           02  ORDS093F  PICTURE X.
           02  FILLER REDEFINES ORDS093F.
               03  ORDS093A  PICTURE X.
           02  ORDS093I  PIC X(2).
           02  ORDS094L  COMP PIC S9(4).
           02  ORDS094F  PICTURE X.
           02  FILLER REDEFINES ORDS094F.
               03  ORDS094A  PICTURE X.
           02  ORDS094I  PIC X(9).
           02  ORDS095L  COMP PIC S9(4).
           02  ORDS095F  PICTURE X.
           02  FILLER REDEFINES ORDS095F.
               03  ORDS095A  PICTURE X.
           02  ORDS095I  PIC X(10).
           02  ORDS101L  COMP PIC S9(4).
           02  ORDS101F  PICTURE X.
           02  FILLER REDEFINES ORDS101F.
               03  ORDS101A  PICTURE X.
           02  ORDS101I  PIC X(4).
           02  ORDS102L  COMP PIC S9(4).
           02  ORDS102F  PICTURE X.
           02  FILLER REDEFINES ORDS102F.
               03  ORDS102A  PICTURE X.
           02  ORDS102I  PIC X(6).
           02  ORDS103L  COMP PIC S9(4).
           02  ORDS103F  PICTURE X.
           02  FILLER REDEFINES ORDS103F.
               03  ORDS103A  PICTURE X.
           02  ORDS103I  PIC X(2).
           02  ORDS104L  COMP PIC S9(4).
           02  ORDS104F  PICTURE X.
           02  FILLER REDEFINES ORDS104F.
               03  ORDS104A  PICTURE X.
           02  ORDS104I  PIC X(9).
           02  ORDS105L  COMP PIC S9(4).
           02  ORDS105F  PICTURE X.
           02  FILLER REDEFINES ORDS105F.
               03  ORDS105A  PICTURE X.
           02  ORDS105I  PIC X(10).
           02  ORDS111L  COMP PIC S9(4).
           02  ORDS111F  PICTURE X.
           02  FILLER REDEFINES ORDS111F.
               03  ORDS111A  PICTURE X.
           02  ORDS111I  PIC X(4).
           02  ORDS112L  COMP PIC S9(4).
           02  ORDS112F  PICTURE X.
           02  FILLER REDEFINES ORDS112F.
               03  ORDS112A  PICTURE X.
           02  ORDS112I  PIC X(6).
           02  ORDS113L  COMP PIC S9(4).
           02  ORDS113F  PICTURE X.
           02  FILLER REDEFINES ORDS113F.
               03  ORDS113A  PICTURE X.
           02  ORDS113I  PIC X(2).
           02  ORDS114L  COMP PIC S9(4).
           02  ORDS114F  PICTURE X.
           02  FILLER REDEFINES ORDS114F.
               03  ORDS114A  PICTURE X.
           02  ORDS114I  PIC X(9).
           02  ORDS115L  COMP PIC S9(4).
           02  ORDS115F  PICTURE X.
           02  FILLER REDEFINES ORDS115F.
               03  ORDS115A  PICTURE X.
           02  ORDS115I  PIC X(10).
           02  ORDS121L  COMP PIC S9(4).
           02  ORDS121F  PICTURE X.
           02  FILLER REDEFINES ORDS121F.
               03  ORDS121A  PICTURE X.
           02  ORDS121I  PIC X(4).
           02  ORDS122L  COMP PIC S9(4).
           02  ORDS122F  PICTURE X.
           02  FILLER REDEFINES ORDS122F.
               03  ORDS122A  PICTURE X.
           02  ORDS122I  PIC X(6).
           02  ORDS123L  COMP PIC S9(4).
           02  ORDS123F  PICTURE X.
           02  FILLER REDEFINES ORDS123F.
               03  ORDS123A  PICTURE X.
           02  ORDS123I  PIC X(2).
           02  ORDS124L  COMP PIC S9(4).
           02  ORDS124F  PICTURE X.
           02  FILLER REDEFINES ORDS124F.
               03  ORDS124A  PICTURE X.
           02  ORDS124I  PIC X(9).
           02  ORDS125L  COMP PIC S9(4).
           02  ORDS125F  PICTURE X.
           02  FILLER REDEFINES ORDS125F.
               03  ORDS125A  PICTURE X.
           02  ORDS125I  PIC X(10).
           02  ORDS131L  COMP PIC S9(4).
           02  ORDS131F  PICTURE X.
           02  FILLER REDEFINES ORDS131F.
               03  ORDS131A  PICTURE X.
           02  ORDS131I  PIC X(4).
           02  ORDS132L  COMP PIC S9(4).
           02  ORDS132F  PICTURE X.
           02  FILLER REDEFINES ORDS132F.
               03  ORDS132A  PICTURE X.
           02  ORDS132I  PIC X(6).
           02  ORDS133L  COMP PIC S9(4).
           02  ORDS133F  PICTURE X.
           02  FILLER REDEFINES ORDS133F.
               03  ORDS133A  PICTURE X.
           02  ORDS133I  PIC X(2).
           02  ORDS134L  COMP PIC S9(4).
           02  ORDS134F  PICTURE X.
           02  FILLER REDEFINES ORDS134F.
               03  ORDS134A  PICTURE X.
           02  ORDS134I  PIC X(9).
           02  ORDS135L  COMP PIC S9(4).
           02  ORDS135F  PICTURE X.
           02  FILLER REDEFINES ORDS135F.
               03  ORDS135A  PICTURE X.
           02  ORDS135I  PIC X(10).
           02  ORDS141L  COMP PIC S9(4).
           02  ORDS141F  PICTURE X.
           02  FILLER REDEFINES ORDS141F.
               03  ORDS141A  PICTURE X.
           02  ORDS141I  PIC X(4).
           02  ORDS142L  COMP PIC S9(4).
           02  ORDS142F  PICTURE X.
           02  FILLER REDEFINES ORDS142F.
               03  ORDS142A  PICTURE X.
           02  ORDS142I  PIC X(6).
           02  ORDS143L  COMP PIC S9(4).
           02  ORDS143F  PICTURE X.
           02  FILLER REDEFINES ORDS143F.
               03  ORDS143A  PICTURE X.
           02  ORDS143I  PIC X(2).
           02  ORDS144L  COMP PIC S9(4).
           02  ORDS144F  PICTURE X.
           02  FILLER REDEFINES ORDS144F.
               03  ORDS144A  PICTURE X.
           02  ORDS144I  PIC X(9).
           02  ORDS145L  COMP PIC S9(4).
           02  ORDS145F  PICTURE X.
           02  FILLER REDEFINES ORDS145F.
               03  ORDS145A  PICTURE X.
           02  ORDS145I  PIC X(10).
           02  ORDS151L  COMP PIC S9(4).
           02  ORDS151F  PICTURE X.
           02  FILLER REDEFINES ORDS151F.
               03  ORDS151A  PICTURE X.
           02  ORDS151I  PIC X(4).
           02  ORDS152L  COMP PIC S9(4).
           02  ORDS152F  PICTURE X.
           02  FILLER REDEFINES ORDS152F.
               03  ORDS152A  PICTURE X.
           02  ORDS152I  PIC X(6).
           02  ORDS153L  COMP PIC S9(4).
           02  ORDS153F  PICTURE X.
           02  FILLER REDEFINES ORDS153F.
               03  ORDS153A  PICTURE X.
           02  ORDS153I  PIC X(2).
           02  ORDS154L  COMP PIC S9(4).
           02  ORDS154F  PICTURE X.
           02  FILLER REDEFINES ORDS154F.
               03  ORDS154A  PICTURE X.
           02  ORDS154I  PIC X(9).
           02  ORDS155L  COMP PIC S9(4).
           02  ORDS155F  PICTURE X.
           02  FILLER REDEFINES ORDS155F.
               03  ORDS155A  PICTURE X.
           02  ORDS155I  PIC X(10).
           02  ORDS161L  COMP PIC S9(4).
           02  ORDS161F  PICTURE X.
           02  FILLER REDEFINES ORDS161F.
               03  ORDS161A  PICTURE X.
           02  ORDS161I  PIC X(4).
           02  ORDS162L  COMP PIC S9(4).
           02  ORDS162F  PICTURE X.
           02  FILLER REDEFINES ORDS162F.
               03  ORDS162A  PICTURE X.
           02  ORDS162I  PIC X(6).
           02  ORDS163L  COMP PIC S9(4).
           02  ORDS163F  PICTURE X.
           02  FILLER REDEFINES ORDS163F.
               03  ORDS163A  PICTURE X.
           02  ORDS163I  PIC X(2).
           02  ORDS164L  COMP PIC S9(4).
           02  ORDS164F  PICTURE X.
           02  FILLER REDEFINES ORDS164F.
               03  ORDS164A  PICTURE X.
           02  ORDS164I  PIC X(9).
           02  ORDS165L  COMP PIC S9(4).
           02  ORDS165F  PICTURE X.
           02  FILLER REDEFINES ORDS165F.
               03  ORDS165A  PICTURE X.
           02  ORDS165I  PIC X(10).
           02  ORDS171L  COMP PIC S9(4).
           02  ORDS171F  PICTURE X.
           02  FILLER REDEFINES ORDS171F.
               03  ORDS171A  PICTURE X.
           02  ORDS171I  PIC X(4).
           02  ORDS172L  COMP PIC S9(4).
           02  ORDS172F  PICTURE X.
           02  FILLER REDEFINES ORDS172F.
               03  ORDS172A  PICTURE X.
           02  ORDS172I  PIC X(6).
           02  ORDS173L  COMP PIC S9(4).
           02  ORDS173F  PICTURE X.
           02  FILLER REDEFINES ORDS173F.
               03  ORDS173A  PICTURE X.
           02  ORDS173I  PIC X(2).
           02  ORDS174L  COMP PIC S9(4).
           02  ORDS174F  PICTURE X.
           02  FILLER REDEFINES ORDS174F.
               03  ORDS174A  PICTURE X.
           02  ORDS174I  PIC X(9).
           02  ORDS175L  COMP PIC S9(4).
           02  ORDS175F  PICTURE X.
           02  FILLER REDEFINES ORDS175F.
               03  ORDS175A  PICTURE X.
           02  ORDS175I  PIC X(10).
           02  ORDS181L  COMP PIC S9(4).
           02  ORDS181F  PICTURE X.
           02  FILLER REDEFINES ORDS181F.
               03  ORDS181A  PICTURE X.
           02  ORDS181I  PIC X(4).
           02  ORDS182L  COMP PIC S9(4).
           02  ORDS182F  PICTURE X.
           02  FILLER REDEFINES ORDS182F.
               03  ORDS182A  PICTURE X.
           02  ORDS182I  PIC X(6).
           02  ORDS183L  COMP PIC S9(4).
           02  ORDS183F  PICTURE X.
           02  FILLER REDEFINES ORDS183F.
               03  ORDS183A  PICTURE X.
           02  ORDS183I  PIC X(2).
           02  ORDS184L  COMP PIC S9(4).
           02  ORDS184F  PICTURE X.
           02  FILLER REDEFINES ORDS184F.
               03  ORDS184A  PICTURE X.
           02  ORDS184I  PIC X(9).
           02  ORDS185L  COMP PIC S9(4).
           02  ORDS185F  PICTURE X.
           02  FILLER REDEFINES ORDS185F.
               03  ORDS185A  PICTURE X.
           02  ORDS185I  PIC X(10).
           02  ORDS191L  COMP PIC S9(4).
           02  ORDS191F  PICTURE X.
           02  FILLER REDEFINES ORDS191F.
               03  ORDS191A  PICTURE X.
           02  ORDS191I  PIC X(4).
           02  ORDS192L  COMP PIC S9(4).
           02  ORDS192F  PICTURE X.
           02  FILLER REDEFINES ORDS192F.
               03  ORDS192A  PICTURE X.
           02  ORDS192I  PIC X(6).
           02  ORDS193L  COMP PIC S9(4).
           02  ORDS193F  PICTURE X.
           02  FILLER REDEFINES ORDS193F.
               03  ORDS193A  PICTURE X.
           02  ORDS193I  PIC X(2).
           02  ORDS194L  COMP PIC S9(4).
           02  ORDS194F  PICTURE X.
           02  FILLER REDEFINES ORDS194F.
               03  ORDS194A  PICTURE X.
           02  ORDS194I  PIC X(9).
           02  ORDS195L  COMP PIC S9(4).
           02  ORDS195F  PICTURE X.
           02  FILLER REDEFINES ORDS195F.
               03  ORDS195A  PICTURE X.
           02  ORDS195I  PIC X(10).
           02  ORDS201L  COMP PIC S9(4).
           02  ORDS201F  PICTURE X.
           02  FILLER REDEFINES ORDS201F.
               03  ORDS201A  PICTURE X.
           02  ORDS201I  PIC X(4).
           02  ORDS202L  COMP PIC S9(4).
           02  ORDS202F  PICTURE X.
           02  FILLER REDEFINES ORDS202F.
               03  ORDS202A  PICTURE X.
           02  ORDS202I  PIC X(6).
           02  ORDS203L  COMP PIC S9(4).
           02  ORDS203F  PICTURE X.
           02  FILLER REDEFINES ORDS203F.
               03  ORDS203A  PICTURE X.
           02  ORDS203I  PIC X(2).
           02  ORDS204L  COMP PIC S9(4).
           02  ORDS204F  PICTURE X.
           02  FILLER REDEFINES ORDS204F.
               03  ORDS204A  PICTURE X.
           02  ORDS204I  PIC X(9).
           02  ORDS205L  COMP PIC S9(4).
           02  ORDS205F  PICTURE X.
           02  FILLER REDEFINES ORDS205F.
               03  ORDS205A  PICTURE X.
           02  ORDS205I  PIC X(10).
           02  ORDS211L  COMP PIC S9(4).
           02  ORDS211F  PICTURE X.
           02  FILLER REDEFINES ORDS211F.
               03  ORDS211A  PICTURE X.
           02  ORDS211I  PIC X(4).
           02  ORDS212L  COMP PIC S9(4).
           02  ORDS212F  PICTURE X.
           02  FILLER REDEFINES ORDS212F.
               03  ORDS212A  PICTURE X.
           02  ORDS212I  PIC X(6).
           02  ORDS213L  COMP PIC S9(4).
           02  ORDS213F  PICTURE X.
           02  FILLER REDEFINES ORDS213F.
               03  ORDS213A  PICTURE X.
           02  ORDS213I  PIC X(2).
           02  ORDS214L  COMP PIC S9(4).
           02  ORDS214F  PICTURE X.
           02  FILLER REDEFINES ORDS214F.
               03  ORDS214A  PICTURE X.
           02  ORDS214I  PIC X(9).
           02  ORDS215L  COMP PIC S9(4).
           02  ORDS215F  PICTURE X.
           02  FILLER REDEFINES ORDS215F.
               03  ORDS215A  PICTURE X.
           02  ORDS215I  PIC X(10).
           02  ORDS221L  COMP PIC S9(4).
           02  ORDS221F  PICTURE X.
           02  FILLER REDEFINES ORDS221F.
               03  ORDS221A  PICTURE X.
           02  ORDS221I  PIC X(4).
           02  ORDS222L  COMP PIC S9(4).
           02  ORDS222F  PICTURE X.
           02  FILLER REDEFINES ORDS222F.
               03  ORDS222A  PICTURE X.
           02  ORDS222I  PIC X(6).
           02  ORDS223L  COMP PIC S9(4).
           02  ORDS223F  PICTURE X.
           02  FILLER REDEFINES ORDS223F.
               03  ORDS223A  PICTURE X.
           02  ORDS223I  PIC X(2).
           02  ORDS224L  COMP PIC S9(4).
           02  ORDS224F  PICTURE X.
           02  FILLER REDEFINES ORDS224F.
               03  ORDS224A  PICTURE X.
           02  ORDS224I  PIC X(9).
           02  ORDS225L  COMP PIC S9(4).
           02  ORDS225F  PICTURE X.
           02  FILLER REDEFINES ORDS225F.
               03  ORDS225A  PICTURE X.
           02  ORDS225I  PIC X(10).
           02  ORDSMSGL  COMP PIC S9(4).
           02  ORDSMSGF  PICTURE X.
           02  FILLER REDEFINES ORDSMSGF.
               03  ORDSMSGA  PICTURE X.
           02  ORDSMSGI  PIC X(79).
       01  BMSORDSO REDEFINES BMSORDSI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  ORDSTRNO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDSWIDO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDSDIDO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDSCIDO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDSFNMO  PIC X(16).
           02  FILLER PICTURE X(3).
           02  ORDSMNMO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDSLNMO  PIC X(16).
           02  FILLER PICTURE X(3).
           02  ORDSBALO  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDSOIDO  PIC X(8).
           02  FILLER PICTURE X(3).
           02  ORDSEDTO  PIC X(19).
           02  FILLER PICTURE X(3).
           02  ORDSXIDO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDSSWHO  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDSITMO  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDSQTYO  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDSAMTO  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDSDDTO  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS091O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS092O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS093O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS094O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS095O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS101O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS102O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS103O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS104O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS105O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS111O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS112O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS113O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS114O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS115O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS121O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS122O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS123O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS124O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS125O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS131O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS132O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS133O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS134O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS135O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS141O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS142O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS143O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS144O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS145O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS151O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS152O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS153O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS154O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS155O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS161O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS162O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS163O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS164O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS165O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS171O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS172O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS173O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS174O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS175O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS181O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS182O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS183O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS184O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS185O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS191O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS192O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS193O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS194O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS195O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS201O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS202O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS203O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS204O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS205O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS211O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS212O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS213O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS214O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS215O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDS221O  PIC X(4).
           02  FILLER PICTURE X(3).
           02  ORDS222O  PIC X(6).
           02  FILLER PICTURE X(3).
           02  ORDS223O  PIC X(2).
           02  FILLER PICTURE X(3).
           02  ORDS224O  PIC X(9).
           02  FILLER PICTURE X(3).
           02  ORDS225O  PIC X(10).
           02  FILLER PICTURE X(3).
           02  ORDSMSGO  PIC X(79).
