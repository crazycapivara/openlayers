context("methods")

get_call <- function(map) {
  map$x$calls[[1]]
}

test_that("osm tiles", {
  # when
  map <- ol() %>% add_osm_tiles()
  # then
  method_expected <- "addOSMTiles"
  # assert
  expect_equal(get_call(map)$method, method_expected)
})

test_that("stamen tiles", {
  # when
  map <- ol() %>% add_stamen_tiles()
  # then
  method_expected <- "addStamenTiles"
  layer_expected <- "watercolor"
  # assert
  call <- get_call(map)
  expect_equal(call$method, method_expected)
  expect_equal(call$args[[1]], layer_expected)
})

test_that("set view", {
  # when
  zoom <- 8
  map <- ol() %>% set_view(zoom = zoom)
  # then
  method_expected <- "setView"
  zoom_expected <- 8
  # assert
  call <- get_call(map)
  expect_equal(call$method, method_expected)
  expect_equal(call$args[[3]], zoom_expected)
})
