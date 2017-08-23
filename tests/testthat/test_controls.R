context("controls")

test_that("scale line", {
  # when
  map <- ol() %>% add_scale_line()
  # then
  units_expected <- "metric"
  # assert
  expect_equal(map$x$scale_line$units, units_expected)
})

test_that("overview map", {
  # when
  map <- ol() %>% add_overview_map()
  # then
  collapsed_expected <- TRUE
  # assert
  expect_equal(map$x$overview_map$collapsed, collapsed_expected)
})

test_that("mouse position", {
  # when
  map <- ol() %>% add_mouse_position()
  # then
  projection_expected <- "EPSG:4326"
  # assert
  expect_equal(map$x$mouse_position$projection, projection_expected)
})

test_that("full screen", {
  # when
  map <- ol() %>% add_full_screen()
  # assert
  expect_equal(map$x$full_screen, TRUE)
})
