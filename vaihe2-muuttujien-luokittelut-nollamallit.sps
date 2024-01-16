* Encoding: UTF-8.

FREQUENCIES VARIABLES=fsd_no
  /ORDER=ANALYSIS.

SPLIT FILE OFF.

RECODE fsd_no (1303=2002) (2116=2004) (2342=2006) (2463=2008) (2682=2010) (2922=2012) (3068=2014) 
    (3217=2016) (9=2018) (10=2020) INTO vuosi.
VARIABLE LABELS  vuosi 'vuosi'.
EXECUTE.

* luodaan logistista regressiota varten nollasta ykköseen vaihteleva turvattomuus-ennuste, 0=ei turvattomuutta, 1=turvattomuutta

RECODE turv_2lk (1=0) (2=1) INTO turv_dik.
VARIABLE LABELS  turv_dik 'turvattomuus predictor'.
EXECUTE.

RECODE fsd_no (9=3) (10=SYSMIS) (1303 thru 2342=1) (2463 thru 2922=2) (3068 thru 3217=3) INTO 
    vuosijakso3.
VARIABLE LABELS  vuosijakso3 'vuosijakso'.
EXECUTE.

COMPUTE koulutusvanhemmat_summa=((koulutus_isa)+(koulutus_aiti))/2.
EXECUTE.

RECODE luottamus_summa (0 thru 2.5=1) (2.500001 thru 5=2) (5.000001 thru 7.5=3) (7.500001 thru 
    10=4) INTO luottamus_luok.
VARIABLE LABELS  luottamus_luok 'Sosiaalinen luottamus (luokiteltu)'.
EXECUTE.

SORT CASES  BY f2_1.
SPLIT FILE SEPARATE BY f2_1.

RECODE ika (0 thru 24=1) (25 thru 34=2) (35 thru 44=3) (45 thru 54=4) (55 thru 64=5) (65 thru 74=6) 
    (75 thru Highest=7) INTO ikaluokiteltu.
VARIABLE LABELS  ikaluokiteltu 'ikäryhmät'.
EXECUTE.

COMPUTE ika_toiseen=(ika) * (ika).
EXECUTE.

