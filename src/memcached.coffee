memcache = require 'memcache'

class MemcachedClient
  constructor: (server, port) ->
    server ?= 'localhost'
    port ?= 11211
    @client = new memcache.Client()
    @client.server = server
    @client.port = port

  get: (key, func) ->
    @client.connect()
    @client.get key, (err, rsl) -> func?(JSON.parse rsl)
    @client.close()

  set: (key, obj, expire, func) ->
    @client.connect()
    @client.set key, JSON.stringify(obj), ((err, rsl) -> func?(rsl)), expire
    @client.close()

exports.MemcachedClient = MemcachedClient
