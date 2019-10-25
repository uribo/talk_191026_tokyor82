####################################
# pinsによるデータ共有
####################################
renv::install("pins")
library(pins)
# Discover ----------------------------------------------------------------
"nycflights13" %in% rownames(installed.packages())
pin_find("flights", board = "packages")

flights <-
  pin_get("nycflights13/flights", board = "packages")
dplyr::glimpse(flights)

renv::snapshot(confirm = FALSE)
