"use strict";

var ol = window.ol;

(function() {
  var methods = window.olWidget.methods;

  methods.addLayerSwitcher = function() {
    console.log("add layer switcher");
    var layerSwitcher = window.olWidget.layerSwitcher;
    layerSwitcher = new ol.control.LayerSwitcher({
      tipLabel: "Whatever" // optional label for button
    });
 	  this.addControl(layerSwitcher);
  };
})();
