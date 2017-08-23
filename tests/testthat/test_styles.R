context("styles")

test_that("combine styles", {
  # given
  color <- "red"
  width <- 3
  # when
  style <- fill_style(color) + stroke_style(width = width)
  # then
  stroke_width_expected <- 3
  fill_color_expected <- "red"
  # assert
  expect_equal(style$stroke$width, stroke_width_expected)
  expect_equal(style$fill$color, fill_color_expected)
})

test_that("class", {
  # when
  style <- fill_style() + stroke_style()
  # then
  class_expected <- c("list", "style")
  # assert
  expect_equal(class(style), class_expected)
})
