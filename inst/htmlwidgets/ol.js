HTMLWidgets.widget({

  name: 'ol',

  type: 'output',

  factory: function(el, width, height) {

    var debug = true;

    // functions
    function debugLog(msg){
      if(debug){
        console.log(msg);
      }
    }

    function getStrokeStyle(stroke){
      return stroke ? new ol.style.Stroke({
        color: stroke.color,
        width: stroke.width
      }) : false;
    }

    function getFillStyle(fill){
      return fill ? new ol.style.Fill({
        color: fill.color
      }) : false;
    }

    function getCircleStyle(radius, stroke, fill){
      return new ol.style.Circle({
        stroke: stroke,
        fill: fill,
        radius: radius ? radius : 10
      });
    }

    // TODO: define shared variables for this instance
    var geojsonObject = {
        'type': 'FeatureCollection',
        'crs': {
          'type': 'name',
          'properties': {
            'name': 'EPSG:3857'
          }
        },
        'features': [{
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [0, 0]
          }
        }, {
          'type': 'Feature',
          'geometry': {
            'type': 'LineString',
            'coordinates': [[4e6, -2e6], [8e6, 2e6]]
          }
        }]
      };

    var map = new ol.Map({
      target: el.id,
      view: new ol.View({
        center: [0, 0],
        zoom: 2
      })
      //renderer: 'canvas'
    });
    //var map = new ol.Map(el);

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        //el.innerText = x.message;
        console.log(x.func(10));


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
          debugLog("OSM!");
          map.addLayer(
            new ol.layer.Tile({source: new ol.source.OSM()})
          );
        }

        // add stamen tiles
        if(x.stamen_tiles){
          debugLog("STAMEN!");
          map.addLayer(
            new ol.layer.Tile({
              source: new ol.source.Stamen({layer: x.stamen_tiles})
            })
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
        // countries: https://raw.githubusercontent.com/datasets/geo-boundaries-world-110m/master/countries.geojson
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

        // add geojson vector layer from file, OBSOLETE!?
        if(x.dsn){
          console.log(JSON.stringify(x.dsn));
          x.dsn = JSON.parse(x.dsn);
          console.log(x.dsn);
          console.log(geojsonObject);
          map.addLayer(
            new ol.layer.Vector({
              source: new ol.source.Vector({
                //defaultProjection :'EPSG:4326',
                //projection: 'EPSG:3857',
                //projection: "EPSG:4326",
                //url: x.dsn,
                //format: new ol.format.GeoJSON()
                features: (new ol.format.GeoJSON()).readFeatures(
                  x.dsn, {dataProjection: "",featureProjection: "EPSG:3857"})
              })
            })
          );
        }

        // add geojson vector layer to map
        if(x.geojson) {
          debugLog(x.geojson.style);

          var format = new ol.format.GeoJSON();
          var dataSource = new ol.source.Vector({
            features: format.readFeatures(x.geojson.data, {
                // TODO: get projection from data source
                dataProjection: "",
                featureProjection: "EPSG:3857"
              }
            )
          });

          var stroke =  getStrokeStyle(x.geojson.style.stroke);
          var fill = getFillStyle(x.geojson.style.fill);

          var style = new ol.style.Style({
            image: getCircleStyle(x.geojson.style.radius, stroke, fill),
            stroke: stroke,
            fill: fill
          });

          map.addLayer(
            new ol.layer.Vector({
              // TODO: set main opacity via parameter
              //opacity: 1.0,
              source: dataSource,
              style: style
            })
          );

          map.getView().fit(dataSource.getExtent());
        }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