RECODE koulutusvanhemmat_summa (ELSE=Copy) INTO vanh_koul.
EXECUTE.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=ikaluokiteltu MEANCI(turv_2lk, 
    95)[name="MEAN_turv_2lk" LOW="MEAN_turv_2lk_LOW" HIGH="MEAN_turv_2lk_HIGH"] MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: ikaluokiteltu=col(source(s), name("ikaluokiteltu"), unit.category())
  DATA: MEAN_turv_2lk=col(source(s), name("MEAN_turv_2lk"))
  DATA: LOW=col(source(s), name("MEAN_turv_2lk_LOW"))
  DATA: HIGH=col(source(s), name("MEAN_turv_2lk_HIGH"))
  GUIDE: axis(dim(1), label("ikäryhmät"))
  GUIDE: axis(dim(2), label("Mean koettu turvallisuus, dikotominen"))
  GUIDE: text.title(label("Simple Error Bar Mean of koettu turvallisuus, dikotominen by ikäryhmät"))    
  GUIDE: text.footnote(label("Error Bars: 95% CI"))
  SCALE: cat(dim(1), include("1.00", "2.00", "3.00", "4.00", "5.00", "6.00", "7.00"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: point(position(ikaluokiteltu*MEAN_turv_2lk))
  ELEMENT: interval(position(region.spread.range(ikaluokiteltu*(LOW+HIGH))), 
    shape.interior(shape.ibeam))
END GPL.



*Koko aineiston tason interaktiot, taulukko 5:
    
*koulutusasteen ja sukupuolen interaktio:
    
LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus f2_1 f2_1*koulutus 
  /CONTRAST (koulutus)=Indicator
  /CONTRAST (f2_1)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*Sukupuolen ja vuosijakson interaktio:

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER f2_1 vuosijakso3 f2_1*vuosijakso3 
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (f2_1)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* Koulutusasteen ja vuosijakson interaktio:
    
LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus  vuosijakso3 koulutus*vuosijakso3 
  /CONTRAST (vuosijakso3)=Indicator
  /CONTRAST (koulutus)=Indicator
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*ennusteet koko aineisto, koulutus by vuosijakso
* Generalized Linear Models.
GENLIN turv_dik (REFERENCE=FIRST) BY koulutus vuosijakso3 (ORDER=ASCENDING)
  /MODEL koulutus vuosijakso3 koulutus*vuosijakso3 INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=1 COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=50 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /EMMEANS TABLES=koulutus*vuosijakso3 SCALE=ORIGINAL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION
  /SAVE MEANPRED CIMEANPREDL CIMEANPREDU PREDVAL.

*talteen ennusteen numeroarvot:
    
MEANS TABLES=MeanPredicted_17 CIMeanPredictedLower_17 CIMeanPredictedUpper_17 BY koulutus
  /CELLS=MEAN COUNT.



*****************************
    NOLLAMALLIT
*****************************


*nollamalli: koulutusaste
/*
LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus 
  /CONTRAST (koulutus)=Simple(3)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

*/

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus 
  /CONTRAST (koulutus)=Simple
  /PRINT=CI(95)
 /* /SAVE=PRED */
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*nollamalli2: vakioitavat

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ikaluokiteltu koulutusvanhemmat_summa vuosijakso3 
  /CONTRAST (koulutus)=Simple
  /CONTRAST (ikaluokiteltu)=Simple
  /CONTRAST (koulutusvanhemmat_summa)=Simple
  /CONTRAST (vuosijakso3)=Simple
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ikaluokiteltu vuosijakso3 koulutusvanhemmat_summa 
  /CONTRAST (koulutus)=Simple
  /CONTRAST (ikaluokiteltu)=Simple
  /CONTRAST (vuosijakso3)=Simple
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*VAKIOIDUT

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_2 koulutusvanhemmat_summa vuosijakso3 
  /CONTRAST (koulutus)=Simple
  /CONTRAST (vuosijakso3)=Simple
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


RECODE pttiiv6 (3=1) (ELSE=0) INTO tyoton.
VARIABLE LABELS  tyoton 'ei työssä'.
EXECUTE.

*LISÄTÄÄN ASUINALUEEN TYYPPI

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_2 koulutusvanhemmat_summa vuosijakso3 f5 
  /CONTRAST (koulutus)=Simple
  /CONTRAST (vuosijakso3)=Simple
  /CONTRAST (f5)=Simple
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*LISÄTÄÄN SOSIAALINEN LUOTTAMUS

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_2 koulutusvanhemmat_summa vuosijakso3 f5 luottamus_summa 
  /CONTRAST (koulutus)=Simple
  /CONTRAST (vuosijakso3)=Simple
  /CONTRAST (f5)=Simple
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*LISÄTÄÄN KOKEMUS TOIMEENTULOSTA:
    
LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_2 koulutusvanhemmat_summa vuosijakso3 f5 luottamus_summa totu_2lk
  /CONTRAST (koulutus)=Simple
  /CONTRAST (vuosijakso3)=Simple
  /CONTRAST (f5)=Simple
  /CONTRAST (totu_2lk)=Simple(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*LISÄTÄÄN ONKO TYÖTÖN TAI TYÖKYVYTÖN:
    
*KOKO MALLI:
    
LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutus ika ika_2 koulutusvanhemmat_summa vuosijakso3 f5 luottamus_summa totu_2lk tyoton 
  /CONTRAST (koulutus)=Simple
  /CONTRAST (vuosijakso3)=Simple
  /CONTRAST (f5)=Simple
  /CONTRAST (totu_2lk)=Simple(1)
  /CONTRAST (tyoton)=Simple(1)
   /PRINT=CI(95)
/* /SAVE=PRED */
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


*NOLLAMALLIT:

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER ika
   /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER ika ika_2
   /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER koulutusvanhemmat_summa
   /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER vuosijakso3 
  /CONTRAST (vuosijakso3)=Simple
   /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER f5 
  /CONTRAST (f5)=Simple
   /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES turv_dik    
    /METHOD=ENTER luottamus_summa
    /PRINT=CI(95)
     /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER totu_2lk
  /CONTRAST (totu_2lk)=Simple(1)
   /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER tyoton
  /CONTRAST (tyoton)=Simple(1)
   /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*NOLLAMALLIT PÄÄTTYY
    

*vikoja kokeiluita vielä:

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER vanh_koul
  /CONTRAST (vanh_koul)=Simple
   /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER vanh_koul
  /CONTRAST (vanh_koul)=Simple(1)
   /PRINT=CI(95)
  /* /SAVE=PRED */
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

RECODE turv_dik (ELSE=Copy) INTO turv_predictor.
VARIABLE LABELS  turv_predictor 'turv_dikotominen_jatkuvana'.
EXECUTE.

LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER f5
  /CONTRAST (f5)=Simple(1)
   /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).







