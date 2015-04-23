var test   = require('tape');
var server = require("../../web.js");

// https://nodejs.org/docs/latest/api/globals.html#globals_require_cache
var uncache = require('./uncache').uncache;
var redisClient = require('../lib/redis_connection');

var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";

test(file + "GET timer /timer/1 (invalid timer id) should return 404", function(t) {
  var options = { method : "GET", url : "/anonymous" };
  server.inject(options, function(res) {
    var token = res.headers.authorization;
    var options = {
      method: "GET",
      url: "/timer/1",
      headers : { authorization : token }
    };
    server.inject(options, function(response) {
      t.equal(response.statusCode, 404, "Record did not exist, as expected");
      server.stop();
      t.end();
    });
  });
});

test(file + "GET /timer/:id retrieve our timer", function(t) {
  var options = { method : "GET", url : "/anonymous" };
  server.inject(options, function(res1) {
    var token = res1.headers.authorization;
    var timer = {
      "desc" : "Timers are awesome!",
      "start" : new Date().toISOString()
    }
    var options = {
      method: "POST",
      url: "/timer/new",
      payload: timer,
      headers : { authorization : token }
    };
    // create a new timer record
    server.inject(options, function(res2) {
      var T = JSON.parse(res2.payload);
      // console.log(' - - - - - - - - - - - - - - - -')
      t.equal(res2.statusCode, 200, "Record created "+T.start);

      // now lookup this newly created timer record:
      var options = {
        method: "GET",
        url: "/timer/"+T.id,
        headers : { authorization : token }
      };
      server.inject(options, function(res3){

        var T = JSON.parse(res3.payload);
        t.equal(T.desc, timer.desc, "Found timer by GET: "+options.url);

        redisClient.end();
        uncache('../lib/redis_connection'); // uncache redis connection!
        server.stop();
        t.end();
      }); // GET /timer/:id
    });
  });
});
