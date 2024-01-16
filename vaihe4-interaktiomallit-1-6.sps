* Encoding: UTF-8.

SORT CASES  BY f2_1.
SPLIT FILE SEPARATE BY f2_1.

*Interaktiomalli 1:

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus vuosijakso3 koulutus*vuosijakso3 
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaktiomalli 2:
    
LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus vuosijakso3 koulutus*vuosijakso3 ika ika_toiseen f5
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (f5)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaktiomalli 3:
    
LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus vuosijakso3 koulutus*vuosijakso3 ika ika_toiseen f5 koulutusvanhemmat_summa totu_2lk tyoton luottamus_summa
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (totu_2lk)=Indicator(1)
  /CONTRAST (tyoton)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*interaktiomalli 4:
    
LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus totu_2lk vuosijakso3 totu_2lk*vuosijakso3 
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (totu_2lk)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaktiomalli 5:
    
LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus totu_2lk vuosijakso3 totu_2lk*vuosijakso3 ika ika_toiseen f5
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (totu_2lk)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*interaktiomalli 6:
    
LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus totu_2lk vuosijakso3 totu_2lk*vuosijakso3 ika ika_toiseen f5 koulutusvanhemmat_summa totu_2lk tyoton luottamus_summa
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (totu_2lk)=Indicator(1)
  /CONTRAST (tyoton)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*Lasketaan nyt ennustetut todennäköisyydet interaktiomalleille.
*Malleille 1-3 turvattomuuden ennustettu todennäköisyys koulutusaste BY vuosijakso
*Malleille 4-6 turvattomuuden ennustettu todennäköisyys toimeentulo BY vuosijakso



SPLIT FILE OFF.

*Interaktiomalli 1, ennustettu todennäköisyys ja CI95%, koulutus BY vuosijakso: .
GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus vuosijakso3 (ORDER=ASCENDING)
  /MODEL f2_1 koulutus vuosijakso3 koulutus*vuosijakso3 INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=DEVIANCE COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=50 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=koulutus*vuosijakso3 SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.

*Interaktiomalli 2, ennustettu todennäköisyys ja CI95%, koulutus BY vuosijakso: .

GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus vuosijakso3 f5 (ORDER=ASCENDING) WITH ika 
    ika_toiseen
  /MODEL f2_1 koulutus vuosijakso3 koulutus*vuosijakso3 ika ika_toiseen f5 INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=DEVIANCE COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=50 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=koulutus*vuosijakso3 SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.

*Interaktiomalli 3, ennustettu todennäköisyys ja CI95%, koulutus BY vuosijakso: .

GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus vuosijakso3 f5 totu_2lk tyoton (ORDER=ASCENDING) 
    WITH ika ika_toiseen koulutusvanhemmat_summa luottamus_summa
  /MODEL f2_1 koulutus vuosijakso3 koulutus*vuosijakso3 ika ika_toiseen f5 koulutusvanhemmat_summa 
    totu_2lk tyoton luottamus_summa INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=DEVIANCE COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=50 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=koulutus*vuosijakso3 SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.

*Interaktiomalli 4, ennustettu todennäköisyys ja CI95%, toimeentulo BY vuosijakso:
    
GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus totu_2lk vuosijakso3 (ORDER=ASCENDING)
  /MODEL f2_1 koulutus totu_2lk vuosijakso3 totu_2lk*vuosijakso3 INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=DEVIANCE COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=50 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=totu_2lk*vuosijakso3 SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.

*Interaktiomalli 5, ennustettu todennäköisyys ja CI95%, toimeentulo BY vuosijakso:

GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus totu_2lk vuosijakso3 f5 (ORDER=ASCENDING) WITH 
    ika ika_toiseen
  /MODEL f2_1 koulutus totu_2lk vuosijakso3 totu_2lk*vuosijakso3 f5 ika ika_toiseen INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=DEVIANCE COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=50 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=totu_2lk*vuosijakso3 SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.


*Interaktiomalli 6, ennustettu todennäköisyys ja CI95%, toimeentulo BY vuosijakso:

GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus vuosijakso3 f5 totu_2lk tyoton (ORDER=ASCENDING) 
    WITH ika ika_toiseen koulutusvanhemmat_summa luottamus_summa
  /MODEL f2_1 koulutus totu_2lk vuosijakso3 vuosijakso3*totu_2lk ika ika_toiseen f5 
    koulutusvanhemmat_summa tyoton luottamus_summa INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=DEVIANCE COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=50 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=totu_2lk*vuosijakso3 SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.


SORT CASES  BY f2_1.
SPLIT FILE SEPARATE BY f2_1.


*Interaktiomalli 4, keskiarvot, luottamusvälit, koetun turvattomuuden ennustettu todennäköisyys koetun toimeentulon ja vuosijakson mukaan:

MEANS TABLES=MeanPredicted_11 CIMeanPredictedLower_11 CIMeanPredictedUpper_11 BY totu_2lk BY 
    vuosijakso3
  /CELLS=MEAN COUNT STDDEV.

