
#DATA:

x <- c(1,2,3)
levels(x) <- c("Perusaste", "Toinen aste", "Korkea-aste")

#malli 1, naiset:
m1meansn <- c(  0.23314,   0.15139,     0.11127  )
m1lowersn <- c(  0.20792,   0.13414,     0.09715  )
m1uppersn <- c( 0.26036,   0.17037,     0.12711   )
Nm1n <- 9169

#malli 5, naiset:
m5meansn <- c( 0.23268,   0.14775,     0.11307   )
m5lowersn <- c( 0.20824,   0.13088,     0.09901   )
m5uppersn <- c( 0.25887,   0.16624,     0.12876   )
Nm5n <- 8572

#malli 1, miehet:
m1meansm <- c( 0.04063,   0.02727,     0.02098   )
m1lowersm <- c( 0.03412,   0.02302,     0.01750   )
m1uppersm <- c( 0.04832,   0.03227,     0.02514   )
Nm1m <- 8693

#malli 5, miehet:
m5meansm <- c( 0.03776,   0.02463,     0.01896   )
m5lowersm <- c( 0.03182,   0.02077,     0.01587   )
m5uppersm <- c( 0.04474,   0.02918,     0.02263   )
Nm5m <- 8169


#TIEDOT SISÄÄN PLOTTAUKSEEN:

meanss <- m5meansm
lowws <- m5lowersm
upps <- m5uppersm

####### RESET #############

dev.off()

###########################
#palette()

#par(bg="#EEEEEE")
par(mar=c(6,5,4,4))
plot(x, meanss, pch=c(1,2,5), cex= 1.5, xlim = c(0.5,3.5),
     ylim=c(0,0.1), xaxt="n", col = c(perus, toinen, korkea), xlab = "", ylab=""
)
rect(par("usr")[1], par("usr")[3],
     par("usr")[2], par("usr")[4],
     col = "#EEEEEE") # Color

par(new = TRUE)

#värit:
perus <-  "#6AC7AE"
toinen <-  "#FF00FF"
korkea <- "#FD8210"

# muita värejä   "#3CC3BD", "#FD8210"

plot(x, meanss, pch=c(1,2,5), cex= 1.5, xlab="Koulutusaste", 
     ylab="Ennustetut todennäköisyydet: turvattomuuden kokeminen", 
     main="Malli 5: Asuinalueella koettu turvattomuus \n koulutusasteen mukaan, miesvastaajat",
     xlim = c(0.5,3.5),ylim=c(0,0.1), xaxt="n", col = c(perus, toinen, korkea)
)

grid(nx = FALSE, ny = NULL, lty = 1, col = "white", lwd = 2)
abline(v=c(1,2,3), col="white", lwd=2)
arrows(x, lowws, x, upps, length = 0.19, angle = 90, code = 3, col=c(perus, toinen, korkea))
axis(1, at = c(1,2,3), labels=levels(x))
points(x, meanss, pch=c(1,2,5), cex= 1.5, lwd=2, col = c(perus, toinen, korkea))
arrows(x, lowws, x, upps, length = 0.19, angle = 90, code = 3, lwd = c(2,2,2), col=c(perus, toinen, korkea))

legend("topright", legend=c("Perusaste", "Toinen aste", "Korkea-aste"),
       col=c(perus, toinen, korkea), pch=c(1,2,5), cex=1)
legend("bottomright",legend=paste("N = ", Nm5m))

