statik = require('node-static')
file   = new(statik.Server)('./public')
redis  = require("redis")
fs     = require('fs')
request = require("request")

@planes      = {}
@requestsNBR = 0
@start       = 0

# stream = fs.createWriteStream('test.csv')
# stream.write( "id, key\n")

httpServer = require('http').createServer( (request, response) ->
    request.addListener('end', () -> file.serve(request, response) )
).listen(8181);

nowjs    = require("now");
everyone = nowjs.initialize(httpServer);

####################################################################

client = redis.createClient(7777)

####################################################################

everyone.now.test = =>
    @start = new Date().getTime()
    requestAPI()

updatePlane = (_data) =>

    data = _data.planes 
    @requestsNBR += 1

    updates = {}
    creates = 0
    for pack in data

        for _key, plane of pack

            key = "#{_key} | #{plane[1]} | #{plane[10]} / #{plane[2]}"

            if !@planes[key]?
                creates += 1
                @planes[key] = new Plane(key)

            @planes[key].update(plane, (key, data) =>
                updates[key] = data
            )

    count = 0
    for key of updates
        count += 1

    planes = 0
    for key of @planes
        planes += 1


    console.log "PLANES : #{planes} | UPDATES : #{count} | CREATES : #{creates}"

    broadcast( updates )
    everyone.now.log( {updates:count, planes:planes, creates:creates, requests:@requestsNBR, start:@start}  )


requestAPI = (callback) ->

    now = new Date().getTime()

    console.log 'requesting ...'

    request("http://planefinder.net/endpoints/update.php?faa=1", (error, response, body) ->
        console.log 'received.'
        result = JSON.parse( body )
        updatePlane( result )

        setTimeout( ->
            requestAPI()
        ,1000)

    )

store = (key, value) ->

    client.set( 
        key,
        JSON.stringify( plane ),
        -> stream.write( "#{id}, #{key}\n")
    )

broadcast = (data) ->

    everyone.now.getPlane( data )

class Plane

    constructor: (_key) ->

        @key        = _key
        @data       = {}
        @histo      = []
        @redisCount = 0

        return @

    update: (_data, callback) ->

        test = @test(_data)
        # test = true

        if test

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

            @histo.push [@data.lat, @data.lon]
            @redisCount += 1

            callback( @key, _data )

        return @

    test: (_data) ->

        _lat = _data[3]
        _lon = _data[4]
        _ref = false

        for point in @histo
            if point[0] is _lat and point[1] is _lon
                _ref = true

        if !_ref

            if @data.lat? and @data.lon
                dlat = Math.abs( @data.lat - _lat )
                dlon = Math.abs( @data.lon - _lon )

                if dlat < 1 and dlon < 1

                    return true

                else 

                    return false

            else 

                return true

        else 

            return false        