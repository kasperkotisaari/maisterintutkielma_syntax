* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
RECODE c6 (1=1) (2=2) (3=3) (4=4) (ELSE=SYSMIS) INTO turv.
EXECUTE.

RECODE turv (1 thru 2=1) (3 thru 4=2) (ELSE=SYSMIS) INTO turv_2lk.
EXECUTE.

COMPUTE ika=2004 - (f3_1).
EXECUTE.

RECODE f5 (1=1) (2=2) (3=3) (4=4) (5=5) (ELSE=SYSMIS).
EXECUTE.

WEIGHT BY paino2004.

WEIGHT OFF.

FREQUENCIES VARIABLES=f2_1
  /STATISTICS=STDDEV VARIANCE MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS.



RECODE f32 (5=2) (6=3) (7=4) (8=5) (9=7.5) (10=9) (1 thru 4=1) (11 thru 12=10) INTO tulodesiili.
EXECUTE.

FREQUENCIES VARIABLES=tulodesiili
  /STATISTICS=STDDEV VARIANCE MEAN MEDIAN SKEWNESS SESKEW
  /ORDER=ANALYSIS
  /HISTOGRAM.


RECODE f33 (1=1) (2=2) (3=3) (4=4) (ELSE=SYSMIS) INTO totu.
VARIABLE LABELS  totu 'toimeentulo nykyisillä tuloilla'.
EXECUTE.

RECODE totu (1 thru 2=1) (3 thru 4=2) INTO totu_2lk.
EXECUTE.

RECODE gs1e (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (ELSE=SYSMIS) INTO arvo_turv.
EXECUTE.

RECODE gs1o (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (ELSE=SYSMIS) INTO arvo_riskit.
EXECUTE.

RECODE a8 a9 a10 (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7=7) (8=8) (9=9) (10=10) (ELSE=SYSMIS).
EXECUTE.

COMPUTE luottamus_summa=((a8 + a9 + a10) / 3).
EXECUTE.



RECODE f6 (3=2) (0 thru 2=1) (5 thru 6=3) (ELSE=SYSMIS) INTO koulutus.
EXECUTE.

RECODE f49 (3=2) (7=1) (0 thru 2=1) (5 thru 6=3) (ELSE=SYSMIS) INTO koulutus_isa.
EXECUTE.

RECODE f55 (3=2) (7=1) (0 thru 2=1) (5 thru 6=3) (ELSE=SYSMIS) INTO koulutus_aiti.
EXECUTE.

COMPUTE koulutustasot_summa=(koulutus + koulutus_isa + koulutus_aiti) / 3.
EXECUTE.

FREQUENCIES turv turv_2lk ika tulodesiili totu totu_2lk arvo_turv arvo_riskit luottamus_summa koulutus koulutus_isa koulutus_aiti koulutustasot_summa
    /HISTOGRAM. 

FREQUENCIES f8d
    /HISTOGRAM.

RECODE f8d (1=1) (2=2) (3 thru 5=3) (6=4) (ELSE=SYSMIS) INTO pttiiv6.
EXECUTE.

FREQUENCIES pttiiv6
    /HISTOGRAM.

