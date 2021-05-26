## code to prepare `GMNR_zebra` dataset goes here

## Zebra counts
file. <- "Watson_et_al_2005_Fig1_zebra_counts.png"
folder. <- "data-raw"
file. <-here::here(folder.,file.)

#library(digitizer)

library(metaDigitise)

dat <- metaDigitise(dir = folder.)
data.raw <- metaDigitise(dir = folder., summary = FALSE)

GMNR_zebra <- data.raw$scatterplot$Watson_et_al_2005_Fig1_zebra_counts.png[,c(1,2,3)]
names(GMNR_zebra) <- c("i","year","N.zebra")

GMNR_zebra$year <- round(GMNR_zebra$year,0)
GMNR_zebra$N.zebra <- round(GMNR_zebra$N.zebra,)
plot(N.zebra ~ year, data = GMNR_zebra, type = "b")

#usethis::use_data_raw("GMNR_zebra")
usethis::use_data(GMNR_zebra, overwrite = T)
usethis::use_r(name = "GMNR_zebra")