*Interaktiomalli 5, keskiarvot, luottamusvälit, koetun turvattomuuden ennustettu todennäköisyys koetun toimeentulon ja vuosijakson mukaan:

MEANS TABLES=MeanPredicted_12 CIMeanPredictedLower_12 CIMeanPredictedUpper_12 BY totu_2lk BY 
    vuosijakso3
  /CELLS=MEAN COUNT STDDEV.

*Interaktiomalli 6, keskiarvot, luottamusvälit, koetun turvattomuuden ennustettu todennäköisyys koetun toimeentulon ja vuosijakson mukaan:

MEANS TABLES=MeanPredicted_13 CIMeanPredictedLower_13 CIMeanPredictedUpper_13 BY totu_2lk BY 
    vuosijakso3
  /CELLS=MEAN COUNT STDDEV.




*Interaktiomalli 1, keskiarvot, luottamusvälit, koetun turvattomuuden ennustettu todennäköisyys koulutusasteen ja vuosijakson mukaan:

MEANS TABLES=MeanPredicted_8 CIMeanPredictedLower_8 CIMeanPredictedUpper_8 BY koulutus BY 
    vuosijakso3
  /CELLS=MEAN COUNT.

*Interaktiomalli 2, keskiarvot, luottamusvälit, koetun turvattomuuden ennustettu todennäköisyys koulutusasteen ja vuosijakson mukaan:

MEANS TABLES=MeanPredicted_9 CIMeanPredictedLower_9 CIMeanPredictedUpper_9 BY koulutus BY 
    vuosijakso3
  /CELLS=MEAN COUNT.

*Interaktiomalli 3, keskiarvot, luottamusvälit, koetun turvattomuuden ennustettu todennäköisyys koulutusasteen ja vuosijakson mukaan:

MEANS TABLES=MeanPredicted_10 CIMeanPredictedLower_10 CIMeanPredictedUpper_10 BY koulutus BY 
    vuosijakso3
  /CELLS=MEAN COUNT.

*Piste-estimaatit, Malli 1:

MEANS TABLES=MeanPredicted_14 CIMeanPredictedLower_14 CIMeanPredictedUpper_14 BY koulutus
  /CELLS=MEAN COUNT STDDEV.

*Piste-estimaatit, Malli 5:
    
MEANS TABLES=MeanPredicted_15 CIMeanPredictedLower_15 CIMeanPredictedUpper_15 BY koulutus
  /CELLS=MEAN COUNT STDDEV.







* ####################################################
*EKSTRA-TESTIT:

RECODE koulutusvanhemmat_summa (1=1) (1.5 thru 2=2) (2.5 thru 3=3) INTO koul_vanh_tiiv.
VARIABLE LABELS  koul_vanh_tiiv 'vanhempien koulutus tiivistetty'.
EXECUTE.

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus vuosijakso3 ika ika_toiseen f5 koul_vanh_tiiv koul_vanh_tiiv*vuosijakso3 
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (f5)=Indicator
  /CONTRAST (koul_vanh_tiiv)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* Generalized Linear Models.
GENLIN turv_dik (REFERENCE=FIRST) BY f2_1 koulutus vuosijakso3 koul_vanh_tiiv f5 (ORDER=ASCENDING) 
    WITH ika ika_toiseen
  /MODEL f2_1 koulutus f5 koul_vanh_tiiv vuosijakso3 ika ika_toiseen vuosijakso3*koul_vanh_tiiv 
    INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=DEVIANCE COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=50 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS SCALE=ORIGINAL
  /EMMEANS TABLES=koul_vanh_tiiv*vuosijakso3 SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU.

MEANS TABLES=MeanPredicted_16 CIMeanPredictedLower_16 CIMeanPredictedUpper_16 BY koul_vanh_tiiv BY 
    vuosijakso3
  /CELLS=MEAN COUNT.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=vuosijakso3 
    MEAN(MeanPredicted_13)[name="MEAN_MeanPredicted_13"] totu_2lk MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: vuosijakso3=col(source(s), name("vuosijakso3"), unit.category())
  DATA: MEAN_MeanPredicted_13=col(source(s), name("MEAN_MeanPredicted_13"))
  DATA: totu_2lk=col(source(s), name("totu_2lk"), unit.category())
  GUIDE: axis(dim(1), label("vuosijakso"))
  GUIDE: axis(dim(2), label("Mean Interaktiomalli 6, totu BY vuosi: Predicted Value of Mean of ",
    "Response"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Toimeentulo nykyisilla tuloilla, 2lk"))
  GUIDE: text.title(label("Multiple Line Mean of Interaktiomalli 6, totu BY vuosi: Predicted ",
    "Value of Mean of Response by vuosijakso by Toimeentulo nykyisilla tuloilla, 2lk"))
  GUIDE: text.footnote(label("Error Bars: 95% CI"))
  SCALE: cat(dim(1), include("1.00", "2.00", "3.00"))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include(
"1.00", "2.00"))
  ELEMENT: line(position(vuosijakso3*MEAN_MeanPredicted_13), color.interior(totu_2lk), 
    missing.wings())
END GPL.



