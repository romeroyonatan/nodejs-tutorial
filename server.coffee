http = require "http"
url = require "url"

start = (route, handle) ->
    http.createServer (request, response) ->
        pathname = url.parse(request.url).pathname
        console.log "Request for #{pathname} received."
        route handle, pathname, response
    .listen 8888
    console.log "Server has started"

exports.start = start
