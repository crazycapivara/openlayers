"use strict";

var ol = window.ol;
var olWidget = window.olWidget;

(function() {
  var methods = olWidget.methods;

  methods.addLayerSwitcher = function() {
    olWidget.layerSwitcher = new ol.control.LayerSwitcher();
    this.addControl(olWidget.layerSwitcher);
    // TODO: do not display control, if no layers are present
    /*
    var layers = this.getLayers().getArray();
    var titles = layers.map(function(l) { return l.get("title"); });
    console.log(titles);
    */
  };
})();
