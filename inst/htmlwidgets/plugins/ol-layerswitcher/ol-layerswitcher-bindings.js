"use strict";

var ol = window.ol;
var olWidget = window.olWidget;

(function() {
  var methods = olWidget.methods;

  methods.addLayerSwitcher = function() {
    //console.log("add layer switcher");
    olWidget.layerSwitcher = new ol.control.LayerSwitcher();
 	  this.addControl(olWidget.layerSwitcher);
  };

  // update layer switcher when geojson is added
  /*
  var addGeojson_ = methods.addGeojson;
  methods.addGeojson = function() {
    addGeojson_.apply(this, arguments);
    if (olWidget.layerSwitcher) {
      console.log("Update layer switcher");
    }
  };
  */
})();
