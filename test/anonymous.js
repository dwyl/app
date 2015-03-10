var test   = require('tape');
var server = require("../server.js");

test("test/anonymous.js -> GET /anonymous ", function(t) {
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

test("test/anonymous.js -> Anonymous people can create timers!", function(t) {
  var options    = {
    method  : "GET",
    url     : "/anonymous"
  };
  server.inject(options, function(res) {
    // t.equal(res.statusCode, 200, res.result);
    var token = res.headers.authorization;
    // use the token to start a timer:
    var timer = {
      "desc" : "We're going to Ibiza!",
      "st" : new Date().toISOString()
    }
    var options = {
      method: "POST",
      url: "/timer/new",
      payload: timer,
      headers : { authorization : token }
    };
    // server.inject lets us similate an http request
    server.inject(options, function(res) {
      var T = JSON.parse(res.payload);
      console.log(res.payload);
      t.equal(res.statusCode, 200, "New timer started! " + T.st);
        t.end();
        server.stop();
      // });
    });
  });
});
