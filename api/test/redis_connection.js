var uncache = require('./uncache').uncache;
// https://nodejs.org/docs/latest/api/globals.html#globals_require_cache
uncache('../lib/redis_connection'); // uncache redis connection then re-connect
var redisClient = require('../lib/redis_connection');

var test = require('tape');

test("Confirm RedisCloud is accessible GET/SET", function(t) {
  redisClient.set('redis', 'working');
  redisClient.get('redis', function (err, reply) {
    t.equal(reply.toString(), 'working', 'RedisCLOUD is ' +reply.toString());
    redisClient.end();
    t.end();
  });
});

// test("Confirm RedisCloud is accessible GET/SET", function(t) {
//   redisClient.set('redis', 'working');
//   redisClient.get('redis', function (err, reply) {
//     redisClient.end();
//     t.equal(reply.toString(), 'working', 'RedisCLOUD is ' +reply.toString());
//     t.end();
//   });
// });
