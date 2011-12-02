var Comment, app, com, express;

express = require('express');

app = module.exports = express.createServer();

app.configure(function() {
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  return app.use(express.static(__dirname + '/public'));
});

app.configure('development', function() {
  return app.use(express.errorHandler({
    dumpExceptions: true,
    showStack: true
  }));
});

app.configure('production', function() {
  return app.use(express.errorHandler());
});

Comment = require('./comment').Comment;

com = new Comment('Hello', 'World!');

app.get('/', function(req, res) {
  return res.send(com.say());
});

app.listen(3000);
