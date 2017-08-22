.onAttach <- function(libname, pkgname){
  fn <- system.file("htmlwidgets/ol.yaml", package = "openlayers")
  ol_js_version <- yaml::yaml.load_file(fn)$dependencies[[1]]$version
  packageStartupMessage(
    pkgname, " ", getNamespaceVersion(pkgname),
    " wrapping openlayerjs v", ol_js_version
  )
}
