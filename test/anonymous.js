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
var JWT  = require('jsonwebtoken'); // https://github.com/docdis/learn-json-web-tokens

test(file + "Anonymous people can create timers!", function(t) {
  var options    = {
    method  : "GET",
    url     : "/anonymous"
  };
  server.inject(options, function(res) {
    console.log(res.result);
    t.equal(res.statusCode, 200, "Session Created = "+res.result.created);
    var token = res.headers.authorization;
    // use the token to start a timer:
    var decoded = JWT.verify(token, process.env.JWT_SECRET);
    console.log(file + " - - - - - - - - - - decoded token:")
    console.log(decoded);
    console.log("     ") // blank line
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
    console.log(file + "options: ");
    console.log(options);
    // server.inject lets us similate an http request
    setTimeout(function() { // give (TRAVIS) ES a chance to index the session record
      server.inject(options, function(res) {
        var T = JSON.parse(res.payload);
        console.log(file + " "+options.method + " " + options.url)
        console.log(res.payload);
        console.log("     ") // blank line
        t.equal(res.statusCode, 200, "New timer started! " + T.st);
        t.end();
        server.stop();
      });
    }, process.env.TIMEOUT || 1);

  });

});
