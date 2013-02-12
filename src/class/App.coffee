class App

    constructor: () ->

        mapStyle = [
          {
            "stylers": [
              { "color": "#000000" },
              { "visibility": "off" }
            ]
          },{
            "featureType": "water",
            "stylers": [
              { "visibility": "on" },
              { "color": "#000000" }
            ]
          },{
            "featureType": "landscape",
            "stylers": [
              { "visibility": "on" },
              { "color": "#050505" }
            ]
          },{
          }
        ]

        @data = {}
        @params = {}
        @planes = {}

        @params.map = {
            zoom: 3,
            styles: mapStyle,   
            center: new google.maps.LatLng(25.958044673317843, -35.33203125),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        }
            
        @map = new google.maps.Map( document.getElementById('map_canvas'), @params.map)

        @count = 0

        now.getPlane = ( data ) =>

            for key, plane of data

                if !@planes[key]?
                    @planes[key] = new Plane(@map)

                @planes[key].update(plane)

        return @

window.App = App