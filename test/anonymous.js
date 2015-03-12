var test   = require('tape');
var server = require("../server.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";

test(file + "GET / Warm Up the Engine", function(t) {
  var options = {
    method: "GET",
    url: "/"
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    t.equal(response.statusCode, 200, "Welcome to Timer Land Anonymous person!");
    t.end();
  });
});

test(file + "GET /anonymous ", function(t) {
  var options    = {
    method  : "GET",
    url     : "/anonymous"
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, res.result);
    t.end();
    server.stop();
  });
});

test(file + "Anonymous people can create timers!", function(t) {
  var options    = {
    method  : "GET",
    url     : "/anonymous"
  };
  server.inject(options, function(res) {
    // t.equal(res.statusCode, 200, res.result);
    var token = res.headers.authorization;
    // use the token to start a timer:
    var timer = {
      "desc" : "Anonymous people deserve a voice too!",
      "st" : new Date().toISOString()
    }
    var options = {
      method: "POST",
      url: "/timer/new",
      payload: timer,
      headers : { authorization : token }
    };
    // server.inject lets us similate an http request
    // setTimeout(function() { // give ES a chance to index the session record
      server.inject(options, function(res) {
        var T = JSON.parse(res.payload);
        // console.log(" - - - - - test/anonymous.js -> /timer/new res - - - - - ")
        // console.log(res.payload);
        t.equal(res.statusCode, 200, "New timer started! " + T.st);
        t.end();
        server.stop();
      });
    // }, 500);

  });

});
