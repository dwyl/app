var redis = require('redis');
var url   = require('url');
var Hoek  = require('hoek'); // hapi utilities https://github.com/hapijs/hoek
var redisClient, redisURL;
Hoek.assert(process.env.REDISCLOUD_URL,
  'Please Set the REDISCLOUD_URL');
redisURL    = url.parse(process.env.REDISCLOUD_URL);
redisClient = redis.createClient(redisURL.port, redisURL.hostname,
                  {no_ready_check: true});
redisClient.auth(redisURL.auth.split(":")[1]);
module.exports = redisClient;
