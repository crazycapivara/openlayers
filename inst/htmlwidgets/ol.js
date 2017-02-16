HTMLWidgets.widget({

  name: 'ol',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    var map = new ol.Map({
      target: el.id,
      layers: [
        new ol.layer.Tile({
          source: new ol.source.OSM()
        })
      ],
      view: new ol.View({
        center: ol.proj.fromLonLat([37.41, 8.82]),
        zoom: 4
      })
    });

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        //el.innerText = x.message;
        map;

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
