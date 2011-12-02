express = require 'express'
app = module.exports = express.createServer()
#util = require 'util'

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/public')

app.configure 'development', ->
  app.use express.errorHandler({dumpExceptions: true, showStack: true })

app.configure 'production', -> app.use express.errorHandler()



Comment = require('./comment').Comment
com = new Comment 'Hello', 'World!'

#console.log util.inspect com

app.get '/', (req, res) ->
  res.send com.say()

app.listen 3000
