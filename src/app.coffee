express = require 'express'
app = express.createServer()
#util = require 'util'

Comment = require('./comment').Comment
com = new Comment 'Hello', 'World!'

#console.log util.inspect com

app.get '/', (req, res) ->
  res.send com.say()

app.listen 3000
