var MemcachedClient, memcache;

memcache = require('memcache');

MemcachedClient = (function() {

  function MemcachedClient(server, port) {
    if (server == null) server = 'localhost';
    if (port == null) port = 11211;
    this.client = new memcache.Client();
    this.client.server = server;
    this.client.port = port;
  }

  MemcachedClient.prototype.get = function(key, func) {
    this.client.connect();
    this.client.get(key, function(err, rsl) {
      return typeof func === "function" ? func(JSON.parse(rsl)) : void 0;
    });
    return this.client.close();
  };

  MemcachedClient.prototype.set = function(key, obj, expire, func) {
    this.client.connect();
    this.client.set(key, JSON.stringify(obj), (function(err, rsl) {
      return typeof func === "function" ? func(rsl) : void 0;
    }), expire);
    return this.client.close();
  };

  return MemcachedClient;

})();

exports.MemcachedClient = MemcachedClient;
