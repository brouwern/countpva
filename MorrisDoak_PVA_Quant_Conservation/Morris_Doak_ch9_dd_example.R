### Morri's and Doak's example of a dd model




A <- matrix(data = c(0    ,0         ,0           ,"b*c*p*s4",
                     "s1" ,0         ,0           ,0         ,
                     0    ,"s2(1-g)" ,"s3(1-g)"   ,0         ,
                     0    ,"s2g"     ,"s3g"       ,"s4")     ,
            byrow = T, nrow = 4)



#(K-s4*n4.t) = number of vacant territories

fnxn.g <- function(K,s4,n4.t,
             s3,n3.t,
             s2,n2.t){
  g <- (K-s4*n4.t)/(s3*n3.t + s2*n2.t)
  return(ifelse(g < 1, g, 1))   #g can be >1 so need to set condition
}


K  <- 10
s1 <- 0.5
s2 <- 0.7 
s3 <- 0.7
s4 <- 0.86
f  <- 0.5*0.6*2.9

n0 <- c(4,2,0,5)

n4.t <- 5
n3.t <- 10
n2.t <- 1
fnxn.g(K,s4,n4.t,
       s3,n3.t,
       s2,n2.t)