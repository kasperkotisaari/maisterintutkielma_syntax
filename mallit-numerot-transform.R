
interaktiot_txt1 <- read.csv2("~/Documents/interaktiot_txt1.txt")

interaktiot_txt1 <- as.data.frame(interaktiot_txt1)


View(interaktiot_txt1)

int13m <- interaktiot_txt1[1:20,]

int13m <- t(int13m)
int13m

int13n <- interaktiot_txt1[21:40,]

int13n <- t(int13n)

int13n

write.table(int13n, file="~/Documents/int13n.txt")

int13n



int46m <- interaktiot_txt1[41:54,]
int46m <- t(int46m)
int46m


int46n <- interaktiot_txt1[55:68,]
int46n <- t(int46n)
int46n


piste_estim <- read.csv("~/Documents/piste-estim.txt", header=FALSE, sep=";")

piste_estim <- t(piste_estim)

piste_estim