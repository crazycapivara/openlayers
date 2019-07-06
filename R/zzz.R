.onAttach <- function(libname, pkgname) { # nocov start
  fn <- system.file("htmlwidgets/ol.yaml", package = "openlayers")
  ol_js_version <- yaml::yaml.load_file(fn)$dependencies[[1]]$version
  packageStartupMessage(
    pkgname, " ", getNamespaceVersion(pkgname),
    " wrapping openlayersjs v", ol_js_version
  )
} # nocov end
