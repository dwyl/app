var test = require('tape');
var server = require("../server.js");

test("Warm Up the Engine", function(t) {
  var options = {
    method: "GET",
    url: "/home"
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    t.equal(response.statusCode, 200, "Welcome to Timer Land");
    t.end();
  });
});
