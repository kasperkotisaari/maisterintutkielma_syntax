* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
SORT CASES  BY f2_1.
SPLIT FILE SEPARATE BY f2_1.



LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus 
  /CONTRAST (koulutus)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Malli 1:

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_toiseen f5 vuosijakso3 
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Malli 2:

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_toiseen f5 vuosijakso3 koulutusvanhemmat_summa
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Malli 3:

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_toiseen f5 vuosijakso3 koulutusvanhemmat_summa totu_2lk
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (totu_2lk)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Malli 4:

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_toiseen f5 vuosijakso3 koulutusvanhemmat_summa totu_2lk tyoton
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (totu_2lk)=Indicator(1)
  /CONTRAST (tyoton)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Malli 5:

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_toiseen f5 vuosijakso3 koulutusvanhemmat_summa totu_2lk tyoton luottamus_summa
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (totu_2lk)=Indicator(1)
  /CONTRAST (tyoton)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).



*Tallennetaan ennustettujen todennäköisyyksien piste-estimaatit malleista 1 ja 5:
    
*Malli 1, piste-estimaatit:

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_toiseen f5 vuosijakso3 
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /PRINT=CI(95)
  /SAVE=PRED
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Malli 5, piste-estimaatit::

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_toiseen f5 vuosijakso3 koulutusvanhemmat_summa totu_2lk tyoton luottamus_summa
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (totu_2lk)=Indicator(1)
  /CONTRAST (tyoton)=Indicator(1)
  /PRINT=CI(95)
  /SAVE=PRED
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*Piirretään kuviot saaduista ennustetuista todennäköisyyksistä tulosten havainnollistamiseksi:
    


* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=koulutus MEANCI(PRE_1, 95) MEANCI(PRE_2, 95) 
    MISSING=LISTWISE REPORTMISSING=NO
    TRANSFORM=VARSTOCASES(SUMMARY="#SUMMARY" INDEX="#INDEX" LOW="#LOW" HIGH="#HIGH")
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: koulutus=col(source(s), name("koulutus"), unit.category())
  DATA: SUMMARY=col(source(s), name("#SUMMARY"))
  DATA: INDEX=col(source(s), name("#INDEX"), unit.category())
  DATA: LOW=col(source(s), name("#LOW"))
  DATA: HIGH=col(source(s), name("#HIGH"))
  COORD: rect(dim(1,2), cluster(3,0))
  GUIDE: axis(dim(3), label("koulutustaso"))
  GUIDE: axis(dim(2), label("Mean"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label(""))
  GUIDE: text.title(label("Clustered Error Bar Mean of Malli 1, piste-estimaatit, Mean of Malli ",
    "5, piste-estimaatit by koulutustaso by INDEX"))
  GUIDE: text.footnote(label("Error Bars: 95% CI"))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include(
"0", "1"))
  SCALE: cat(dim(1), include(
"0", "1"))
  ELEMENT: point(position(INDEX*SUMMARY*koulutus), color.interior(INDEX))
  ELEMENT: interval(position(region.spread.range(INDEX*(LOW+HIGH)*koulutus)), 
    shape.interior(shape.ibeam), color.interior(INDEX))
END GPL.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=koulutus MEANSE(PRE_1, 2) MEANSE(PRE_2, 2) 
    MISSING=LISTWISE REPORTMISSING=NO
    TRANSFORM=VARSTOCASES(SUMMARY="#SUMMARY" INDEX="#INDEX" LOW="#LOW" HIGH="#HIGH")
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: koulutus=col(source(s), name("koulutus"), unit.category())
  DATA: SUMMARY=col(source(s), name("#SUMMARY"))
  DATA: INDEX=col(source(s), name("#INDEX"), unit.category())
  DATA: LOW=col(source(s), name("#LOW"))
  DATA: HIGH=col(source(s), name("#HIGH"))
  COORD: rect(dim(1,2), cluster(3,0))
  GUIDE: axis(dim(3), label("koulutustaso"))
  GUIDE: axis(dim(2), label("Mean"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label(""))
  GUIDE: text.title(label("Clustered Error Bar Mean of Malli 1, piste-estimaatit, Mean of Malli ",
    "5, piste-estimaatit by koulutustaso by INDEX"))
  GUIDE: text.footnote(label("Error Bars: 95% CI"))
  GUIDE: text.subfootnote(label("Error Bars: +/- 2 SE"))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include(
"0", "1"))
  SCALE: cat(dim(1), include(
"0", "1"))
  ELEMENT: point(position(INDEX*SUMMARY*koulutus), color.interior(INDEX))
  ELEMENT: interval(position(region.spread.range(INDEX*(LOW+HIGH)*koulutus)), 
    shape.interior(shape.ibeam), color.interior(INDEX))
