context("methods")

test_that("osm tiles", {
  # when
  map <- ol() %>% add_osm_tiles()
  # then
  method_expected <- "addOSMTiles"
  # assert
  expect_equal(map$x$calls[[1]]$method, method_expected)
})

test_that("stamen tiles", {
  # when
  map <- ol() %>% add_stamen_tiles()
  # then
  method_expected <- "addStamenTiles"
  layer_expected <- "watercolor"
  # assert
  calls <- map$x$calls[[1]]
  expect_equal(calls$method, method_expected)
  expect_equal(calls$args[[1]], layer_expected)
})
