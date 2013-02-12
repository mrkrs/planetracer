class Plane

    constructor: (_map) ->

        @data = {}
            
        @path = new google.maps.MVCArray;

        @histo = []
        @redisCount = 0
            
        @obj = new google.maps.Polyline({
          strokeColor: '#FFFFFF',
          strokeOpacity: 0.05,
          strokeWeight: 1.05
        })

        google.maps.event.addListener(@obj, 'click', () =>
            @obj.setMap(null)
            console.log @
        )

        @obj.setMap(_map);
        @obj.setPath(new google.maps.MVCArray([@path]));

        return @

    update: (_data) =>

        @data.type       = _data[0]
        @data.registre   = _data[1]
        @data.flynumber2 = _data[2]
        @data.l_lat      = if @data.lat? then @data.lat else null
        @data.l_lon      = if @data.lon? then @data.lon else null
        @data.lat        = _data[3]
        @data.lon        = _data[4]
        @data.alt        = _data[5]
        @data.angle      = _data[6]
        @data.speed      = _data[7]
        @data.timestamp  = _data[8]
        @data.unknow     = _data[9]
        @data.flynumber1 = _data[10]
        @data.course     = _data[11]
        
        @path.insertAt(@path.length, new google.maps.LatLng(@data.lat, @data.lon))

        @histo.push [@data.lat, @data.lon]
        @redisCount += 1

        return @

window.Plane = Plane