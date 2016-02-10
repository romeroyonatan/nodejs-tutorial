exec = require("child_process").exec

exports.start = (response) ->
    console.log "Request handler 'start' was called"
    exec "ls -lah", (error, stdout, stderr) ->
        response.writeHead 200, {"Content-Type": "text/plain"}
        response.write stdout
        response.end()

exports.upload = (response) ->
    console.log "Request handler 'upload' was called"
    response.writeHead 200, {"Content-Type": "text/plain"}
    response.write "Hello upload"
    response.end()
