var test = require('tape');
var server = require("../server.js");

test("GET timer /timer/1 (invalid timer id) should return 404", function(t) {
  var options = {
    method: "GET",
    url: "/timer/1"
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    t.equal(response.statusCode, 404, "No records at startup");
    t.end();
  });
});
