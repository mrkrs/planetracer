// Generated by CoffeeScript 1.4.0
(function() {
  var App;

  App = (function() {

    function App() {
      var mapStyle,
        _this = this;
      mapStyle = [
        {
          "stylers": [
            {
              "color": "#000000"
            }, {
              "visibility": "off"
            }
          ]
        }, {
          "featureType": "water",
          "stylers": [
            {
              "visibility": "on"
            }, {
              "color": "#000000"
            }
          ]
        }, {
          "featureType": "landscape",
          "stylers": [
            {
              "visibility": "on"
            }, {
              "color": "#050505"
            }
          ]
        }, {}
      ];
      this.data = {};
      this.params = {};
      this.planes = {};
      this.params.map = {
        zoom: 3,
        styles: mapStyle,
        center: new google.maps.LatLng(25.958044673317843, -35.33203125),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      this.map = new google.maps.Map(document.getElementById('map_canvas'), this.params.map);
      this.count = 0;
      now.getPlane = function(data) {
        var key, plane, _results;
        _results = [];
        for (key in data) {
          plane = data[key];
          if (!(_this.planes[key] != null)) {
            _this.planes[key] = new Plane(_this.map);
          }
          _results.push(_this.planes[key].update(plane));
        }
        return _results;
      };
      return this;
    }

    return App;

  })();

  window.App = App;

}).call(this);
