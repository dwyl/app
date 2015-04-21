var redisClient = require('../lib/redis_connection');
var test = require('tape');
// https://nodejs.org/docs/latest/api/globals.html#globals_require_cache
var uncache = require('./uncache').uncache;

test("Confirm RedisCloud is accessible GET/SET", function(t) {
  redisClient.set('redis', 'working');
  redisClient.get('redis', function (err, reply) {
    redisClient.end();
    t.equal(reply.toString(), 'working', 'RedisCLOUD is ' +reply.toString());
    t.end();
  });
});

// test("Check LOCAL Redis is accessible GET/SET", function(t) {
//   var REDISCLOUD_URL = process.env.REDISCLOUD_URL;
//   process.env.REDISCLOUD_URL = false;
//   uncache('../lib/redis_connection'); // uncache so we can re-connect
//   var redisClient = require('../lib/redis_connection');
//   redisClient.set('redis', 'working');
//   redisClient.get('redis', function (err, reply) {
//     redisClient.end();
//     t.equal(reply.toString(), 'working', 'LOCAL Redis is ' +reply.toString());
//     process.env.REDISCLOUD_URL = REDISCLOUD_URL; // restore redisCloud
//     uncache('../lib/redis_connection'); // uncache so we can re-connect
//     t.end();
//   });
// });
