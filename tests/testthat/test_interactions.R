context("interactions")

test_that("drag and drop", {
  # when
  map <- ol() %>% add_drag_and_drop()
  # assert
  expect_equal(map$x$enable_drag_and_drop, TRUE)
})

test_that("select", {
  # when
  map <- ol() %>% add_select()
  # then
  method_expected <- "addSelect"
  # assert
  expect_equal(map$x$calls[[1]]$method, method_expected)
})
