var redisClient = require('../lib/redis_connection');
var test = require('tape');

test("Confirm RedisCloud is accessible GET/SET", function(t) {
  redisClient.set('redis', 'working');
  redisClient.get('redis', function (err, reply) {
    redisClient.end();
    t.equal(reply.toString(), 'working', 'RedisCLOUD is ' +reply.toString());
    t.end();
  });
});
