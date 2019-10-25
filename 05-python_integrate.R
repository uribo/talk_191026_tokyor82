library(reticulate)
# reticulate::repl_python()
py_run_file("05-python.py")
library(sf)
library(dplyr)

d <-
  py$world

st_sf(geometry = c(st_as_sfc(paste0("SRID=4326;", as.character(d$geometry[[1]]))),
                   st_as_sfc(paste0("SRID=4326;", as.character(d$geometry[[2]])))))
plot(st_as_sfc(paste0("SRID=4326;", as.character(d$geometry[[1]]))))

d$geometry <-
  d$geometry %>%
  purrr::map(~ st_as_sfc(as.character(.x))) %>%
  purrr::reduce(c)

d <-
  d %>%
  st_sf(crs = as.numeric(gsub("epsg:", "", py$word_crs)))
  tibble::new_tibble(subclass = "sf", nrow = nrow(.))

plot(st_geometry(d))

geopd_as_sf <- function(geopd, crs = NULL) {
  geometry <-
    geopd$geometry %>%
    purrr::map(~ st_as_sfc(as.character(.x))) %>%
    purrr::reduce(c)
  unnest_vars <-
    geopd %>%
    dplyr::select(-geometry) %>%
    purrr::keep(~ class(.) == "list") %>%
    names()
  if (length(unnest_vars) > 0) {
    geopd <-
      geopd %>%
      dplyr::select(-geometry) %>%
      tidyr::unnest_longer(unnest_vars)
  }
  geopd$geometry <- geometry
  geopd %>%
    tibble::as_tibble() %>%
    sf::st_sf(crs = crs)
}

shapely_as_sfg <- function(geometry) {
  x <-
    st_as_sfc(as.character(geometry))
  x[[1]]
}

library(ggplot2)
d <-
  geopd_as_sf(py$world, 4326)
ggplot() +
  geom_sf(data = d, aes(fill = gdp_md_est)) +
  scale_fill_viridis_c()

shapely_as_sfg(py$point)
shapely_as_sfg(py$line)
plot(shapely_as_sfg(py$poly))
