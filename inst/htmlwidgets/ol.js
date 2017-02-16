HTMLWidgets.widget({

  name: 'ol',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    var map = new ol.Map({
      target: el.id
      /*,
      layers: [
        new ol.layer.Tile({
          source: new ol.source.OSM()
        })
      ]*/
      /*,
      view: new ol.View({
        center: ol.proj.fromLonLat([37.41, 8.82]),
        zoom: 4
      })*/
    });

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        //el.innerText = x.message;
        //x.view = true;

        if(x.view){
          map.setView(
            new ol.View({
              //center: ol.proj.fromLonLat([37.41, 8.82]),
              center: ol.proj.fromLonLat([x.view.lon, x.view.lat]),
              zoom: x.view.zoom
            })
          );
        }

        if(x.tiles){
          map.addLayer(
            new ol.layer.Tile({source: new ol.source.OSM()})
          );
        }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