END GPL.

GENLOG turv_dik BY koulutus
  /MODEL=MULTINOMIAL
  /PRINT=FREQ RESID ADJRESID ZRESID DEV ESTIM CORR COV
  /PLOT=RESID(ADJRESID) NORMPROB(ADJRESID)
  /CRITERIA=CIN(95) ITERATE(20) CONVERGE(0.001) DELTA(.5)
  /DESIGN turv_dik turv_dik*koulutus
  /SAVE=PRED.

UNIANOVA turv_dik BY koulutus f5 vuosijakso3 WITH ika ika_toiseen
  /CONTRAST(koulutus)=Deviation
  /CONTRAST(f5)=Deviation
  /CONTRAST(vuosijakso3)=Deviation
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /SAVE=SEPRED
  /EMMEANS=TABLES(koulutus) WITH(ika=MEAN ika_toiseen=MEAN) COMPARE ADJ(LSD)
  /EMMEANS=TABLES(vuosijakso3) WITH(ika=MEAN ika_toiseen=MEAN) COMPARE ADJ(LSD)
  /PRINT PARAMETER
  /CRITERIA=ALPHA(.05)  
  /ROBUST=HC3
  /DESIGN=koulutus f5 vuosijakso3 ika ika_toiseen.



* Generalized Linear Models.
GENLIN turv_dik (REFERENCE=LAST) BY f2_1 koulutus f5 vuosijakso3 (ORDER=ASCENDING) WITH ika 
    ika_toiseen
  /MODEL f2_1 koulutus ika ika_toiseen f5 vuosijakso3 INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=1 COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=5 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=koulutus*vuosijakso3 SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=koulutus MEAN(MeanPredicted) 
    MEAN(CIMeanPredictedLower) MEAN(CIMeanPredictedUpper) MISSING=LISTWISE REPORTMISSING=NO
    TRANSFORM=VARSTOCASES(SUMMARY="#SUMMARY" INDEX="#INDEX")
  /GRAPHSPEC SOURCE=INLINE
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: koulutus=col(source(s), name("koulutus"), unit.category())
  DATA: SUMMARY=col(source(s), name("#SUMMARY"))
  DATA: INDEX=col(source(s), name("#INDEX"), unit.category())
  GUIDE: axis(dim(1), label("koulutustaso"))
  GUIDE: axis(dim(2), label("Mean"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label(""))
  GUIDE: text.title(label("Drop-line Mean of Predicted Value of Mean of Response, Mean of Lower ",
    "Bound of CI for Mean of Response, Mean of Upper Bound of CI for Mean of Response by ",
    "koulutustaso..."))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include(
"0", "1", "2"))
  ELEMENT: point(position(koulutus*SUMMARY), color.interior(INDEX))
  ELEMENT: interval(position(region.spread.range(koulutus*SUMMARY)),shape(shape.line))
END GPL.


SPLIT FILE OFF.

* Malli 1, ennustetut todennäköisyydet, Wald CI95%.
GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus f5 vuosijakso3 (ORDER=ASCENDING) WITH ika 
    ika_toiseen
  /MODEL f2_1 koulutus ika ika_toiseen f5 vuosijakso3 INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=1 COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=5 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.

* Malli 5, ennustetut todennäköisyydet koul by vuosijakso, Wald CI95%.
GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus f5 vuosijakso3 totu_2lk tyoton (ORDER=ASCENDING) 
    WITH ika ika_toiseen koulutusvanhemmat_summa luottamus_summa
  /MODEL f2_1 koulutus ika ika_toiseen f5 vuosijakso3 koulutusvanhemmat_summa totu_2lk tyoton 
    luottamus_summa INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=1 COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=5 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=koulutus*vuosijakso3 SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.


*Splitataan data jälleen sukupuolen mukaan:

SORT CASES  BY f2_1.
SPLIT FILE SEPARATE BY f2_1.

* Malli 1, ennustetut todennäköisyydet, Wald CI95%.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=koulutus MEAN(MeanPredicted_2) 
    MEAN(CIMeanPredictedLower_2) MEAN(CIMeanPredictedUpper_2) MISSING=LISTWISE REPORTMISSING=NO
    TRANSFORM=VARSTOCASES(SUMMARY="#SUMMARY" INDEX="#INDEX")
  /GRAPHSPEC SOURCE=INLINE
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: koulutus=col(source(s), name("koulutus"), unit.category())
  DATA: SUMMARY=col(source(s), name("#SUMMARY"))
  DATA: INDEX=col(source(s), name("#INDEX"), unit.category())
  GUIDE: axis(dim(1), label("koulutustaso"))
  GUIDE: axis(dim(2), label("Mean"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label(""))
  GUIDE: text.title(label("Drop-line Mean of Malli 1: Predicted Value of Mean of Response, Mean ",
    "of Malli 1: Lower Bound of CI for Mean of Response, Mean of Malli 1: Upper Bound of CI for ",
    "Mean of Response by koulutustaso..."))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include(
"0", "1", "2"))
  ELEMENT: point(position(koulutus*SUMMARY), color.interior(INDEX))
  ELEMENT: interval(position(region.spread.range(koulutus*SUMMARY)),shape(shape.line))
