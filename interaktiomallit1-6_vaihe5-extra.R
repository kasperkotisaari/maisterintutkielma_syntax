


#Vuosimuuttujan muodostaminen:

x <- c(1,2,3)
levels(x) <- c("2002-2006", "2008-2012", "2014-2018")


#Ennustettujen todennäköisyyksien syöttäminen:

#interaktiomalli 1, naiset:

int1nperusmeans <- c(.22783, .22721,.21209)
int1nperuslowers <- c(.21861,.21715,.20038)
int1nperusuppers <- c( .23732,.23759,.22430)

int1ntokameans <- c(.16823,.14673,.14142)
int1ntokalowers <- c(.15955,.13974,.13464)
int1ntokauppers <- c(.17727,.15401,.14848)

int1nkorkmeans<- c(.15211,.10602,.07368)
int1nkorklowers<- c(.14348,.09831,.06740)
int1nkorkuppers <- c(.16116,.11425,.08050)
Nint1n <- 9221

#interaktiomalli 3, naiset

int3nperusmeans <- c( .23597,.24307,.21147  )
int3nperuslowers <- c( .20930,.21617,.18368 )
int3nperusuppers <- c(  .26467, .27195,.24197 )

int3ntokameans <- c( .16309,.14538,.13910 )
int3ntokalowers <- c( .14219, .12753,.12173 )
int3ntokauppers <- c( .18620,.16511,.15835 )

int3nkorkmeans<- c(.15607,.10403, .07554  )
int3nkorklowers<- c( .13582, .08789,.06268 )
int3nkorkuppers <- c( .17853,.12260,.09070 )
Nint3n <- 8642

#interaktiomalli 1, miehet:

int1perusmeansm <- c(  0.04316,    0.04301,    0.03952 )
int1peruslowersm <- c( 0.04035,    0.04007,    0.03645  )
int1perusuppersm <- c( 0.04615,    0.04615,    0.04285  )

int1tokameansm <- c( 0.02999,     0.02561,     0.02456  )
int1tokalowersm <- c( 0.02781,     0.02385,     0.02286  )
int1tokauppersm <- c( 0.03233,     0.02751,     0.02638  )

int1korkmeansm <- c( 0.02669,     0.01780,     0.01201  )
int1korklowersm <- c( 0.02458,     0.01618,     0.01080  )
int1korkuppersm <- c(0.02897,     0.01958,     0.01336   )
Nint1m <- 8706

#interaktiomalli 3, miehet:

int3perusmeansm <- c( .03857,     .04030,     .03294  )
int3peruslowersm <- c( .03218,     .03366,     .02687  )
int3perusuppersm <- c( .04613,     .04815,     .04028  )

int3tokameansm <- c( .02712,      .02396,      .02311  )
int3tokalowersm <- c( .02247,      .02001,      .01927  )
int3tokauppersm <- c( .03268,      .02865,      .02769  )

int3korkmeansm <- c( .02808,      .01688,      .01226  )
int3korklowersm <- c( .02321,      .01369,      .00980  )
int3korkuppersm <- c( .03394,      .02080,      .01532  )
Nint3m <- 8188


#Interaktiomalli 4, miehet:

int4toimeenmeansm <- c(  .03243,        .02479,        .02071  )
int4toimeenlowersm <- c(  .02687,        .02041,        .01690  )
int4toimeenuppersm <- c( .03909,        .03010,        .02536   )

int4vaikmeansm <- c( .04916,                   .05645,                   .05047   )
int4vaiklowersm <- c( .03742,                   .04363,                   .03817   )
int4vaikuppersm <- c( .06433,                   .07273,                   .06646   )


Nint4m <- 8664

#Interaktiomalli 6, miehet:

int6toimeenmeansm <- c( .02951,        .02317,        .01893   )
int6toimeenlowersm <- c( .02488,        .01956,        .01590   )
int6toimeenuppersm <- c( .03495,        .02744,        .02252   )

int6vaikmeansm <- c( .04593,                   .05255,                   .04629   )
int6vaiklowersm <- c( .03706,                   .04292,                   .03705   )
int6vaikuppersm <- c( .05675,                   .06410,                   .05764   )


