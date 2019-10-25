renv::install(packages = c("reticulate", "png"))
library(reticulate)
py_config()
repl_python()

renv::snapshot(confirm = FALSE)
