* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
WEIGHT BY paino.

WEIGHT OFF.

FREQUENCIES VARIABLES=f2
  /STATISTICS=STDDEV VARIANCE MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=f30 f31
  /STATISTICS=STDDEV VARIANCE MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.


FREQUENCIES VARIABLES=c6 c7
  /STATISTICS=STDDEV VARIANCE MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.


RECODE c6 (1=Copy) (2=Copy) (3=Copy) (4=Copy) (ELSE=SYSMIS) INTO turv.
VARIABLE LABELS  turv 'koettu turvallisuus'.
EXECUTE.

RECODE c6 (1 thru 2=1) (3 thru 4=2) (ELSE=SYSMIS) INTO turv_2lk.
VARIABLE LABELS  turv_2lk 'koettu turvallisuus, dikotominen'.
EXECUTE.

GENLOG turv_2lk BY f31
  /MODEL=MULTINOMIAL
  /PRINT=FREQ RESID ADJRESID ZRESID DEV DESIGN ESTIM CORR COV
  /PLOT=NONE
  /CRITERIA=CIN(95) ITERATE(20) CONVERGE(0.001) DELTA(.5).


GENLOG turv_2lk BY f30
  /MODEL=MULTINOMIAL
  /PRINT=FREQ RESID ADJRESID ZRESID DEV DESIGN ESTIM CORR COV
  /PLOT=NONE
  /CRITERIA=CIN(95) ITERATE(20) CONVERGE(0.001) DELTA(.5).

SORT CASES  BY f2_1.
SPLIT FILE SEPARATE BY f2_1.

UNIANOVA turv_2lk BY f30
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=f30.


UNIANOVA turv_2lk BY f31
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=f31.


RECODE f31 (1 thru 2=1) (3 thru 4=2) (ELSE=SYSMIS) INTO f31_tiiv.
VARIABLE LABELS  f31_tiiv 'Toimeentulo nykyisilla tuloilla, 2lk'.
EXECUTE.

UNIANOVA turv_2lk BY f31_tiiv
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=f31_tiiv.

FREQUENCIES VARIABLES=f6 f45 f51
  /STATISTICS=STDDEV VARIANCE MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.

RECODE f6 (3=2) (0 thru 2=1) (5 thru 6=3) (ELSE=SYSMIS) INTO koulutus.
VARIABLE LABELS  koulutus 'koulutustaso'.
EXECUTE.

FREQUENCIES VARIABLES=koulutus.

CORRELATIONS
  /VARIABLES=koulutus f6
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

MEANS TABLES=turv BY koulutus
  /CELLS=MEAN COUNT STDDEV.

UNIANOVA turv_2lk BY koulutus
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=koulutus.

RECODE f45 (3=2) (0 thru 2=1) (5 thru 6=3) (ELSE=SYSMIS) INTO koulutus_isa.
VARIABLE LABELS  koulutus_isa 'isan koulutustaso'.
EXECUTE.

RECODE f51 (3=2) (0 thru 2=1) (5 thru 6=3) (ELSE=SYSMIS) INTO koulutus_aiti.
VARIABLE LABELS  koulutus_aiti 'aidin koulutustaso'.
EXECUTE.

FREQUENCIES VARIABLES=koulutus koulutus_isa koulutus_aiti
  /STATISTICS=STDDEV VARIANCE MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.

COMPUTE koulutustasot_summa=(koulutus + koulutus_isa + koulutus_aiti)  / 3.
EXECUTE.

FREQUENCIES VARIABLES=koulutustasot_summa
  /STATISTICS=STDDEV VARIANCE MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.

UNIANOVA turv_2lk BY koulutus_isa
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=koulutus_isa.

UNIANOVA turv_2lk BY f5
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=f5.

GRAPH
  /HISTOGRAM(NORMAL)=a10.

UNIANOVA turv_2lk BY a10
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=a10.

COMPUTE luottamus_summa=(a8 + a9 + a10) / 3.
EXECUTE.

