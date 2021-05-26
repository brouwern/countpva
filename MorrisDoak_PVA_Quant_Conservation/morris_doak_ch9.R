setwd("~/1_R/MorrisDoak")
tort <- read.csv("MorrisDoak_desert_tortoise_Table8_2A.csv")

i.g <- which(tort$param == "g")
i.s <- which(tort$param == "s")

library(reshape2)

cor(tort[,c("g.70s","g80s.1","g.80s.2")],
    use = "complete.obs")

tort.melt <- melt(data =tort,
     id.vars =c("class","param","name"),
     measure.vars = c("vr70s","vr80s.1","vr80s.2"))

tort.melt$time <- gsub(".*[7][0][s]","1",tort.melt$variable)
tort.melt$time <-gsub(".*[8][0][s].[1]","2",tort.melt$time)
tort.melt$time <-gsub(".*[8][0][s].[2]","3",tort.melt$time)


tort.cast <- dcast(data = tort.melt,
      formula = time ~  param + class,
      value.var = "value")

tort.cast2 <- tort.cast[,-1]

cor.mat.out <- round(cor(tort.cast2,use = "pairwise.complete.obs"),3)
C <- cor.mat.out[-6,-6]

### Making correlated normal values pg 282
eig.cor <- eigen(C)

W <- eig.cor$vectors
D <- diag(eig.cor$values)

#Fix negative and small vital rates (num 3, pg 289)
i.neg <- which(D < 0) 
max.neg.eig <- max(abs(D[i.neg]))
i.cull <- which(D < max.neg.eig & D > 0)
D.m <- D
D.m[i.cull] <- 0
D.m[i.neg] <- 0

#recalc C
C.m <- W%*%D.m%*%t(W) #pg 289 bottom

diag(C.m) #note - not all == 0

#convert to corr matrix
C.fin <- cov2cor(C.m)
diag(C.fin) #note - now all == 1
  

#Remake W and D
eig.cor.fin <- eigen(C.fin)

W.fin <- eig.cor.fin$vectors
D.fin <- diag(eig.cor.fin$values)
D.fin[which(D.fin <0)] <- 0

#Re-do decom of C to get C^1/2
C.sqrt <- W.fin%*%sqrt(D.fin)%*%t(W.fin)



y <- C.sqrt%*%m


