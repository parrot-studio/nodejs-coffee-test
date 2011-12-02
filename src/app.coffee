express = require 'express'
#util = require 'util'

# app
app = module.exports = express.createServer()

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/public')

app.configure 'development', ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure 'production', -> app.use express.errorHandler()

# main
Comment = require('./comment').Comment
com = new Comment 'Hello', 'World!'

#console.log util.inspect com

app.get '/', (req, res) ->
  res.render 'index',
    massage: com.say()

app.listen 3000

console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
