


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

int4toimeenmeansn <- c(    )
int4toimeenlowersn <- c(    )
int4toimeenuppersn <- c(    )

int4vaikmeansn <- c(    )
int4vaiklowersn <- c(    )
int4vaikuppersn <- c(    )

Nint4n <- 9165

#Interaktiomalli 6, naiset:

int6toimeenmeansn <- c(    )
int6toimeenlowersn <- c(    )
int6toimeenuppersn <- c(    )

int6vaikmeansn <- c(    )
int6vaiklowersn <- c(    )
int6vaikuppersn <- c(    )

Nint6n <- 8606


#TÄSTÄ ETEENPÄIN SYÖTETÄÄN PIIRTURIIN MUUTTUJIA:

# warnings()

#################################################
#y1-y3 1. kategoria
#y4-y6 2. kategoria:

#means y3
y3 <- int6toimeenmeansm
#lowers y2
y2 <- int6toimeenlowersm
#uppers y1
y1 <- int6toimeenuppersm

y4 <- int6vaikmeansm
y5 <- int6vaiklowersm
y6 <- int6vaikuppersm
  
#Malleissa 1-3 käytetään kolmannelle asteelle seuraavia:
#y7-y9 kolmas kategoria

y7 <- int3nkorkmeans
y8 <- int3nkorklowers
y9 <- int3nkorkuppers


dev.off()

########### MIESVASTAAJIEN SKAALA: #############

#par(oma=c(2,2,2,2))
par(mar=c(6,6,6,10))
# plottaus alkaa
plot(x, y2, type = "b", pch=5, frame = FALSE, lty= 3, lwd=1,
     col = "#6BD7AF", xlab = "vuosijakso", ylab = "Ennustettu todennäköisyys:\n turvattomuuden kokeminen", main = "Interaktiomalli 6, miesvastaajat", xlim = c(0.8,3.2),ylim=c(0,0.1), xaxt="n")
axis(1, at = c(1,2,3), labels=levels(x))
axis(2, at=seq(0,0.1,by=0.02))
#title(ylab="Ennustettu todennäköisyys:\n turvattomuuden kokeminen", line=2, cex.lab=1.2)
# Add a second line
lines(x, y1, col = "#6BD7AF", type = "b", pch=2, lty = 2, lwd=1)
polygon(c(x, rev(x)), c(y2, rev(y1)),
        col = "#6BD7AF",
        density = 10, angle = 45, border=0)
lines(x, y1, col = "#6BD7AF", type = "b", pch=2, lty = 3, lwd=1)
lines(x, y2, col = "#6BD7AF", type = "b", pch=2, lty = 3, lwd=1)
lines(x, y3, pch = 2, col = "blue", type = "b", lty = 1)



grid(nx = NULL,
     ny = NULL,
     lty = 2, col = "lightgray", lwd = 1)

#lisätään toinen aste
#värejä esim "#3CC3BD" "#FD8210"
lines(x, y5, col = "#FD8210", type = "b", pch=1, lty = 3, lwd=1)
lines(x, y6, col = "#FD8210", type = "b", pch=1, lty = 3, lwd=1)
polygon(c(x, rev(x)), c(y5, rev(y6)),
        col = "#FD8210",
        density = 10, angle = 125, border=0)
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
#legend("topright", inset=c(-0.23,0.34), xpd=TRUE, legend="(N = 8188)")

legend("bottomright",inset=c(-0.21,0), xpd=TRUE, legend="N = 8706")

################################################

#legend toimeentulon mukaan
legend("topright", inset=c(-0.23,0), xpd=TRUE, legend=c("Tulee toimeen", "CI95% ylempi", "CI95% alempi"),
       col=c("blue", "#6BD7AF", "#6BD7AF"), lty = c(1,3,2), pch=2, cex=0.9)
legend("topright", inset=c(-0.23,0.11), xpd=TRUE, legend=c("Vaikeuksia tulla toimeen", "CI95% alempi", "CI95% ylempi"),
       col=c("#FF00FF", "#FD8210", "#FD8210"), lty = c(1,3,2), pch=1, cex=0.9)
legend("bottomright",inset=c(-0.21,0), xpd=TRUE, legend=paste("N = ", Nint6m))




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
legend("bottomright",inset=c(-0.21,0), xpd=TRUE, legend="N = 8642")


#####################################################

dev.off()






par(plot.new())


warnings()