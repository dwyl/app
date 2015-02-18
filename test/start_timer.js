var test = require('tape');
var server = require("../server.js");

test("START a NEW Timer!", function(t) {
  var timer = {
    "desc" : "Get the Party Started!"
  }

  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "New timer started! "
    + res);
    console.log(" - - - - - - - - ");
    console.dir(res.payload);
    console.log(" - - - - - - - - ");
    t.end();
    server.stop();
  });
});
