context("vector tiles")

test_that("guess format topojson", {
  # given
  url <- "https://vt.bender.com/v1/layer/{z}/{x}/{y}.topojson?token=rtx"
  # when
  format <- guess_vt_format(url)
  # then
  format_expected <- "TopoJSON"
  # assert
  expect_equal(format, format_expected)
})

test_that("guess format geojson", {
  # given
  url <- "https://vt.bender.com/v1/layer/{z}/{x}/{y}.json?api_key=xyz"
  # when
  format <- guess_vt_format(url)
  # then
  format_expected <- "GeoJSON"
  # assert
  expect_equal(format, format_expected)
})
