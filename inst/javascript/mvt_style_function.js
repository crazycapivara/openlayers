// mapbox
function(feature, resolution) {
  var color = "red";
  var class_ = feature.get("class");
  if (class_ === "primary") { color = "blue"; }
  else if (class_ === "secondary") { color = "green"; }
  else if (class_ === "street") { color = "yellow"; }
  return new ol.style.Style({
    stroke: new ol.style.Stroke({
      color: color,
      width: 2
    })
  });
}
