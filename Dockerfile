FROM rocker/geospatial:3.6.0

RUN set -x && \
  apt-get update && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ARG GITHUB_PAT

RUN set -x && \
  echo "GITHUB_PAT=$GITHUB_PAT" >> /usr/local/lib/R/etc/Renviron

ENV RENV_VERSION 0.8.1
RUN set -x && \
  Rscript -e \
    "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))" && \
  Rscript -e \
    "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

WORKDIR /home/rstudio/talk_191026_tokyor82
COPY renv.lock ./
RUN set -x && \
  Rscript -e \
  'renv::restore(library = "/usr/lib/R/site-library", confirm = FALSE)'
