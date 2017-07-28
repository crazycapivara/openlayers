function(feature, resolution) {
  return new ol.style.Style({
    text: new ol.style.Text({
      text: resolution < 3000 ? String(feature.get("mag")) : "",
      scale: 1.2
    }),
    image: new ol.style.Circle({
      radius: 20,
      stroke: new ol.style.Stroke({
        color: "blue"
      })
    })
  });
}