Nint6m <- 8157

#Interaktiomalli 4, naiset:

int4toimeenmeansn <- c(  .17372,        .13984,        .11797  )
int4toimeenlowersn <- c( .15433,        .12296,        .10245   )
int4toimeenuppersn <- c( .19500,        .15861,        .13548  )

int4vaikmeansn <- c(  .24686,                   .27064,                   .24854   )
int4vaiklowersn <- c( .20321,                   .22667,                   .20316   )
int4vaikuppersn <- c( .29636,                   .31959,                   .30018   )

Nint4n <- 9165

#Interaktiomalli 6, naiset:

int6toimeenmeansn <- c( .17442,        .14140,        .11865   )
int6toimeenlowersn <- c(.15507,        .12526,        .10437    )
int6toimeenuppersn <- c(.19549,        .15915,        .13450    )

int6vaikmeansn <- c(  .24546,                    .26846,                   .23024  )
int6vaiklowersn <- c( .21152,                   .23482,                   .19716   )
int6vaikuppersn <- c( .28259,                   .30473,                   .26670   )

Nint6n <- 8606



#Koko aineisto, koulutusaste by vuosi:

ex1perusmeans <- c( 0.14042, 0.13818, 0.12339   )
ex1peruslowers <- c( 0.12644, 0.12312, 0.10672   )
ex1perusuppers <- c( 0.15568, 0.15475, 0.14225   )

ex1tokameans <- c( 0.09519, 0.08459, 0.08192   )
ex1tokalowers <- c( 0.08336, 0.07493, 0.07254   )
ex1tokauppers <- c( 0.10850, 0.09536, 0.09239   )

ex1korkmeans <- c( 0.10048, 0.06595, 0.04621   )
ex1korklowers <- c( 0.08689, 0.05476, 0.03716   )
ex1korkuppers <- c( 0.11594, 0.07925, 0.05732   )

Nex1 <- (17928)




#TÄSTÄ ETEENPÄIN SYÖTETÄÄN PIIRTURIIN MUUTTUJIA:

# warnings()

#################################################
#y1-y3 1. kategoria
#y4-y6 2. kategoria:

#means y3
y3 <- int4toimeenmeansm
#lowers y2
y2 <- int4toimeenlowersm
#uppers y1
y1 <- int4toimeenuppersm

y4 <- int4vaikmeansm
y5 <- int4vaiklowersm
y6 <- int4vaikuppersm
  
#Malleissa 1-3 käytetään kolmannelle asteelle seuraavia:
#y7-y9 kolmas kategoria

y7 <- int1nkorkmeans
y8 <- int1nkorklowers
y9 <- int1nkorkuppers



#extra
y3 <- ex1perusmeans
y2 <- ex1peruslowers
y1 <- ex1perusuppers
y4 <- ex1tokameans
y5 <- ex1tokalowers
y6 <- ex1tokauppers
y7 <- ex1korkmeans
y8 <- ex1korklowers
y9 <- ex1korkuppers



####### RESET ###########

dev.off()

#########################


########### MIES(MODATTU-katso edellinen fileversio)VASTAAJIEN SKAALA: #############

#par(oma=c(2,2,2,2))
par(mar=c(6,6,6,10))
# plottaus alkaa
plot(x, y2, type = "b", pch=5, frame = FALSE, lty= 3, lwd=1,
     col = "#6BD7AF", xlab = "vuosijakso", ylab = "Ennustettu todennäköisyys:\n turvattomuuden kokeminen", 
     main = "Kaikki vastaajat, koulutusasteen ja vuosijakson interaktio", xlim = c(0.8,3.2),ylim=c(0,0.2), xaxt="n")
axis(1, at = c(1,2,3), labels=levels(x))

#naiset axis(2, at=seq(0,0.3,by=0.05)) // nämä mätchättävä myös ekaan plot()-funktioon
#naiset axis(2, at=seq(0,0.35,by=0.05))
#miehet axis(2, at=seq(0,0.1,by=0.02))

