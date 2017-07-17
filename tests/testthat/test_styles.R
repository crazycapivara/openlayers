context("styles")

test_that("combine styles", {
  # when
  color <- "red"
  width <- 3
  style <- fill_style(color) + stroke_style(width = width)
  # then
  stroke_width <- style$stroke$width
  fill_color <- style$fill$color
  # ---
  expect_equal(stroke_width, 3)
  expect_equal(fill_color, "red")
})

test_that("check class", {
  # when
  style <- fill_style() + stroke_style()
  # then
  class_ <- class(style)
  # ---
  expect_equal(class_, c("list", "style"))
})
