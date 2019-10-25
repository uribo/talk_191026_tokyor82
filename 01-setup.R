####################################
# プロジェクトを作成
####################################
library(renv, warn.conflicts = FALSE)
activate() # Commit
status() # renvがlockファイルに記載されていないので追加する

snapshot(confirm = FALSE)

dependencies() # 管理対象に置かれているファイル、パッケージを確認
history() # Gitによるバージョン管理の記録 (renv.lockが対象時のみ)
status()
revert(commit = "c89ff4bbea946400023c46eeb7d352d404a8ae43")
renv::install("magrittr")
library(magrittr)
status()
snapshot()