axis(2, at=seq(0,0.2,by=0.05))
#title(ylab="Ennustettu todennäköisyys:\n turvattomuuden kokeminen", line=2, cex.lab=1.2)
# Add a second line
lines(x, y1, col = "#6BD7AF", type = "b", pch=2, lty = 2, lwd=1)
polygon(c(x, rev(x)), c(y2, rev(y1)),
        col = "#6BD7AF",
        density = 10, angle = 45, border=0)
lines(x, y1, col = "#6BD7AF", type = "b", pch=2, lty = 3, lwd=1)
lines(x, y2, col = "#6BD7AF", type = "b", pch=2, lty = 2, lwd=1)
lines(x, y3, pch = 2, col = "blue", type = "b", lty = 1)



grid(nx = NULL,
     ny = NULL,
     lty = 2, col = "lightgray", lwd = 1)

#lisätään toinen kategoria
#värejä esim "#3CC3BD" "#FD8210"
lines(x, y5, col = "#FD8210", type = "b", pch=1, lty = 3, lwd=1)
lines(x, y6, col = "#FD8210", type = "b", pch=1, lty = 3, lwd=1)
polygon(c(x, rev(x)), c(y5, rev(y6)),
        col = "#FD8210",
        density = 10, angle = 10, border=0)
lines(x, y5, col = "#FD8210", type = "b", pch=1, lty = 2, lwd=1)
lines(x, y6, col = "#FD8210", type = "b", pch=1, lty = 3, lwd=1)
lines(x, y4, pch = 1, col = "#FF00FF", type = "b", lty = 1)


#lisätään kolmas kategoria
lines(x, y8, col = "#7bfff5", type = "b", pch=2, lty = 2, lwd=1)
lines(x, y9, col = "#7bfff5", type = "b", pch=2, lty = 3, lwd=1)

polygon(c(x, rev(x)), c(y8, rev(y9)),
        col = "#7bddff",
        density = 10, angle = 125, border=0)

lines(x, y8, col = "#7bddff", type = "b", pch=2, lty = 2, lwd=1)
lines(x, y9, col = "#7bddff", type = "b", pch=2, lty = 3, lwd=1)
lines(x, y7, col = "#9b58fc", type = "b", pch=2, lty = 1, lwd=1)

# Legend koulutusasteen mukaan
legend("topright", inset=c(-0.23,0), xpd=TRUE, legend=c("Perusaste", "CI95% ylempi", "CI95% alempi"),
       col=c("blue", "#6BD7AF", "#6BD7AF"), lty = c(1,3,2), pch=5, cex=0.9)
legend("topright", inset=c(-0.23,0.11), xpd=TRUE, legend=c("Toinen aste", "CI95% ylempi", "CI95% alempi"),
       col=c("#FF00FF", "#FD8210", "#FD8210"), lty = c(1,3,2), pch=1, cex=0.9)
legend("topright", inset=c(-0.23,0.22), xpd=TRUE, legend=c("Korkea-aste", "CI95% ylempi", "CI95% alempi"),
       col=c("#9b58fc", "#7bfff5", "#7bfff5"), lty = c(1,3,2), pch=2, cex=0.9)
#legend("topright", inset=c(-0.23,0.34), xpd=TRUE, legend="(N = 8188)")

legend("bottomright",inset=c(-0.21,0), xpd=TRUE, legend=paste("N = ", Nex1))

################################################

#legend toimeentulon mukaan
legend("topright", inset=c(-0.23,0.11), xpd=TRUE, legend=c("Tulee toimeen", "CI95% ylempi", "CI95% alempi"),
       col=c("blue", "#6BD7AF", "#6BD7AF"), lty = c(1,3,2), pch=2, cex=0.9)
legend("topright", inset=c(-0.23,0), xpd=TRUE, legend=c("Vaikeuksia tulla toimeen", "CI95% ylempi", "CI95% alempi"),
       col=c("#FF00FF", "#FD8210", "#FD8210"), lty = c(1,3,2), pch=1, cex=0.9)
