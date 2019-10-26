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

board_register_kaggle(token = "~/.kaggle/kaggle.json")
# pin_find("global-map-japan", board = "kaggle")
pin_get("gsi-japan/global-map-japan-data", board = "kaggle")

renv::snapshot(confirm = FALSE)
