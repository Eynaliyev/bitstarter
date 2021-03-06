express = require 'express'
path = require 'path'
http = require 'http'
fs = require 'fs'

app = express()
app.configure () ->
    app.set 'port', process.env.PORT || 3000
    app.set 'views', "#{__dirname}/views"
    app.set 'view engine', 'jade'
    app.use express.favicon()
    app.use express.logger('dev')
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use app.router
    app.use require('stylus').middleware("#{__dirname}/public")
    app.use express.static(path.join(__dirname, 'public'))

app.configure 'development', () ->
    app.use express.errorHandler()



app.get '/', (req, res) ->
    index = fs.readFileSync 'public/index.html', 'utf8'
    res.end index



http.createServer(app).listen app.get('port'), () ->
    console.log "Express server listening on port #{app.get('port')}"
