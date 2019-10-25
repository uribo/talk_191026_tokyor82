####################################
# Rコードを記述する
# 気象庁の過去データをダウンロード
# 地点: つくば（舘野）、札幌、岡山、福岡
# 項目: 平均気温, 降水量の合計、最高気温、最低気温
# 期間: 2018年1月1日から2019年10月24日
# [x]利用上注意が必要なデータを表示させる
# [x]観測環境などの変化以前のデータを表示させる
# [x]ダウンロードデータはすべて数値で格納
####################################
renv::install(packages = c("readr", "dplyr", "tidyr"))

library(readr)
library(dplyr)
library(tidyr)

df <-
  read_csv("data-raw/jma_weather.csv",
           locale = locale(encoding = "cp932"),
           skip = 6,
           col_names =
             c("date",
               paste0(rep(c("st_Tsukuba", "st_Sapporo", "st_Okayama", "st_Fukuoka"), each = 12),
                      "_",
                      rep(c("mean.temperature(℃)", "precipitation.sum(mm)", "temperature.max(℃)", "temperature.min(℃)"), each = 3),
                      c("", "quality", "equality", "", "information", "quality", "equality", "", "quality", "equality"))
             )) %>%
  mutate_at(vars(contains("date")), as.Date) %>%
  select(date, matches("\\(.+\\)$"))
df

df_tidy <-
  df %>%
  pivot_longer(-date,
               names_to = "variable") %>%
  extract(col = variable, into = c("station", "variable"), regex = "st_(.+)_(.+)") %>%
  pivot_wider(names_from = variable,
              values_from = value)

df_tidy

df_tidy %>%
  write_rds("data/jma_weather_tidy.rds")
renv::status()

renv::install("gitlab::uribo/jmastats")
renv::install("rstudioapi")
df_tidy <-
  df_tidy %>%
  jmastats:::convert_variable_unit() %>%
  purrr::set_names(c("date", "station",
                     "temperature_average", "precipitation_sum",
                     "temperature_max", "temperature_min"))

pins::board_register_rsconnect(name = "rsconnect",
                         account = "uribo",
                         server = "https://beta.rstudioconnect.com",
                         key = rstudioapi::askForPassword())
pins::pin(df_tidy,
          name = "jma_tidy",
          description = "jma weather data tidyup",
          board = "rsconnect")

# pins::pin_remove("jma_tidy", board = "rsconnect")

renv::snapshot(confirm = FALSE)
