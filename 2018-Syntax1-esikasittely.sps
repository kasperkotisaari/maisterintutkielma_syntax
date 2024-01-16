* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=gndr
  /ORDER=ANALYSIS.

*Post-stratification weight including design weight:

WEIGHT OFF.

WEIGHT BY paino2018.

RECODE gndr (1=1) (2=2) (ELSE=SYSMIS) INTO f2_1.
EXECUTE.

GRAPH
  /HISTOGRAM(NORMAL)=yrbrn.

COMPUTE ika=((2018) - (yrbrn)).
EXECUTE.

GRAPH
  /HISTOGRAM(NORMAL)=aesfdrk.

RECODE aesfdrk (1=1) (2=2) (3=3) (4=4) (ELSE=SYSMIS) INTO turv.
EXECUTE.

RECODE turv (1 thru 2=1) (3 thru 4=2) (ELSE=SYSMIS) INTO turv_2lk.
EXECUTE.

GRAPH
  /HISTOGRAM(NORMAL)=hincfel .

RECODE hincfel (1=1) (2=2) (3=3) (4=4) (ELSE=SYSMIS) INTO totu.
EXECUTE.

RECODE totu (1 thru 2=1) (3 thru 4=2) (ELSE=SYSMIS) INTO totu_2lk.
EXECUTE.


RECODE impsafe (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (ELSE=SYSMIS) INTO arvo_turv.
EXECUTE.

RECODE ipadvnt (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (ELSE=SYSMIS) INTO arvo_riskit.
EXECUTE.

RECODE ppltrst pplfair pplhlp (0=0) (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7=7) (8=8) (9=9) (10=10) (ELSE=SYSMIS).
EXECUTE.

COMPUTE luottamus_summa=((ppltrst + pplfair + pplhlp) / (3)).
EXECUTE.

FREQUENCIES    VARIABLES    ppltrst pplfair pplhlp .

FREQUENCIES VARIABLES=luottamus_summa
  /STATISTICS=STDDEV MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS
  /HISTOGRAM.

FREQUENCIES ppltrst pplfair pplhlp.

FREQUENCIES VARIABLES=edlvdfi edlvfdfi edlvmdfi.

RECODE edlvdfi (1 thru 3=1) (4 thru 8=2) (9 thru 14=3) (ELSE=SYSMIS) INTO koulutus.
EXECUTE.

RECODE edlvfdfi (1 thru 3=1) (4 thru 8=2) (9 thru 14=3) (ELSE=SYSMIS) INTO koulutus_isa.
EXECUTE.

RECODE edlvmdfi (1 thru 3=1) (4 thru 8=2) (9 thru 14=3) (ELSE=SYSMIS) INTO koulutus_aiti.
EXECUTE.

CROSSTABS
  /TABLES=edlvdfi BY koulutus
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.


CROSSTABS
  /TABLES=edlvfdfi BY koulutus_isa
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.


CROSSTABS
  /TABLES=edlvmdfi BY koulutus_aiti
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

COMPUTE koulutustasot_summa=((koulutus + koulutus_isa + koulutus_aiti) / (3)).
EXECUTE.

Frequencies koulutustasot_summa.

FREQUENCIES    hinctnta.


RECODE hinctnta (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7=7) (8=8) (9=9) (10=10) (ELSE=SYSMIS) INTO 
    tulodesiili.
EXECUTE.

FREQUENCIES    mnactic.

RECODE mnactic (1=1) (2=2) (6=4) (3 thru 5=3) (ELSE=SYSMIS) INTO pttiiv6.
EXECUTE.

FREQUENCIES    pttiiv6.

FREQUENCIES    domicil .

RECODE domicil (1=1) (2=2) (3=3) (4=4) (5=5) (ELSE=SYSMIS) INTO f5.

FREQUENCIES    f5.
*tarkistetaan muuttujat
* f5 PUUTTUU: (asuinympäristö; suuri kaupunki -- haja-asutusalue)
    
FREQUENCIES paino2018 f2_1 ika turv turv_2lk totu totu_2lk arvo_turv arvo_riskit luottamus_summa koulutus koulutus_isa koulutus_aiti  tulodesiili pttiiv6 f5
    /HISTOGRAM
    /STATISTICS=SKEWNESS.









