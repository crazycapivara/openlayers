var olOptions = {};

olOptions.maxZoomFit = 16;
olOptions.defaultRadius = 10;
// TODO: use base64, see below
olOptions.defaultMarkerIcon = "http://openlayers.org/en/v4.2.0/examples/data/icon.png";

var utils = {};

utils.setFeatureIds = function() {
  for(var i = 0; i < this.length; i++) {
    console.log("feature: " + i);
    this[i].setId(i);
  }
};

// OBSOLETE: example style func using quakes dataset
var styleFunc = function(feature, resolution) {
  console.log(feature.getKeys(), feature.get("mag"));
  return new ol.style.Style({
    text: new ol.style.Text({
      text: String(feature.get("mag")),
      //stroke: new ol.style.Stroke({width: 2}),
      scale: 1.5
    })
  });
};

// new setting styles func
var styleIt = function(style) {
  return function(feature, resolution) {
    _style = new ol.style.Style();
    if (style.stroke) _style.setStroke(new ol.style.Stroke(style.stroke));

    if (style.fill) _style.setFill(new ol.style.Fill(style.fill));

    // TODO: use helper func
    if (style.circle) {
      console.log(style.circle);
      _style.setImage(new ol.style.Circle({
        stroke: style.circle.stroke ? new ol.style.Stroke(style.circle.stroke) : null,
        fill: style.circle.fill ? new ol.style.Fill(style.circle.fill) : null,
        radius: style.circle.radius
      }));
    }

    // TODO: use helper func
    if (style.marker) {
      _style.setImage(new ol.style.Icon({
        src: style.marker.src || olOptions.defaultMarkerIcon
      }));
    }

    return _style;
  };
};

var markerThat = function(style) {
  return new ol.style.Style({
    image: new ol.style.Icon({
      src: "http://openlayers.org/en/v4.2.0/examples/data/icon.png"
    })
  });
};

var styleThat = function(style) {
  stroke = style.stroke ? new ol.style.Stroke(style.stroke) : null;
  fill = style.fill ? new ol.style.Fill(style.fill) : null;
  image = new ol.style.Circle({
    stroke: stroke,
    fill: fill,
    radius: style.radius || olOptions.defaultRadius
  });

  return new ol.style.Style({
    image: image,
    stroke: stroke,
    fill: fill
  });
};

var methods = {};

methods.setView = function(lon, lat, zoom) {
  this.setView(new ol.View({
    center: ol.proj.fromLonLat([lon, lat]),
    zoom: zoom
  }));
};

// TODO: implement base addTiles method!
methods.addStamenTiles = function(layer) {
  this.addLayer(new ol.layer.Tile({
    source: new ol.source.Stamen({layer: layer})
  }));
};

methods.addOSMTiles = function() {
  this.addLayer(new ol.layer.Tile({
    source: new ol.source.OSM()
  }));
};

methods.addGeojson = function(data, style, opacity) {
  console.log("please add geojson");

  var format = new ol.format.GeoJSON();
  var features = format.readFeatures(data, {
    // TODO: get projection from data source
    dataProjection: "",
    featureProjection: "EPSG:3857"
  });
  utils.setFeatureIds.call(features);
  //console.log("Test feature id: " + features[4].getId());
  var dataSource = new ol.source.Vector({
    features: features
  });

  // TODO: set opacity via parameter in R
  var layer = new ol.layer.Vector({
    source: dataSource,
    opacity: opacity
  });
  //layer.setStyle(styleFunc);
  if (style) {
    _style = typeof(style) == "function" ? style : styleIt(style);
    //_style = typeof(style) == "function" ? style : styleThat(style);
    //_style = style.marker ? markerThat(style) : styleThat(style);
    layer.setStyle(_style);
  }
  this.addLayer(layer);

  // TODO: fit should be optional
  this.getView().fit(dataSource.getExtent(), {
    maxZoom: olOptions.maxZoomFit
  });
};

