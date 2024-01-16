* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=f2_1
  /STATISTICS=STDDEV MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.

WEIGHT BY paino2008.

COMPUTE ika=((2008) - (f3_1)).
EXECUTE.

RECODE f5 (1=1) (2=2) (3=3) (4=4) (5=5) (ELSE=SYSMIS).
EXECUTE.

RECODE c6 (1=1) (2=2) (3=3) (4=4) (ELSE=SYSMIS) INTO turv.
EXECUTE.

RECODE turv (1 thru 2=1) (3 thru 4=2) (ELSE=SYSMIS) INTO turv_2lk.
EXECUTE.

RECODE f33 (1=1) (2=2) (3=3) (4=4) (ELSE=SYSMIS) INTO totu.
EXECUTE.

RECODE totu (1 thru 2=1) (3 thru 4=2) (ELSE=SYSMIS) INTO totu_2lk.
EXECUTE.


RECODE gs1e (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (ELSE=SYSMIS) INTO arvo_turv.
EXECUTE.

RECODE gs1o (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (ELSE=SYSMIS) INTO arvo_riskit.
EXECUTE.

CROSSTABS
  /TABLES=arvo_riskit BY gs1o
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

RECODE a8 a9 a10 (0=0) (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7=7) (8=8) (9=9) (10=10) (ELSE=SYSMIS).
EXECUTE.



COMPUTE luottamus_summa=((a8 + a9 + a10) / (3)).
EXECUTE.

FREQUENCIES VARIABLES=luottamus_summa
  /STATISTICS=STDDEV MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS
  /HISTOGRAM.

RECODE f6 (3=2) (0 thru 2=1) (5 thru 6=3) (ELSE=SYSMIS) INTO koulutus.
EXECUTE.

RECODE f49 (3=2) (0 thru 2=1) (5 thru 6=3) (ELSE=SYSMIS) INTO koulutus_isa.
EXECUTE.

RECODE f55 (3=2) (0 thru 2=1) (5 thru 6=3) (ELSE=SYSMIS) INTO koulutus_aiti.
EXECUTE.


CROSSTABS
  /TABLES=f6 BY koulutus
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.


CROSSTABS
  /TABLES=f49 BY koulutus_isa
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.


CROSSTABS
  /TABLES=f55 BY koulutus_aiti
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.


GRAPH
  /HISTOGRAM(NORMAL)=koulutus.

GRAPH
  /HISTOGRAM(NORMAL)=koulutus_aiti.

GRAPH
  /HISTOGRAM(NORMAL)=koulutus_isa.

COMPUTE koulutustasot_summa=((koulutus + koulutus_isa + koulutus_aiti) / (3)).
EXECUTE.

GRAPH
  /HISTOGRAM(NORMAL)=koulutustasot_summa.

RECODE f32 (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7=7) (8=8) (9=9) (10=10) (ELSE=SYSMIS) INTO 
    tulodesiili.
EXECUTE.

CROSSTABS
  /TABLES=f32 BY tulodesiili
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.



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

RECODE pt (1=1) (2=2) (6=4) (3 thru 5=3) (ELSE=SYSMIS) INTO pttiiv2.
VARIABLE LABELS  pttiiv2 'pääasiallinen toiminta tiivistetty'.
EXECUTE.

RECODE f8c (1=1) (2=2) (6=4) (3 thru 5=3) (ELSE=SYSMIS) INTO pttiiv3.
VARIABLE LABELS  pttiiv3 'pääasiallinen toiminta tiivistetty lisää'.
EXECUTE.

string tmp(a1000).

COMPUTE tmp = concat(
"pttiiv2 = ",string(pttiiv2,f1)," (",rtrim(valuelabels(pttiiv2)),") ", "pttiiv3 = ",string(pttiiv3,f1)," (",rtrim(valuelabels(pttiiv3)),") " 
).

autorecode tmp
    /into pttiiv5.

delete variables tmp.

variable labels pttiiv5 'yhdistetty pääasiallinen toiminta useita vaihtoehtoja vastanneet muihin'.

FREQUENCIES    pttiiv5
    /HISTOGRAM.



* piirretään graafi jotta varmistetaan luokkien numeroarvot.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=f2_1 pttiiv5 MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: f2_1=col(source(s), name("f2_1"), unit.category())
  DATA: pttiiv5=col(source(s), name("pttiiv5"), unit.category())
  GUIDE: axis(dim(1), label("[F2_1] 1. kotitalouden j senen (=vastaaja) sukupuoli"))
  GUIDE: axis(dim(2), label("yhdistetty pääasiallinen toiminta useita vaihtoehtoja vastanneet ",
    "muihin"))
  GUIDE: text.title(label("Simple Line of yhdistetty pääasiallinen toiminta useita vaihtoehtoja ",
    "vastanneet muihin by [F2_1] 1. kotitalouden j senen (=vastaaja) sukupuoli"))
  SCALE: cat(dim(1), include("1", "2"))
  SCALE: cat(dim(2), include("1", "2", "3", "4", "5", "6", "7", "8", "9"))
  ELEMENT: line(position(f2_1*pttiiv5), missing.wings())
END GPL.

RECODE pttiiv5 (1=SYSMIS) (2=1) (3=2) (4=3) (5=4) (6=1) (7=2) (8=3) (9=4) (ELSE=SYSMIS) INTO 
    pttiiv6.
EXECUTE.


FREQUENCIES VARIABLES=pttiiv6
  /STATISTICS=STDDEV MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.


*tarkistetaan näin tehdyt muuttujat:

FREQUENCIES paino2008 f2_1 ika f5 turv turv_2lk totu totu_2lk arvo_turv arvo_riskit luottamus_summa koulutus koulutus_isa koulutus_aiti  koulutustasot_summa tulodesiili pttiiv6 bv1
    /HISTOGRAM
    /STATISTICS=SKEWNESS.

