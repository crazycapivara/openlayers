// define ol to use strict mode
var ol = window.ol;

"use strict";

(function() {

  var olWidget = {}; //window.olWidget = {};

  olWidget.element = null;

  var debug = olWidget.debug = {};

  debug.active = false;

  debug.log = function() {
    if (this.active) console.log.apply(console, arguments);
  };

  olWidget.options = {};

  olWidget.options.defaults = {
    maxZoomFit: 16,
    // TODO: use base64
    markerIcon: "http://openlayers.org/en/v4.2.0/examples/data/icon.png"
  };

  // TODO: if needed, put it to 'olWidget'
  /*
  var olOptions = {};

  olOptions.maxZoomFit = 16;
  olOptions.defaultRadius = 10;
  // TODO: use base64, see below
  olOptions.defaultMarkerIcon = "http://openlayers.org/en/v4.2.0/examples/data/icon.png";
  */

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

// TODO: add style parameter
helpMe.addContainer = function(containerId, el) {
  el = el || olWidget.element;
  var container = document.createElement("div");
  container.setAttribute("id", containerId);
  container.innerHTML = "&nbsp;";
  container.setAttribute("style", "padding: 5px;");
  //el.parentElement.appendChild(container);
  el.appendChild(container);
  return container;
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
      //console.log(style.circle);
      _style.setImage(new ol.style.Circle({
        stroke: style.circle.stroke ? new ol.style.Stroke(style.circle.stroke) : null,
        fill: freakyStyley.getFill(feature, style.circle.fill),
        radius: freakyStyley.getOptionValue(feature, style.circle, "radius")
      }));
    }

    // TODO: use helper func
    if (style.marker) {
      _style.setImage(new ol.style.Icon({
        src: style.marker.src || olWidget.options.defaults.markerIcon,
        color: undefined // TODO: set as parameter in R
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

// methods to be invoked from R, this = map object!
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

methods.addXYZTiles = function(xyz_url, attribution, opacity) {
  source = new ol.source.XYZ({
    url: xyz_url,
    attributions: attribution || null
  });
  helpMe.addTileLayer(this, source, opacity);
};

methods.addSelect = function(selectOptions, layers) {
  condition = selectOptions.condition || "pointerMove";
  var select = new ol.interaction.Select({
    condition: ol.events.condition[selectOptions.condition],
    layers: layers
  });
  this.addInteraction(select);

  var target = helpMe.addContainer("info");
  select.on("select", function(e) {
    var feature = e.target.getFeatures().item(0);
    if (feature) {
      debug.log("feature id:", feature.getId());
      debug.log("feature properties:", feature.getProperties());
      if (selectOptions.property) {
        target.innerHTML = feature.get(selectOptions.property);
      }
    } else {target.innerHTML = "&nbsp;"}
  });
};

methods.addGeojson = function(data, style, options) {
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

  var layer = new ol.layer.Vector({
    source: dataSource,
    opacity: options.opacity || 1
  });

  if (style) {
    _style = typeof(style) == "function" ? style : styleIt(style);
    layer.setStyle(_style);
  }

  if (options.select) {
    debug.log("add select interaction to layer:", options.select);
    methods.addSelect.call(
      this, options.select, [layer]);
  }

  this.addLayer(layer);

  // TODO: fit should be optional
  this.getView().fit(dataSource.getExtent(), {
    maxZoom: olWidget.options.defaults.maxZoomFit
  });

  debug.log("zoom:", this.getView().getZoom());
  debug.log("resolution:", this.getView().getResolution());
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

    olWidget.element = el;

    var map = null;

    return {

      renderValue: function(x) {

        olWidget.debug.active = true;
        olWidget.debug.log({msg: "Welcome to the machine!"});

        map = new ol.Map({
          target: el.id,
          view: new ol.View({
            center: [0, 0],
            zoom: 2
          }),
          renderer: "canvas"
        });

        // add scale line to map
        if (x.scale_line) {
          map.addControl(new ol.control.ScaleLine({
            units: x.scale_line.units
          }));
        }

        if (x.mouse_position) {
          map.addControl(new ol.control.MousePosition({
            coordinateFormat: ol.coordinate.createStringXY(4),
            projection: x.mouse_position.projection || "EPSG:4326"
          }));
        }

        if (x.overview_map) {
          map.addControl(new ol.control.OverviewMap({
            collapsed: x.overview_map.collapsed
          }));
        }

        if (x.full_screen) {
          map.addControl(new ol.control.FullScreen());
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
        debug.log("all calls:", x.calls);

        for (var i = 0; i < x.calls.length; ++i) {
          var call = x.calls[i];
          debug.log("current call:", call);
          methods[call.method].apply(map, call.args);
        }

        //debug.log(window);

      // END renderValue
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});

})();
