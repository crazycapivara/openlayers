// define ol to use strict mode
var ol = window.ol;

(function() {"use strict";

  var debug = {};

  debug.active = false;

  debug.log = function() {
    if (this.active) console.log.apply(console, arguments);
  };

  var olWidget = window.olWidget = {};

  olWidget.element = null;

  olWidget.options = {
    debug: false,
    renderer: "canvas",
    minZoom: undefined,
    maxZoom: undefined,
    maxZoomFit: 16,
    // TODO: use base64
    markerIcon: "http://openlayers.org/en/v4.2.0/examples/data/icon.png"
  };

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
      debug.log("set feature id: ", i);
      feature.setId(i);
    });
  };

  helpMe.getFeaturesFromGeojson = function(data) {
    var format = new ol.format.GeoJSON();
    var features = format.readFeatures(data, {
      // TODO: get projection from data source
      dataProjection: "",
      featureProjection: "EPSG:3857"
    });
    this.setFeatureIds(features);
    return features;
  };

  helpMe.addContainer = function(containerId, el) {
    el = el || olWidget.element;
    var container = document.createElement("div");
    container.setAttribute("id", containerId);
    el.parentElement.insertBefore(container, el.nextSibling);
    return container;
  };

  helpMe.getFeatureProperties = function(feature) {
    var properties = { id: feature.getId() };
    feature.getKeys().forEach(function(key) {
      if (key !== "geometry") properties[key] = feature.get(key);
    });
    debug.log("feature properties:", properties);
    return properties;
  };

  helpMe.dragAndDrop = function(targetElement, callback) {
    // disable default drag & drop functionality
    targetElement.addEventListener("dragenter", function(e){ e.preventDefault(); });
    targetElement.addEventListener("dragover",  function(e){ e.preventDefault(); });
    targetElement.addEventListener("drop", function(event) {
      var reader = new FileReader();
      reader.onloadend = function() {
        var data = JSON.parse(this.result);
        callback(data);
      };
      var f = event.dataTransfer.files[0];
      reader.readAsText(f);
      event.preventDefault();
    });
  };

  // style helpers as a homage to the RHCP
  var freakyStyley = {};

  freakyStyley.getOptionValue = function(feature, style, option) {
    return style[option] instanceof Array ?
      style[option][feature.getId()] : style[option];
  };

  freakyStyley.fill = function(options, feature) {
    return options ? new ol.style.Fill({
      color: this.getOptionValue(feature, options, "color")
    }) : undefined;
  };

  freakyStyley.stroke = function(options, feature) {
    return options ? new ol.style.Stroke(options) : undefined;
  };

  freakyStyley.circle = function(options, feature) {
    return new ol.style.Circle({
      stroke: this.stroke(options.stroke),
      fill: this.fill(options.fill, feature),
      radius: this.getOptionValue(feature, options, "radius")
    });
  };

  freakyStyley.getTextValue = function(options, feature) {
    return options.property ? String(feature.get(options.property)) :
      this.getOptionValue(feature, options, "text");
  };

  freakyStyley.text = function(options, feature) {
    return options ? new ol.style.Text({
      //font: "bold 12px Ubuntu",
      text: this.getTextValue(options, feature),
      scale: options.scale || 1, // TODO: use olWidget.options to set default value
      stroke: this.stroke(options.stroke, feature),
      fill: this.fill(options.fill, feature)
      }) : undefined;
  };

  freakyStyley.icon = function(options, feature) {
    return new ol.style.Icon({
      src: options.src || olWidget.options.markerIcon,
      anchor: options.anchor || undefined,
      anchorOrigin: "top-left",
      color: this.getOptionValue(feature, options, "color") || undefined
    });
  };

  var styleIt = function(style) {
    return function(feature, resolution) {
      var style_ = new ol.style.Style({
        stroke: freakyStyley.stroke(style.stroke, feature),
        fill: freakyStyley.fill(style.fill, feature),
        text: freakyStyley.text(style.text, feature)
      });
      if (style.circle) {
        style_.setImage(freakyStyley.circle(style.circle, feature));
      }
      else if (style.marker) {
        style_.setImage(freakyStyley.icon(style.marker, feature));
      }
      return style_;
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
  var methods = olWidget.methods = {};

  methods.setView = function(lon, lat, zoom) {
    this.setView(new ol.View({
      center: ol.proj.fromLonLat([lon, lat]),
      zoom: zoom
    }));
  };

  // TODO: use 'helpMe.addTileLayer' method!
  methods.addStamenTiles = function(layer) {
    this.addLayer(new ol.layer.Tile({
      source: new ol.source.Stamen({layer: layer}),
      //type: "base",
      title: layer
    }));
  };

  // TODO: use 'helpMe.addTileLayer' method!
  methods.addOSMTiles = function() {
    this.addLayer(new ol.layer.Tile({
      source: new ol.source.OSM()
    }));
  };

  methods.addXYZTiles = function(xyz_url, attribution, opacity) {
    var source = new ol.source.XYZ({
      url: xyz_url,
      attributions: attribution || null
    });
    helpMe.addTileLayer(this, source, opacity);
  };

  var callbacks = {};

  callbacks.renderFeatureProperties = function(properties) {
    var text = Object.keys(properties).map(function(key){
        return "<b>" + key + ":</b> " + properties[key];
      }).join(", ");
    text = "<div style='padding: 10px;'>" + text + "</div>";
    return text;
  };

  // Move to 'helpMe'
  var displayFeatureProperties = function(properties) {
    var containerId = "selected-feature";
    var container = document.getElementById(containerId) || helpMe.addContainer(containerId);
    container.innerHTML = properties ? callbacks.renderFeatureProperties(properties) : null;
  };

  var addSelectListener = function(options) {
    return function(e) {
      // not implemented yet
    };
  };

  methods.addSelect = function(options, layers) {
    var condition = options.condition || "pointerMove";
    var select = new ol.interaction.Select({
      condition: ol.events.condition[condition],
      layers: layers // if undefined all layers are selectable!
    });
    this.addInteraction(select);
    // TODO: put to seperate function?
    select.on("select", function(e) {
      var feature = e.target.getFeatures().item(0);
      var properties = null;
      if (feature) {
        properties = helpMe.getFeatureProperties(feature);
      }
      // Pass feature properties back to R
      if (HTMLWidgets.shinyMode) {
        Shiny.onInputChange(olWidget.element.id + "_select", properties);
      }
      if (options.displayProperties) {
          displayFeatureProperties(properties);
      }
    });
  };

  methods.addGeojson = function(data, style, options) {
    var features = helpMe.getFeaturesFromGeojson(data);
    var dataSource = new ol.source.Vector({
      features: features
    });
    var layer = new ol.layer.Vector({
      source: dataSource,
      opacity: options.opacity || 1 // TODO: set default in olWidget.options
    });
    if (style) {
      var style_ = typeof(style) === "function" ? style : styleIt(style);
      layer.setStyle(style_);
    }
    this.addLayer(layer);
    // TODO: fit should be optional
    this.getView().fit(dataSource.getExtent(), {
      maxZoom: olWidget.options.maxZoomFit
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

          console.log(x.options);
          for (var key in x.options) {
            // set null to undefined
            olWidget.options[key] = x.options[key] === null ? undefined : x.options[key];
          }
          console.log(olWidget.options);

          debug.active = olWidget.options.debug;
          debug.log("Welcome to the machine!");

          map = new ol.Map({
            target: el.id,
            view: new ol.View({
              center: [0, 0],
              zoom: 2,
              minZoom: olWidget.options.minZoom,
              maxZoom: olWidget.options.maxZoom
            }),
            renderer: olWidget.options.renderer,
            loadTilesWhileAnimating: true
          });

          //var latlngContainer = helpMe.addContainer("latlng");
          map.on("singleclick", function(e) {
            var coordinate = ol.proj.transform(
              e.coordinate, "EPSG:3857", "EPSG:4326");
            debug.log("xy", coordinate);
            var coordHDMS = ol.coordinate.toStringHDMS(coordinate);
            //latlngContainer.innerHTML = coordHDMS;
            // pass coordinate back to R
            if (HTMLWidgets.shinyMode) {
              debug.log("Shiny mode!");
              var lnglat = { lng: coordinate[0], lat: coordinate[1], HDMS: coordHDMS };
              Shiny.onInputChange(el.id + "_click", lnglat);
            }
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

          if (x.enable_drag_and_drop) {
            helpMe.dragAndDrop(el, function(data) {
              debug.log(data);
              if (!data.features) {
                console.log("no features found");
                return;
              }
              methods.addGeojson.call(map, data, null, {});
            });
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
