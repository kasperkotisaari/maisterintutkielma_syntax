* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.

SPLIT FILE OFF.

* ennustetut todennäköisyydet sukupuolen ja ikäryhmän mukaan, graafin muodostaminen:


LOGISTIC REGRESSION VARIABLES turv_dik
  /METHOD=ENTER ikaluokiteltu f2_1 
  /CONTRAST (ikaluokiteltu)=Indicator
  /CONTRAST (f2_1)=Indicator
  /SAVE=PRED
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=ikaluokiteltu MEAN(PRE_4)[name="MEAN_PRE_4"] f2_1 
    MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: ikaluokiteltu=col(source(s), name("ikaluokiteltu"), unit.category())
  DATA: MEAN_PRE_4=col(source(s), name("MEAN_PRE_4"))
  DATA: f2_1=col(source(s), name("f2_1"), unit.category())
  GUIDE: axis(dim(1), label("ikäryhmät"))
  GUIDE: axis(dim(2), label("Mean Ennustetut todennäköisyydet: turvattomuuden kokeminen"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Vastaajan sukupuoli"))
  GUIDE: text.title(label("Multiple Line Mean of Ennustetut todennäköisyydet: turvattomuuden ",
    "kokeminen by ikäryhmät by Vastaajan sukupuoli"))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), include(
"1", "2"))
  ELEMENT: line(position(ikaluokiteltu*MEAN_PRE_4), color.interior(f2_1), missing.wings())
END GPL.
