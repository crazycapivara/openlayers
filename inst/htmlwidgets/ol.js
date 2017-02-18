HTMLWidgets.widget({

  name: 'ol',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    var map = new ol.Map({
      target: el.id
      //renderer: 'canvas'
    });

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        //el.innerText = x.message;

        // set view
        if(x.view){
          console.log(x.view);
          map.setView(
            new ol.View({
              center: ol.proj.fromLonLat([x.view.lon, x.view.lat]),
              zoom: x.view.zoom
            })
          );
        }

        // add osm tiles
        if(x.osm_tiles){
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

        // add earthquakes
        if(x.earthquakes_url){
          map.addLayer(
            new ol.layer.Vector({
              //title: 'Earthquakes',
              source: new ol.source.Vector({
                url: x.earthquakes_url,
                format: new ol.format.GeoJSON()
              })
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
