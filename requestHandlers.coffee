fs = require "fs"
util = require "util"
formidable = require "formidable"

exports.start = (response) ->
    console.log "Request handler 'start' was called"
    body = '<html>'+
    '<head>'+
    '<meta http-equiv="Content-Type" content="text/html; '+
    'charset=UTF-8" />'+
    '</head>'+
    '<body>'+
    '<form action="/upload" method="post" enctype="multipart/form-data">'+
    '<input type="file" name="upload" />'+
    '<input type="submit" value="Submit text" />'+
    '</form>'+
    '</body>'+
    '</html>'

    response.writeHead 200, {"Content-Type": "text/html"}
    response.write body
    response.end()

exports.upload = (response, request) ->
    console.log "Request handler 'upload' was called"
    if request.method == "POST"
        form = new formidable.IncomingForm()
        console.log "about to parse"
        form.parse request, (error, fields, files) ->
            console.log "parsing done"
            fs.rename files.upload.path, "/tmp/test.png", (error) ->
                # if cannot rename, i will remove old file
                if error
                    fs.unlink "/tmp/test.png"
                    fs.rename files.upload.path, "/tmp/test.png"

        response.writeHead 200, {"Content-Type": "text/html"}
        response.write "received image: <br/>"
        response.write "<img src='/show'/>"
    else
        console.log "method is not POST, then redirect to /"
        response.writeHead 302, {"Location": "/"}
        response.write "Redirecting to /"
    response.end()


exports.show = (response, request) ->
    console.log "Request handler 'show' was called."
    fs.readFile "/tmp/test.png", "binary", (error, file) ->
        if error
            response.writeHead 500, {"Content-Type": "text/plain"}
            response.write "Server error"
            response.end()
        else
            response.writeHead 200, {"Content-Type": "image/png"}
            response.write file, "binary"
            response.end()
