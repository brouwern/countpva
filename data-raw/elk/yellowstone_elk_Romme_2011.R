## code to prepare `GMNR_zebra` dataset goes here

## Zebra counts
file. <- "yellowstone_elk_Romme_2011.png"
folder. <- "data-raw/elk"
file. <-here::here(folder.,file.)

#library(digitizer)

library(metaDigitise)

dat <- metaDigitise(dir = folder.)
data.raw <- metaDigitise(dir = folder., summary = FALSE)

ynp_north_elk <- data.raw$scatterplot$yellowstone_elk_Romme_2011.png[,c(1,2,3)]
names(ynp_north_elk) <- c("i","year","N.elk")

ynp_north_elk$year <- round(ynp_north_elk$year,0)
ynp_north_elk$year <- 1985:2009
ynp_north_elk$N.elk <- round(ynp_north_elk$N.elk)
plot(N.elk ~ year, data = ynp_north_elk, type = "b")

YNP_north_elk <- ynp_north_elk
#usethis::use_data_raw("YNP_north_elk")
usethis::use_data(YNP_north_elk, overwrite = T)
usethis::use_r(name = "YNP_north_elk")
