context("wms")

test_that("layers", {
  # when
  map <- ol() %>% add_wms_tiles("http://ows.terrestris.de/osm/service",
                                layers = "TOPO-WMS")
  # then
  layer_expected <- "TOPO-WMS"
  # assert
  expect_equal(map$x$calls[[1]]$args[[2]]$LAYERS, layer_expected)
})