HTMLWidgets.widget({

  name: 'ol',

  type: 'output',

  factory: function(el, width, height) {

    var debug = true;
    var defaultRadius = 10;

    // functions
    function debugLog(msg) {
      if (debug) {
        console.log(msg);
      }
    }

    /* OBSOLETE: see above, style functions */
    function getStrokeStyle(stroke) {
      return stroke ? new ol.style.Stroke({
        color: stroke.color,
        width: stroke.width
      }) : null;
    }

    function getFillStyle(fill) {
      return fill ? new ol.style.Fill({
        color: fill.color
      }) : null;
    }

    function getCircleStyle(radius, stroke, fill) {
      return new ol.style.Circle({
        stroke: getStrokeStyle(stroke),
        fill: getFillStyle(fill),
        radius: radius ? radius : defaultRadius
      });
    }

    // TODO: move to global style func!
    function getIconStyle() {
      return new ol.style.Icon(/** @type {olx.style.IconOptions} */({
        //anchor: [0.5, 46],
        //anchorXUnits: 'fraction',
        //anchorYUnits: 'pixels',
        //src: "http://openlayers.org/en/v4.2.0/examples/data/icon.png"
        src: "data:image/png;base64, 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"
        //TODO: use base64 images or try to 'guess' path
        //src: "lib/ol-4.2.0/images/marker-icon.png"
      }));
    }

    function getStyle(_style) {
      return new ol.style.Style({
        image: _style.marker ? getIconStyle() :
          getCircleStyle(_style.radius, _style.stroke, _style.fill),
        stroke: getStrokeStyle(_style.stroke),
        fill: getFillStyle(_style.fill)
      });
    }

    // TODO: OBSOLETE!?
    var geojsonObject = {
        'type': 'FeatureCollection',
        'crs': {
          'type': 'name',
          'properties': {
            'name': 'EPSG:3857'
          }
        },
        'features': [{
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [0, 0]
          }
        }, {
          'type': 'Feature',
          'geometry': {
            'type': 'LineString',
            'coordinates': [[4e6, -2e6], [8e6, 2e6]]
          }
        }]
      };

    // OBSOLETE: main methods, defined above!
    var methods = {
      "debugLog": debugLog,
      "addStamenTiles": function(layer) {
        console.log("add stamen tiles to map, layer = " + layer);
      }
    };

    // TODO: apply setView func instead of setting here
    var map = new ol.Map({
      target: el.id,
      view: new ol.View({
        center: [0, 0],
        zoom: 2
      })
      //renderer: 'canvas'
    });

    return {

      renderValue: function(x) {

        //el.innerText = x.message;
        //debugLog(window);

        // OBSOLETE: set view
        if(x.view) {
          debugLog(x.view);
          map.setView(new ol.View({
            center: ol.proj.fromLonLat([x.view.lon, x.view.lat]),
            zoom: x.view.zoom
          }));
        }

        // add scale line to map
        if(x.scale_line) {
          map.addControl(new ol.control.ScaleLine({
            units: x.scale_line.units
          }));
        }

        // OBSOLETE: add osm tiles
        if(x.osm_tiles) {
          debugLog("OSM!");
          map.addLayer(new ol.layer.Tile({
            source: new ol.source.OSM()
          }));
        }

        // OBSOLETE: add stamen tiles
        if(x.stamen_tiles) {
          debugLog("STAMEN!");
          debugLog(x.stamen_tiles);
          map.addLayer(new ol.layer.Tile({
            source: new ol.source.Stamen({layer: x.stamen_tiles})
          }));
        }

        // add xyz tiles
        if(x.xyz_url) {
          map.addLayer(new ol.layer.Tile({
            source: new ol.source.XYZ({url: x.xyz_url})
          }));
        }

        // add earthquakes
        // countries: https://raw.githubusercontent.com/datasets/geo-boundaries-world-110m/master/countries.geojson
        if(x.earthquakes_url) {
          map.addLayer(new ol.layer.Vector({
            //title: 'Earthquakes',
            source: new ol.source.Vector({
              url: x.earthquakes_url,
              format: new ol.format.GeoJSON()
            })
          }));
        }

        // add geojson vector layer from url (or file)
        // TODO: check whether file will also works (path issue? RMarkdown may work!)
        if(x.ds){
          debugLog(x.ds);

          map.addLayer(new ol.layer.Vector({
            source: new ol.source.Vector({
              url: x.ds.url,
              format: new ol.format.GeoJSON()
              /*
              features: (new ol.format.GeoJSON()).readFeatures(x.ds.filename, {
                dataProjection: "",
                featureProjection: "EPSG:3857"
              })
              */
            }),
            style: getStyle(x.ds.style)
          }));
        }

        // OBSOLETE: add geojson vector layer to map
        // TODO: implement marker option in global style func!
        if(x.geojson) {
          debugLog(x.geojson.style);

          var format = new ol.format.GeoJSON();
          var dataSource = new ol.source.Vector({
            features: format.readFeatures(x.geojson.data, {
              // TODO: get projection from data source
              dataProjection: "",
              featureProjection: "EPSG:3857"
            })
          });

          map.addLayer(new ol.layer.Vector({
            // TODO: set main opacity via parameter
            //opacity: 1.0,
            source: dataSource,
            style: getStyle(x.geojson.style)
          }));

          map.getView().fit(dataSource.getExtent(), {maxZoom: 16});
        }

        // execute calls
        debugLog("all calls:");
        debugLog(x.calls);

        for (var i = 0; i < x.calls.length; i++) {
          var call = x.calls[i];
          debugLog("current call:");
          debugLog(call);
          window.methods[call.method].apply(map, call.args);
        }

      // END renderValue
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
