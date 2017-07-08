HTMLWidgets.widget({

  name: 'ol',

  type: 'output',

  factory: function(el, width, height) {

    var debug = true;
    var defaultRadius = 10;

    // functions
    function debugLog(msg) {
      if (debug) {
        console.log(msg);
      }
    }

    /* style functions */
    function getStrokeStyle(stroke) {
      return stroke ? new ol.style.Stroke({
        color: stroke.color,
        width: stroke.width
      }) : null;
    }

    function getFillStyle(fill) {
      return fill ? new ol.style.Fill({
        color: fill.color
      }) : null;
    }

    function getCircleStyle(radius, stroke, fill) {
      return new ol.style.Circle({
        stroke: getStrokeStyle(stroke),
        fill: getFillStyle(fill),
        radius: radius ? radius : defaultRadius
      });
    }

    function getIconStyle() {
      return new ol.style.Icon(/** @type {olx.style.IconOptions} */({
        //anchor: [0.5, 46],
        //anchorXUnits: 'fraction',
        //anchorYUnits: 'pixels',
        //src: "https://openlayers.org/en/v4.2.0/examples/data/icon.png"
        //TODO: use base64 images or try to 'guess' path
        src: "lib/ol-4.2.0/images/marker-icon.png"
      }));
    }

    function getStyle(_style) {
      return new ol.style.Style({
        image: _style.marker ? getIconStyle() :
          getCircleStyle(_style.radius, _style.stroke, _style.fill),
        stroke: getStrokeStyle(_style.stroke),
        fill: getFillStyle(_style.fill)
      });
    }

    // TODO: OBSOLETE!?
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

    return {

      renderValue: function(x) {

        //el.innerText = x.message;

        // set view
        if(x.view) {
          debugLog(x.view);
          map.setView(new ol.View({
            center: ol.proj.fromLonLat([x.view.lon, x.view.lat]),
            zoom: x.view.zoom
          }));
        }

        // add scale line to map
        if(x.scale_line) {
          map.addControl(new ol.control.ScaleLine({
            units: x.scale_line.units
          }));
        }

        // add osm tiles
        if(x.osm_tiles) {
          debugLog("OSM!");
          map.addLayer(new ol.layer.Tile({
            source: new ol.source.OSM()
          }));
        }

        // add stamen tiles
        if(x.stamen_tiles) {
          debugLog("STAMEN!");
          debugLog(x.stamen_tiles);
          map.addLayer(new ol.layer.Tile({
            source: new ol.source.Stamen({layer: x.stamen_tiles})
          }));
        }

        // add xyz tiles
        if(x.xyz_url) {
          map.addLayer(new ol.layer.Tile({
            source: new ol.source.XYZ({url: x.xyz_url})
          }));
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

        // add geojson vector layer from url (or file)
        // TODO: check whether file will also works (path issue? RMarkdown may work!)
        if(x.ds){
          debugLog(x.ds);

          map.addLayer(new ol.layer.Vector({
            source: new ol.source.Vector({
              url: x.ds.url,
              format: new ol.format.GeoJSON()
              /*
              features: (new ol.format.GeoJSON()).readFeatures(x.ds.filename, {
                dataProjection: "",
                featureProjection: "EPSG:3857"
              })
              */
            }),
            style: getStyle(x.ds.style)
          }));
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
            })
          });

          map.addLayer(new ol.layer.Vector({
            // TODO: set main opacity via parameter
            //opacity: 1.0,
            source: dataSource,
            style: getStyle(x.geojson.style)
          }));

          map.getView().fit(dataSource.getExtent());
        }

      // END renderValue
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
