// define ol to use strict mode
var ol = window.ol;

"use strict";

var olOptions = {};

olOptions.maxZoomFit = 16;
olOptions.defaultRadius = 10;
// TODO: use base64, see below
olOptions.defaultMarkerIcon = "http://openlayers.org/en/v4.2.0/examples/data/icon.png";

// help(ers) as an homage to the Beatles
var helpMe = {};

helpMe.addTileLayer = function(map, source, opacity){
  map.addLayer(new ol.layer.Tile({
    source: source,
    opacity: opacity || 1
  }));
};

helpMe.setFeatureIds = function(features) {
  features.forEach(function(feature, i) {
    console.log("new feature: " + i);
    feature.setId(i);
  });
};

// style helpers as a homage to the RHCP
var freakyStyley = {};

freakyStyley.getOptionValue = function(feature, style, option) {
  return style[option] instanceof Array ? style[option][feature.getId()] : style[option];
};

freakyStyley.getFill = function(feature, fill) {
  return fill ? new ol.style.Fill({
    color: this.getOptionValue(feature, fill, "color")
  }) : null;
};

freakyStyley.getStroke = function(feature, stroke) {
  // TODO: implement 'getStroke' method
};

var styleIt = function(style) {
  return function(feature, resolution) {
    _style = new ol.style.Style();
    if (style.stroke) _style.setStroke(new ol.style.Stroke(style.stroke));

    if (style.fill) _style.setFill(freakyStyley.getFill(feature, style.fill, "color"));

    // TODO: use helper func
    if (style.circle) {
      console.log(style.circle);
      _style.setImage(new ol.style.Circle({
        stroke: style.circle.stroke ? new ol.style.Stroke(style.circle.stroke) : null,
        fill: freakyStyley.getFill(feature, style.circle.fill),
        radius: freakyStyley.getOptionValue(feature, style.circle, "radius")
      }));
    }

    // TODO: use helper func
    if (style.marker) {
      _style.setImage(new ol.style.Icon({
        src: style.marker.src || olOptions.defaultMarkerIcon
      }));
    }

    if (style.text) {
      _style.setText(new ol.style.Text({
        text: style.text.property ? String(feature.get(style.text.property)) :
          freakyStyley.getOptionValue(feature, style.text, "text"),
        scale: style.text.scale || 1
      }));
    }

    return _style;
  };
};

// use this function to apply style depending on resolution
// NOT USED at the moment
var _styleIt = function(style) {
  var res_test = 4000;
  console.log("using _styleIt!");
  return function(feature, resolution) {
    return resolution < res_test ? styleIt(style)(feature, resolution) : null;
  };
};

// methods to be invoked from R
var methods = {};

methods.setView = function(lon, lat, zoom) {
  this.setView(new ol.View({
    center: ol.proj.fromLonLat([lon, lat]),
    zoom: zoom
  }));
};

// TODO: use 'helpMe.addTileLayer' method!
methods.addStamenTiles = function(layer) {
  this.addLayer(new ol.layer.Tile({
    source: new ol.source.Stamen({layer: layer})
  }));
};

// TODO: use 'helpMe.addTileLayer' method!
methods.addOSMTiles = function() {
  this.addLayer(new ol.layer.Tile({
    source: new ol.source.OSM()
  }));
};

methods.addXYZTiles = function(xyz_url, opacity) {
  source = new ol.source.XYZ({url: xyz_url});
  helpMe.addTileLayer(this, source, opacity);
};

methods.addGeojson = function(data, style, opacity) {
  console.log("please add geojson");

  var format = new ol.format.GeoJSON();
  var features = format.readFeatures(data, {
    // TODO: get projection from data source
    dataProjection: "",
    featureProjection: "EPSG:3857"
  });
  helpMe.setFeatureIds(features);

  var dataSource = new ol.source.Vector({
    features: features
  });

  //console.log("try this one", dataSource.getFeatures());

  var layer = new ol.layer.Vector({
    source: dataSource,
    opacity: opacity
  });

  if (style) {
    _style = typeof(style) == "function" ? style : styleIt(style);
    layer.setStyle(_style);
  }
  this.addLayer(layer);

  // TODO: fit should be optional
  this.getView().fit(dataSource.getExtent(), {
    maxZoom: olOptions.maxZoomFit
  });

  console.log("zoom", this.getView().getZoom());
  console.log("resolution", this.getView().getResolution());
};

// TODO: check how to set feature ids
methods.addGeojsonFromUrl = function(url) {
  var dataSource = new ol.source.Vector({
    url: url,
    format: new ol.format.GeoJSON()
  });

  var layer = new ol.layer.Vector({
    source: dataSource,
  });

  this.addLayer(layer);
};

HTMLWidgets.widget({

  name: 'ol',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: mv to window namespace if needed!
    var debug = true; // should be passed via 'ol_options' in R
    //var defaultRadius = 10;

    function debugLog(msg) {
      if (debug) {
        console.log(msg);
      }
    }

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

        // add scale line to map
        if(x.scale_line) {
          map.addControl(new ol.control.ScaleLine({
            units: x.scale_line.units
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
