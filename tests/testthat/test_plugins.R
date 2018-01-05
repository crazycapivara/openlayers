context("plugins")

test_that("layer switcher", {
  # when
  map <- ol() %>%
    add_osm_tiles() %>%
    add_layer_switcher()
  # then
  script_expected <- c("ol3-layerswitcher.js", "ol-layerswitcher-bindings.js")
  # assert
  expect_equal(map$dependencies[[1]]$script, script_expected)
})