legend("bottomright",inset=c(-0.21,0), xpd=TRUE, legend=paste("N = ", Nint4m))




dev.off()















########### NAISVASTAAJIEN SKAALA:   ###########

#par(oma=c(2,2,2,2))
par(mar=c(6,6,6,10))
# plottaus alkaa
plot(x, y2, type = "b", pch=5, frame = FALSE, lty= 3, lwd=1,
     col = "#6BD7AF", xlab = "vuosijakso", ylab = "Ennustettu todennäköisyys:\n turvattomuuden kokeminen", main = "Interaktiomalli 3, naisvastaajat", xlim = c(0.8,3.2),ylim=c(0,0.3), xaxt="n")
axis(1, at = c(1,2,3), labels=levels(x))
axis(2, at=seq(0,0.3,by=0.05))
#title(ylab="Ennustettu todennäköisyys:\n turvattomuuden kokeminen", line=2, cex.lab=1.2)
# Add a second line
lines(x, y1, col = "#6BD7AF", type = "b", pch=5, lty = 2, lwd=1)
polygon(c(x, rev(x)), c(y2, rev(y1)),
        col = "#6BD7AF",
        density = 10, angle = 45, border=0)
lines(x, y1, col = "#6BD7AF", type = "b", pch=5, lty = 3, lwd=1)
lines(x, y2, col = "#6BD7AF", type = "b", pch=5, lty = 3, lwd=1)
lines(x, y3, pch = 5, col = "blue", type = "b", lty = 1)



grid(nx = NULL,
     ny = NULL,
     lty = 2, col = "lightgray", lwd = 1)

#lisätään toinen aste
#värejä esim "#3CC3BD" "#FD8210"
lines(x, y5, col = "#FD8210", type = "b", pch=1, lty = 3, lwd=1)
lines(x, y6, col = "#FD8210", type = "b", pch=1, lty = 3, lwd=1)
polygon(c(x, rev(x)), c(y5, rev(y6)),
        col = "#FD8210",
        density = 10, angle = 10, border=0)
lines(x, y5, col = "#FD8210", type = "b", pch=1, lty = 3, lwd=1)
lines(x, y6, col = "#FD8210", type = "b", pch=1, lty = 3, lwd=1)
lines(x, y4, pch = 1, col = "#FF00FF", type = "b", lty = 1)


#lisätään kolmas aste
lines(x, y8, col = "#7bfff5", type = "b", pch=2, lty = 3, lwd=1)
lines(x, y9, col = "#7bfff5", type = "b", pch=2, lty = 3, lwd=1)

polygon(c(x, rev(x)), c(y8, rev(y9)),
        col = "#7bddff",
        density = 10, angle = 125, border=0)

lines(x, y8, col = "#7bddff", type = "b", pch=2, lty = 3, lwd=1)
lines(x, y9, col = "#7bddff", type = "b", pch=2, lty = 3, lwd=1)
lines(x, y7, col = "#9b58fc", type = "b", pch=2, lty = 1, lwd=1)

# Legend
legend("topright", inset=c(-0.23,0), xpd=TRUE, legend=c("Perusaste", "CI95% ylempi", "CI95% alempi"),
       col=c("blue", "#6BD7AF", "#6BD7AF"), lty = c(1,3,2), pch=5, cex=0.9)
legend("topright", inset=c(-0.23,0.11), xpd=TRUE, legend=c("Toinen aste", "CI95% alempi", "CI95% ylempi"),
       col=c("#FF00FF", "#FD8210", "#FD8210"), lty = c(1,3,2), pch=1, cex=0.9)
legend("topright", inset=c(-0.23,0.22), xpd=TRUE, legend=c("Korkea-aste", "CI95% alempi", "CI95% ylempi"),
       col=c("#9b58fc", "#7bfff5", "#7bfff5"), lty = c(1,3,2), pch=2, cex=0.9)
legend("bottomright",inset=c(-0.21,0), xpd=TRUE, legend=paste("N = ", Nint6m))


#####################################################

dev.off()






par(plot.new())


warnings()