UNIANOVA turv_2lk WITH luottamus_summa
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=luottamus_summa.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=turv_2lk 
    MEAN(luottamus_summa)[name="MEAN_luottamus_summa"] MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: turv_2lk=col(source(s), name("turv_2lk"), unit.category())
  DATA: MEAN_luottamus_summa=col(source(s), name("MEAN_luottamus_summa"))
  GUIDE: axis(dim(1), label("koettu turvallisuus, dikotominen"))
  GUIDE: axis(dim(2), label("Mean luottamus_summa"))
  GUIDE: text.title(label("Simple Line Mean of luottamus_summa by koettu turvallisuus, ",
    "dikotominen"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: line(position(turv_2lk*MEAN_luottamus_summa), missing.wings())
END GPL.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=turv 
    MEAN(luottamus_summa)[name="MEAN_luottamus_summa"] MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: turv=col(source(s), name("turv"), unit.category())
  DATA: MEAN_luottamus_summa=col(source(s), name("MEAN_luottamus_summa"))
  GUIDE: axis(dim(1), label("koettu turvallisuus"))
  GUIDE: axis(dim(2), label("Mean luottamus_summa"))
  GUIDE: text.title(label("Simple Line Mean of luottamus_summa by koettu turvallisuus"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: line(position(turv*MEAN_luottamus_summa), missing.wings())
END GPL.

MEANS TABLES=luottamus_summa BY turv_2lk
  /CELLS=MEAN COUNT STDDEV.

MEANS TABLES=luottamus_summa BY f31_tiiv
  /CELLS=MEAN COUNT STDDEV
  /STATISTICS ANOVA LINEARITY.


MEANS TABLES=luottamus_summa BY f30
  /CELLS=MEAN COUNT STDDEV
  /STATISTICS ANOVA LINEARITY.

MEANS TABLES=turv_2lk BY f31_tiiv
  /CELLS=MEAN COUNT STDDEV
  /STATISTICS ANOVA LINEARITY.

*Naisilla "vaikeuksia tulla toimeen nykyisilla tuloilla yhdistyy hieman korkeampaan turvattomuuteen: 
    * 1.1981 vs 1.2959 asteikolla 1-2, p=0,008
    *Miehilla ei yhdisty merkitsevasti

*seka miehilla etta naisilla vaikeudet tulla toimeen nykyisilla tuloilla yhdistyvat hieman matalampaan luottamukseen, tulos erittain merkitseva
    
MEANS TABLES=luottamus_summa BY turv_2lk
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

*seka miehilla etta naisilla alhaisempi luottamus ennustaa suurempaa todennakoisyytta kokea turvattomuutta
    * miehilla p=0.011 , naisilla p=*** , miehilla hieman suurempi ero luottamuksessa turvattomaksi ja turvalliseksi vastaavien valilla
    

MEANS TABLES=luottamus_summa BY koulutus
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

* miehilla juuri ja juuri merkitseva ero koulutustason mukaan luottamuksessa p=0,044 , naisilla ei eroa luottamuksessa koulutuksen mukaan
    *korkeakoulutus eroaa muista, mutta perus ja keski eivat eroa todennakoisesti toisistaan miehilla
    
MEANS TABLES=turv_2lk BY koulutus
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

*miesten turvallisuuden kokemuksessa ei eroa koulutustason suhteen, 
    *naisilla mahdollisesti hieman turvattomuus vahenee koulutustason kasvaessa, p=0,038, linearity p=0,015

MEANS TABLES=koulutustasot_summa BY turv_2lk
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

*naisilla oma+aiti+isa koulutustasojen summa yhteydessa koettuun turvallisuuteen selvasti p=0,003
 *miehilla lievaa tai ei lainkaan eroa p=0,169
 

*tehdaan viela yleinen lineaarinen malli jossa kaikki edeltavat mukana:
    


UNIANOVA turv_2lk BY koulutus f31_tiiv WITH luottamus_summa
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=koulutus f31_tiiv luottamus_summa.

UNIANOVA turv_2lk BY f31_tiiv WITH luottamus_summa koulutustasot_summa
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=koulutustasot_summa f31_tiiv luottamus_summa.

*miehilla kun kaikki muuttujat mukana ja erityisesti myos vanhempien koulutustaso, niin vain luottamus pysyy juuri ja juuri merkitsevyyden tasolla selittavista muuttujista
    *naisilla painvastoin vaikutus vahvistuu, ja toimeentulemisen kokemus menettaa selitysvoimansa kun oma ja vanhempien koulutus seka luottamus vahvistuvat selittajina
    
*kokeillaan viela sama mutta tulodesiili-mittarilla:
    
UNIANOVA turv_2lk BY koulutus WITH f30 luottamus_summa
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=koulutus f30 luottamus_summa.

UNIANOVA turv_2lk WITH f30 luottamus_summa koulutustasot_summa
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT ETASQ DESCRIPTIVE PARAMETER OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=koulutustasot_summa f30 luottamus_summa.

*naisilla kaikki muuttujat pysyvat merkitsevina, oman koulutuksen mukaan ei eroa kun tulot ja luottamus vakioitu, vanhempien koulutus vahvistaa efektia
* miehilla vain luottamus merkitseva, vanhempien koulutustason huomiointi oman koulutuksen kanssa tekee tuloista lahes merkitsevia p=0,051
*miehilla kaikkien selittajien efekti hyvin pieni, korkein vikassa vaiheessa luottamuksella joka B= -0,011 , asteikolla 1-2
*naisilla muuttujien (koulutus, koetut tai arvioidut tulot, sos. luottamus) selitysvoima selvasti suurempi

COMPUTE ika=2002  - (f3).
EXECUTE.

FREQUENCIES VARIABLES=ika
  /STATISTICS=STDDEV VARIANCE MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.


MEANS TABLES=d29 BY turv_2lk
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

MEANS TABLES=turv_2lk BY d29
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.


MEANS TABLES=turv_2lk BY d30
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.


MEANS TABLES=turv_2lk BY d31
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

MEANS TABLES=turv_2lk BY gs1e
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

FREQUENCIES VARIABLES=tulot
  /STATISTICS=STDDEV VARIANCE MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.


RECODE gs1e (ELSE=Copy) INTO arvo_turv.
VARIABLE LABELS  arvo_turv 'tärkeää elää turvallisessa ympäristössä'.
EXECUTE.

RECODE gs1o (ELSE=Copy) INTO arvo_riskit.
VARIABLE LABELS  arvo_riskit 'tärkeää seikkailut ja riskinotto'.
EXECUTE.


MEANS TABLES=turv_2lk BY f5
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.


RECODE f30 (ELSE=Copy) INTO tulot.
VARIABLE LABELS  tulot 'kotitalouden nettotulot'.
EXECUTE.

RECODE f30 (3=2) (4=3) (5=4) (7=8) (6=5.5) (1 thru 2=1) (8 thru 10=10) (ELSE=SYSMIS) INTO 
    tulodesiili.
VARIABLE LABELS  tulodesiili 'kotitalouden nettotulot korjattu desiili'.
EXECUTE.

MEANS TABLES=turv_2lk BY tulodesiili
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

FREQUENCIES VARIABLES=totu f31
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

RECODE f31 (ELSE=Copy) INTO totu.
VARIABLE LABELS  totu 'toimeentulo nykyisillä tuloilla'.
EXECUTE.

MEANS TABLES=turv_2lk BY c5
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

FREQUENCIES VARIABLES=f8b
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.


*pääasiallinen toiminta:
    
COMPUTE pt=0.
IF ((f8a_1 = 1) & (f8a_2 = 0) & (f8a_3 = 0) & (f8a_4 = 0) & (f8a_5 = 0) & (f8a_6 = 0) & (f8a_7 = 0) & (f8a_8 = 0) & (f8a_9 = 0)) pt=1.
IF ((f8a_1 = 0) & (f8a_2 = 1) & (f8a_3 = 0) & (f8a_4 = 0) & (f8a_5 = 0) & (f8a_6 = 0) & (f8a_7 = 0) & (f8a_8 = 0) & (f8a_9 = 0)) pt=2.
IF ((f8a_1 = 0) & (f8a_2 = 0) & (f8a_3 = 1) & (f8a_4 = 0) & (f8a_5 = 0) & (f8a_6 = 0) & (f8a_7 = 0) & (f8a_8 = 0) & (f8a_9 = 0)) pt=3.
IF ((f8a_1 = 0) & (f8a_2 = 0) & (f8a_3 = 0) & (f8a_4 = 1) & (f8a_5 = 0) & (f8a_6 = 0) & (f8a_7 = 0) & (f8a_8 = 0) & (f8a_9 = 0)) pt=4.
IF ((f8a_1 = 0) & (f8a_2 = 0) & (f8a_3 = 0) & (f8a_4 = 0) & (f8a_5 = 1) & (f8a_6 = 0) & (f8a_7 = 0) & (f8a_8 = 0) & (f8a_9 = 0)) pt=5.
IF ((f8a_1 = 0) & (f8a_2 = 0) & (f8a_3 = 0) & (f8a_4 = 0) & (f8a_5 = 0) & (f8a_6 = 1) & (f8a_7 = 0) & (f8a_8 = 0) & (f8a_9 = 0)) pt=6.
IF ((f8a_1 = 0) & (f8a_2 = 0) & (f8a_3 = 0) & (f8a_4 = 0) & (f8a_5 = 0) & (f8a_6 = 0) & (f8a_7 = 1) & (f8a_8 = 0) & (f8a_9 = 0)) pt=7.
IF ((f8a_1 = 0) & (f8a_2 = 0) & (f8a_3 = 0) & (f8a_4 = 0) & (f8a_5 = 0) & (f8a_6 = 0) & (f8a_7 = 0) & (f8a_8 = 1) & (f8a_9 = 0)) pt=8.
IF ((f8a_1 = 0) & (f8a_2 = 0) & (f8a_3 = 0) & (f8a_4 = 0) & (f8a_5 = 0) & (f8a_6 = 0) & (f8a_7 = 0) & (f8a_8 = 0) & (f8a_9 = 1)) pt=9.
EXECUTE.

FREQUENCIES VARIABLES=pt
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

RECODE pt (1=1) (2=2) (5=4) (6=5) (8=6) (3 thru 4=3) (ELSE=SYSMIS) INTO pttiiv.
VARIABLE LABELS  pttiiv 'pääasiallinen toiminta tiivistetty'.
EXECUTE.

FREQUENCIES VARIABLES=pttiiv
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.


MEANS TABLES=turv_2lk BY pttiiv2
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

RECODE pttiiv (1=1) (2=2) (6=4) (3 thru 5=3) (ELSE=SYSMIS) INTO pttiiv2.
VARIABLE LABELS  pttiiv 'pääasiallinen toiminta tiivistetty lisää'.
EXECUTE.

MEANS TABLES=turv_2lk BY pttiiv2
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.

DATASET ACTIVATE DataSet1.
* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=pttiiv2 MEAN(ika)[name="MEAN_ika"] MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: pttiiv2=col(source(s), name("pttiiv2"), unit.category())
  DATA: MEAN_ika=col(source(s), name("MEAN_ika"))
  GUIDE: axis(dim(1), label("pääasiallinen toiminta tiivistetty lisää"))
  GUIDE: axis(dim(2), label("Mean ika"))
  GUIDE: text.title(label("Simple Line Mean of ika by pääasiallinen toiminta tiivistetty lisää"))
  SCALE: cat(dim(1), include("1.00", "2.00", "3.00", "4.00"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: line(position(pttiiv2*MEAN_ika), missing.wings())
END GPL.

RECODE f8b (1=1) (2=2) (6=4) (3 thru 5=3) (ELSE=SYSMIS) INTO pttiiv3.
VARIABLE LABELS  pttiiv3 'pääasiallinen toiminta tiivistetty lisää'.
EXECUTE.

FREQUENCIES    pttiiv3.



string tmp(a1000).
COMPUTE tmp = concat(
"pttiiv2 = ",string(pttiiv2,f1)," (",rtrim(valuelabels(pttiiv2)),") ", "pttiiv3 = ",string(pttiiv3,f1)," (",rtrim(valuelabels(pttiiv3)),") " 
).

autorecode tmp
    /into pttiiv5.

delete variables tmp.

variable labels pttiiv5 'yhdistetty pääasiallinen toiminta useita vaihtoehtoja vastanneet muihin try2'.

SPLIT FILE OFF.
FREQUENCIES pttiiv2 pttiiv3 pttiiv4 pttiiv5.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=f2_1 pttiiv5 MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: f2_1=col(source(s), name("f2_1"), unit.category())
  DATA: pttiiv5=col(source(s), name("pttiiv5"), unit.category())
  GUIDE: axis(dim(1), label("[f2_1] Vastaajan sukupuoli"))
  GUIDE: axis(dim(2), label("yhdistetty pääasiallinen toiminta useita vaihtoehtoja vastanneet ",
    "muihin try2"))
  GUIDE: text.title(label("Simple Line of yhdistetty pääasiallinen toiminta useita vaihtoehtoja ",
    "vastanneet muihin try2 by [f2_1] Vastaajan sukupuoli"))
  SCALE: cat(dim(1), include("1", "2"))
  SCALE: cat(dim(2), include("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"))
  ELEMENT: line(position(f2_1*pttiiv5), missing.wings())
END GPL.

RECODE pttiiv5 (1=SYSMIS) (2=1) (3=2) (4=3) (5=4) (6=1) (7=1) (8=2) (9=3) (10=4) INTO pttiiv6.
VARIABLE LABELS  pttiiv6 'pääasiallinen toiminta, kaikki vastaukset'.
EXECUTE.


FREQUENCIES pttiiv6.


MEANS TABLES=turv_2lk BY pttiiv6
  /CELLS=MEAN COUNT STDDEV 
   /STATISTICS ANOVA LINEARITY.
