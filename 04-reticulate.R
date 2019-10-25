renv::install(packages = c("reticulate", "png"))
library(reticulate)
py_config()
repl_python()

renv::snapshot(confirm = FALSE)

# environment.ymlを用意 --> Conda環境にPythonライブラリが追加される
renv::use_python(type = "conda", name = "talk_191026_tokyor82")
renv::restore()
# conda activate talk_191026_tokyor82
# conda update --all
renv::snapshot() # environment.ymlも管理するようになる

repl_python()
# Python 3.7.3 (/Users/uri/miniconda3/envs/talk_191026_tokyor82/bin/python)
# Reticulate 1.13 REPL -- A Python interpreter in R.

# うまくいかない時もある...
# conda remove -n talk_191026_tokyor82 --all
# conda create -n talk_191026_tokyor82
# conda activate talk_191026_tokyor82
# conda install -c conda-forge matplotlib gdal geopandas=0.4.1=py_0 shapely descartes
# conda install -c conda-forge earthengine-api folium
# ~~conda update --all~~