END GPL.

* GRAAFI: Malli 5, ennustetut todennäköisyydet, Wald CI95%.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=koulutus MEAN(MeanPredicted_3) 
    MEAN(CIMeanPredictedLower_3) MEAN(CIMeanPredictedUpper_3) MISSING=LISTWISE REPORTMISSING=NO
    TRANSFORM=VARSTOCASES(SUMMARY="#SUMMARY" INDEX="#INDEX")
  /GRAPHSPEC SOURCE=INLINE
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: koulutus=col(source(s), name("koulutus"), unit.category())
  DATA: SUMMARY=col(source(s), name("#SUMMARY"))
  DATA: INDEX=col(source(s), name("#INDEX"), unit.category())
  GUIDE: axis(dim(1), label("koulutustaso"))
  GUIDE: axis(dim(2), label("Mean"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label(""))
  GUIDE: text.title(label("Drop-line Mean of Malli 5: Predicted Value of Mean of Response, Mean ",
    "of Malli 5: Lower Bound of CI for Mean of Response, Mean of Malli 5: Upper Bound of CI for ",
    "Mean of Response by koulutustaso..."))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include(
"0", "1", "2"))
  ELEMENT: point(position(koulutus*SUMMARY), color.interior(INDEX))
  ELEMENT: interval(position(region.spread.range(koulutus*SUMMARY)),shape(shape.line))
END GPL.




* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=koulutus MEAN(MeanPredicted_3) 
    MEAN(CIMeanPredictedUpper_3) MEAN(CIMeanPredictedLower_3) MISSING=LISTWISE REPORTMISSING=NO
    TRANSFORM=VARSTOCASES(SUMMARY="#SUMMARY" INDEX="#INDEX")
  /GRAPHSPEC SOURCE=INLINE
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: koulutus=col(source(s), name("koulutus"), unit.category())
  DATA: SUMMARY=col(source(s), name("#SUMMARY"))
  DATA: INDEX=col(source(s), name("#INDEX"), unit.category())
  GUIDE: axis(dim(1), label("Koulutusaste"))
  GUIDE: axis(dim(2), label("Mean"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label(""))
  GUIDE: text.title(label("Drop-line Mean of Malli 5: Predicted Value of Mean of Response, Mean ",
    "of Malli 5: Upper Bound of CI for Mean of Response, Mean of Malli 5: Lower Bound of CI for ",
    "Mean of Response by Koulutusaste..."))
  SCALE: cat(dim(1), include("1.00", "2.00", "3.00"))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include(
"2", "0", "1"))
  ELEMENT: point(position(koulutus*SUMMARY), color.interior(INDEX))
  ELEMENT: interval(position(region.spread.range(koulutus*SUMMARY)),shape(shape.line))
END GPL.

* Malli 1, ennustetut todennäköisyydet, pelkkä koulutus, Wald 95CI.
GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus f5 vuosijakso3 (ORDER=ASCENDING) WITH ika 
    ika_toiseen
  /MODEL f2_1 koulutus ika ika_toiseen f5 vuosijakso3 INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=DEVIANCE COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=50 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=koulutus SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.

* Malli 5, ennustetut todennäköisyydet, pelkkä koulutus.
GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus f5 vuosijakso3 totu_2lk tyoton (ORDER=ASCENDING) 
    WITH ika ika_toiseen koulutusvanhemmat_summa luottamus_summa
  /MODEL f2_1 koulutus ika ika_toiseen f5 vuosijakso3 koulutusvanhemmat_summa totu_2lk tyoton 
    luottamus_summa INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=DEVIANCE COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=50 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=koulutus SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.

*Malli 1, ennusteet ja luottamusvälit.

MEANS TABLES=MeanPredicted_7 CIMeanPredictedLower_7 CIMeanPredictedUpper_7 BY koulutus
  /CELLS=MEAN COUNT STDDEV.

*Malli 5, ennusteet ja luottamusvälit.
MEANS TABLES=MeanPredicted_5 CIMeanPredictedLower_5 CIMeanPredictedUpper_5 BY koulutus
  /CELLS=MEAN COUNT STDDEV.


