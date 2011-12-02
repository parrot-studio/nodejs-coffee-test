var Comment, MemcachedClient, app, com, express, mclient;

express = require('express');

Comment = require('./comment').Comment;

MemcachedClient = require('./memcached').MemcachedClient;

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

com = new Comment('Hello', 'World! from memcached');

mclient = new MemcachedClient();

mclient.set('test', com, 60);

app.get('/', function(req, res) {
  var render_message;
  render_message = function(rsl) {
    com = new Comment(rsl.name, rsl.body);
    return res.render('index', {
      massage: com.say()
    });
  };
  return mclient.get('test', render_message);
});

app.listen(3000);

console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
