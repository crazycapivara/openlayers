function(feature, resolution) {
  return new ol.style.Style({
    text: new ol.style.Text({
      text: String(feature.get("mag")),
      scale: 1.5
    })
  });
}
