* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.

*kaikki vastaajat:

CROSSTABS
  /TABLES=vuosi BY turv
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW 
  /COUNT ROUND CELL.


*miehet ja naiset erikseen:

SORT CASES  BY f2_1.
SPLIT FILE SEPARATE BY f2_1.

CROSSTABS
  /TABLES=vuosi BY turv
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW 
  /COUNT ROUND CELL.

SPLIT FILE OFF.

DESCRIPTIVES VARIABLES=turv_dik f2_1 koulutus ika ika_2 f5 vuosijakso3 koulutusvanhemmat_summa 
    totu_2lk tyoton luottamus_summa
  /STATISTICS=MEAN STDDEV MIN MAX SKEWNESS.

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=ALL  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /PDF  DOCUMENTFILE='C:\Users\hippodamus\Desktop\GRADU-ESS-2002-2020\kuvailevat_tulokset.pdf'
     EMBEDBOOKMARKS=YES  EMBEDFONTS=YES.


