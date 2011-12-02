express = require 'express'

Comment = require('./comment').Comment
MemcachedClient = require('./memcached').MemcachedClient
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
com = new Comment 'Hello', 'World! from memcached'
mclient = new MemcachedClient()
mclient.set('test', com, 60)

app.get '/', (req, res) ->
  render_message = (rsl) ->
    com = new Comment rsl.name, rsl.body
    res.render 'index',
      massage: com.say()

  mclient.get 'test', render_message

app.listen 3000

console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
