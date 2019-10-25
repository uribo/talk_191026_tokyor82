####################################
# プロジェクトを作成
####################################
library(renv, warn.conflicts = FALSE)
activate() # Commit
status() # renvがlockファイルに記載されていないので追加する

snapshot(confirm = FALSE)
