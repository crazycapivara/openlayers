HTMLWidgets.widget({

  name: 'ol',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    var map = new ol.Map({
      target: el.id
    });

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        //el.innerText = x.message;

        // set view
        if(x.view){
          map.setView(
            new ol.View({
              center: ol.proj.fromLonLat([x.view.lon, x.view.lat]),
              zoom: x.view.zoom
            })
          );
        }

        // add osm tiles
        if(x.tiles){
          map.addLayer(
            new ol.layer.Tile({source: new ol.source.OSM()})
          );
        }

        // add xyz tiles
        if(x.xyz_url){
          map.addLayer(
            new ol.layer.Tile({
              source: new ol.source.XYZ({url: x.xyz_url})
            })
          );
        }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
